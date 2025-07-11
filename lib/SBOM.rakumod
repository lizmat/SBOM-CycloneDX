use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;
use SBOM::enums:ver<0.0.3>:auth<zef:lizmat> <Enumify>;

#- SBOM ------------------------------------------------------------------------
role SBOM:ver<0.0.3>:auth<zef:lizmat> {

    # Hidden attribute that collects pairs with errors, in which the
    # key is is the crumbs of where the error happened, and the value
    # is the actual exception.
    has @.build-errors is built(False);

    # This code is run at compile time when the role is being consumed.
    # So this effectively creaes constants, hence the .Map and .List
    # to ensure immutability.

    # The attributes of the class, so we don't need to introspect
    # at runtime
    my @attributes is List = $?CLASS.^attributes.grep(*.is_built);

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
    multi method new(::?CLASS: :$raw-error = False, *%in) {

        # Inner SBOM creation logic
        with $*RAW-ERROR {
            self!ingest(%in)
        }

        # Outer SBOM creation logic
        else {
            my $*RAW-ERROR = $raw-error;
            my @*CRUMBS;
            my @*ERRORS;

            my $sbom := self!ingest(%in);
            $sbom.defined
              ?? $sbom!set-build-errors
              !! $sbom
        }
    }

    # Instantiate from a path, either as a string or as an IO object
    multi method new(::?CLASS: IO(Str) $io, :$raw-error = False) {
        self.new(:$raw-error, |from-json $io.slurp)
    }

    # Helper method to set @*ERRORS on the outer SBOM object
    method !set-build-errors() {
        @!build-errors := @*ERRORS;
        self
    }

    # Basic error handling
    my sub handle-error($_) {
        $*RAW-ERROR
          ?? .rethrow
          !!  @*ERRORS.push(@*CRUMBS.join("/") => $_);
    }

    # The actual instantiation logic, setting @*CRUMBS as appropriate
    method !ingest(%in) {
        my %out;

        # Mark we're in this class
        @*CRUMBS.push($?CLASS.^name.subst("SBOM::"));

        CATCH {
            handle-error($_);
            @*CRUMBS.pop;
            return Nil;
        }

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
                        for value.grep(*.defined) {
                            @out.push($_ ~~ Enumify ?? $_ !! $type($_));
                        }
                    }
                    elsif $type ~~ Cool | Pair {
                        # Makes sure any types are checked
                        @out = value.grep(*.defined)
                    }
                    elsif $type ~~ DateTime {
                        for value.grep(*.defined) {
                            @out.push($_ ~~ DateTime ?? $_ !! .DateTime);
                        }
                    }
                    elsif $type ~~ SBOM {
                        for value.grep(*.defined) {
                            @out.push($_ ~~ SBOM ?? $_ !! $type.new(|$_));
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
                    with value {
                        my sub ingest($args) {
                            CATCH {
                                handle-error($_);
                                return;
                            }
                            %out{$name} := $type.new(|$args)
                        }($_)
                    }
                }
                elsif $type ~~ Enumify {
                    %out{$name} := $_ ~~ Enumify ?? $_ !! $type($_) with value;
                }
                elsif $type ~~ DateTime {
                    %out{$name} := $_ ~~ DateTime ?? $_ !! .DateTime with value;
                }
                elsif value ~~ Cool {
                    %out{$name} := $_ with value;
                }
                elsif $type ~~ SBOM {
                    %out{$name} := $_ ~~ SBOM ?? $_ !! $type.new(|$_) with value;
                }
                else {
                    die "Don't know how to handle type $type.^name()";
                }
            }
        }

        # Delete any schema related attributes for now
        %in{$_}:delete for %in.keys.grep(*.starts-with('$'));

        # Not all input arguments accounted for, either save as additional
        # properties if supported, or call it a day.
        if %in {
            if %attribute<additional-properties> {
                %out<additional-properties> := %in.pairs.List;
            }
            else {
                die "Found extra keys: %in.keys.sort.join(", ")";
            }
        }

        my $result := do if %out || %required {
            self.bless: |%out
        }
        else {
            Nil
        }

        @*CRUMBS.pop;
        $result
    }

    # Cannot use the standard .raku semantics, as that would process
    # the arguments before processing their parent, which has all sorts
    # of weird effects, specifically in error reporting.  So instead
    # producing .raku output for each sub-class, just generate the
    # .Map of the arguments and flatten that as the arguments.
    multi method raku(::?CLASS:D:) {
        self.^name ~ ".new(|" ~ self.Map.raku ~ ")"
    }

    # Type objects get a empty Map
    multi method Map(::?CLASS:U:) { Map.new }

    # Produce a Map for the object, recursively if necessary.  Takes
    # an optional :ordered named argument to create a special type of
    # map that will produce keys in the attribute definition order.
    multi method Map(::?CLASS:D: :$ordered) {

        # This role allows to-json to generate all hashes in the order
        # of the attributes by mixing in a "list" method, which is what
        # JSON::Fast uses internally on any associative translation to
        # JSON.  Because roles do *NOT* close over the scope they're in,
        # we need to parameterize the role to be mixed in with the names
        # of the attributes.
        my role ordered-list[@NAMES] {
            method list() {
                @NAMES.map({
                    Pair.new($_, self.AT-KEY($_)) if self.EXISTS-KEY($_);
                }).List
            }
        }

        # Set up list of keys to render, may have additional keys
        my @keys = @names;

        # Create initial version of the Map
        my $map := @names.map(-> $name {
            my $value := self."$name"();
            my $type  := %type{$name};

            # Generic mapification logic
            sub mapify($value) {
                $type ~~ Cool
                  ?? $value
                  !! ($type ~~ Enumify)
                    ?? $value ~~ Enumify
                      ?? $value.name
                      !! $value
                    !! ($type ~~ DateTime)
                      ?? $value ~~ DateTime
                        ?? $value.Str
                        !! $value
                      !! $value.Map(:$ordered)
            }

            # Have additional properties, so add them
            if $name eq 'additional-properties' {
                $value.map({ @keys.push(.key); $_}).Slip
            }

            # An array of sort, add them if they're not empty
            elsif %positional{$name} {
                if $value.elems {
                    $name => $value.map(&mapify).List
                }
            }

            # A single value
            else {
                $name => mapify($_) with $value;
            }
        }).Map;

        $ordered ?? $map but ordered-list[@keys] !! $map
    }

    # Produce the JSON for the invocant
    method JSON(::?CLASS:D: --> Str:D) {
        to-json(self.Map(:ordered))
    }

    # Helper method for required array attributes: the "is required"
    # argument just checks whether it was specified, but not whether
    # any elements were specified: so calling this method with the
    # attribute in question as argument, will check for elements and
    # add an error if no elements are specified
    method must-have-elements(\attribute) is hidden-from-backtrace {
        handle-error(X::Attribute::Required.new(
          name => attribute.VAR.name,
          why => "Must have at least one element specified"
        )) unless attribute.elems;
    }
}

# vim: expandtab shiftwidth=4
