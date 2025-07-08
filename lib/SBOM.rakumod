use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;
use SBOM::enums:ver<0.0.2>:auth<zef:lizmat> <Enumify>;

#- SBOM ------------------------------------------------------------------------
role SBOM:ver<0.0.2>:auth<zef:lizmat> {

    # This code is run at compile time when the role is being consumed.
    # So this effectively creaes constants, hence the .Map and .List
    # to ensure immutability.

    # The attributes of the class, so we don't need to introspect
    # at runtime
    my @attributes is List = $?CLASS.^attributes;

    # Attribute name to attribute object mapping: can also be used to
    # see if a name corresponds to a valid attribute
    my %attribute is Map  = @attributes.map: { .name.substr(2) => $_ }

    # The attribute names in order of definition
    my @names is List = @attributes.map(*.name.substr(2));

    # Attribute name to positional mapper: returns True for an
    # attribute name if it was defined with a @ sigil
    my %positional is Map = @names.map: -> $name {
        $name => True if %attribute{$name}.type ~~ Positional
    }

    # Attribute name to required flag, if attribute was specified
    # with "is required".
    my %required is Map = @names.map: -> $name {
        $name => True if %attribute{$name}.required;
    }

    # Attribute name to type mapper, hiding any Positional wrapping
    my %type is Map = @names.map: -> $name {
        my $type := %attribute{$name}.type;
        $name => $type ~~ Positional ?? $type.of !! $type
    }

    # The instantiator method, using standard .new semantics, except
    # that it will return Nil if no named arguments were given
    multi method new(::?CLASS: *%in) {
        my %out;

        # Process any defined value without container in attribute order
        for @names.grep({ %in{$_}.defined }) -> $name {
            my \value := (%in{$name}:delete)<>;
            my $type  := %type{$name};

            # We potentially got multiple values
            if %positional{$name} {
                # Handle if there any elements in there
                if +value {
                    my @out := Array[$type].new;

                    if $type ~~ Enumify {
                        @out.push($type($_)) for value;
                    }
                    elsif $type ~~ Cool {
                        # Makes sure any types are checked
                        @out = value;
                    }
                    elsif $type ~~ DateTime {
                        @out.push(.DateTime) for value;
                    }
                    elsif $type ~~ SBOM {
                        for value {
                            if $_ ~~ SBOM {
                                @out.push($_) if .defined;
                            }
                            else {
                                @out.push($type.new(|$_));
                            }
                        }
                    }
                    else {
                        die "Don't know how to handle type $type.^name()";
                    }

                    %out{$name} := @out if @out;
                }
            }

            # Only a single value allowed
            else {
                if value ~~ Associative {
                    %out{$name} := $type.new(|$_) with value;
                }
                elsif value ~~ Enumify {
                    %out{$name} := value;
                }
                elsif $type ~~ Enumify {
                    %out{$name} := $_ with $type(value);
                }
                elsif $type ~~ DateTime {
                    %out{$name} := .DateTime with value;
                }
                elsif value ~~ SBOM | Cool {
                    %out{$name} := $_ with value;
                }
                elsif $type ~~ SBOM {
                    %out{$name} := $_ with $type.new(|value);
                }
                else {
                    die "Don't know how to handle type $type.^name()";
                }
            }
        }

        if %out || %required {
            self.bless: |%out;
        }
        else {
            Nil
        }
    }

    # Standard .raku semantics, but skips any type objects or empty
    # Positionals
    multi method raku(::?CLASS:D:) {
        my str @parts;

        for @names -> $name {
            with self."$name"() -> $value is raw {
                if $value ~~ Positional {
                    @parts.push: "$name => $value.raku()"
                      if $value.elems;
                }
                else {
                    @parts.push: "$name => $value.raku()";
                }
            }
        }
        self.^name ~ ".new(@parts.join(", "))"
    }

    # Produce a Map for the object, recursively if necessary.  Takes
    # an optional :ordered named argument to create a special type of
    # map that will produce keys in the attribute definition order.
    method Map(::?CLASS:D: :$ordered) {

        # This role allows to-json to generate all hashes in the order
        # of the attributes by mixing in a "list" method, which is what
        # JSON::Fast uses internally on any associative translation to
        # JSON.  Because roles do *NOT* close over the scope they're in,
        # we need to parameterize the role to be mixed in with the names
        # of the attributes.
        my role ordered-list[@NAMES] {
            method list() {
                @NAMES.map({
                    Pair.new($_, self.AT-KEY($_)) if self.EXISTS-KEY($_)
                }).List
            }
        }

        my $map := @names.map(-> $name {
            my $value := self."$name"();
            my $type  := %type{$name};

            sub mapify($value) {
                $type ~~ Cool
                  ?? $value
                  !! ($type ~~ Enumify)
                    ?? $value.name
                    !! ($type ~~ DateTime)
                      ?? $value.Str
                      !! $value.Map(:$ordered)
            }

            if %positional{$name} {
                if $value.elems {
                    $name => $value.map(&mapify).List
                }
            }
            else {
                $name => mapify($_) with $value;
            }
        }).Map;

        $ordered ?? $map but ordered-list[@names] !! $map
    }

    # Produce the JSON for the invocant
    method JSON(::?CLASS:D: --> Str:D) {
        to-json(self.Map(:ordered))
    }
}

# vim: expandtab shiftwidth=4
