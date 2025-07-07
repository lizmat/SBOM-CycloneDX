use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;
use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <Enumify>;

role SBOM:ver<0.0.1>:auth<zef:lizmat> {

    my @attributes  is List = $?CLASS.^attributes;
    my %attributes  is Map  = @attributes.map: { .name.substr(2) => $_ }
    my @sorted-keys is List = @attributes.map(*.name.substr(2));

    my sub type-of(Attribute:D $attribute) {
        my $type := $attribute.type;
        $type ~~ Positional ?? $type.of !! $type
    }

    multi method new(::?CLASS: *%in) {
        my %out;

        if %in {
            for @sorted-keys -> $name {

                my sub multi-value($type) {
                    my $values := %in{$name}:delete<>;

                    my @out;
                    if $type ~~ Enumify {
                        @out.push($type($_)) for $values;
                    }
                    elsif $type ~~ Cool {
                        @out := $values;
                    }
                    elsif $type ~~ DateTime {
                        @out.push(.DateTime) for $values;
                    }
                    elsif $type ~~ SBOM {
                        $type.new(|$_) for $values;
                    }
                    else {
                        die "Don't know how to handle type $type.^name()";
                    }

                    %out{$name} := @out if @out;
                }

                my sub single-value($type) {
                    %out{$name} := $type ~~ Enumify
                      ?? $type(%in{$name}:delete)
                      !! $type ~~ Cool
                        ?? (%in{$name}:delete)
                        !! $type ~~ DateTime
                          ?? (%in{$name}:delete).DateTime
                          !! $type ~~ SBOM
                            ?? $type.new(|(%in{$name}:delete)<>)
                            !! die "Don't know how to handle type $type.^name()";
                }

                if %in{$name}:exists {
                    my $attribute := %attributes{$name};
                    my $type := type-of($attribute);
                    $attribute.type ~~ Positional
                      ?? multi-value($type)
                      !! single-value($type);
                }
            }
        }

        if %out {
            self.bless: |%out;
        }
        else {
            Nil
        }
    }

    method Map(::?CLASS:D:) {
        @attributes.map(-> $attribute {
            my $type   := type-of($attribute);
            my $name   := $attribute.name.substr(2);
            my $method := self.^find_method($name);
            
            Pair.new: $name, $type ~~ Cool
              ?? $method(self)
              !! ($type ~~ Enumify)
                ?? self.name
                !! ($type ~~ DateTime)
                  ?? $method(self).Str
                  !! $method(self).Map;
        }).Map
    }

    method JSON(::?CLASS:D:) {

        my sub jsonify($target) {
            to-json($target.Map, :@sorted-keys).indent($*SBOM-INDENT)
        }

        with $*SBOM-INDENT {
            $*SBOM-INDENT += 2;
            jsonify(self);
            $*SBOM-INDENT -= 2;
        }
        else {
            my $*SBOM-INDENT = 0;
            jsonify(self)
        }
    }
}

# vim: expandtab shiftwidth=4
