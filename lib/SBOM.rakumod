use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;
use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <Enumify>;

role SBOM:ver<0.0.1>:auth<zef:lizmat> {

    my @sorted-keys is List = $?CLASS.^attributes.map(*.name.substr(2));

    multi method new(::?CLASS: *%_) {
        if %_ {
            self.bless: |%_;
        }
        else {
            Nil
        }
    }

    method Map(::?CLASS:D:) {
        self.^attributes.map(-> $attribute {
            my $type   := $attribute.type;
            $type      := $type.of if $type ~~ Positional;
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
