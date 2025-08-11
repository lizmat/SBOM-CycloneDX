use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;
use SBOM::enums:ver<0.0.13>:auth<zef:lizmat> <Enumify>;
use YAMLish:ver<0.1.2+>:auth<zef:leont>;

#- SBOM ------------------------------------------------------------------------
role SBOM:ver<0.0.13>:auth<zef:lizmat> {  # UNCOVERABLE

    # Hidden attribute to store any extra information, such as build
    # errors and bom-refs seen.  Supports the following keys:
    #
    # build-errors
    # Array with pairs with errors, in which the key is is the crumb
    # trail of where the error happened, and the value is the actual
    # exception.
    #
    # bom-refs
    # Map with bom-ref as key, and object instance as value
    has %!additional-object-info is built(False);

    # Give access to the build errors
    method build-errors(::?CLASS:D:) {
        %!additional-object-info<build-errors> // ()
    }

    # Give access to the bom-refs seen
    method bom-refs(::?CLASS:D:) {
        %!additional-object-info<bom-refs> // Map.new
    }

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

    # Flag: whether there is an attribute called "bom-ref"
    my $has-bom-ref = ?@names.first(* eq 'bom-ref');

    # Allow consumers to specify additional named arguments (for which
    # there is no direct attribute mapping) that will be handled by a
    # TWEAK method
    method TWEAK-nameds(::?CLASS:) { () }

    # Attribute name to positional mapper: returns True for an
    # attribute name if it was defined with a @ sigil
    my %positional is Map = @names.map: -> $name {
        $name => True if %attribute{$name}.type ~~ Positional;  # UNCOVERABLE
    }

    # Attribute name to required flag, if attribute was specified
    # with "is required".
    my %required is Map = @names.map: -> $name {
        $name => True if %attribute{$name}.required;  # UNCOVERABLE
    }

    # Attribute name to type mapper, hiding any Positional wrapping
    my %type is Map = @names.map: -> $name {
        my $type := %attribute{$name}.type;
        $name => $type ~~ Positional ?? $type.of !! $type  # UNCOVERABLE
    }

    # The instantiator method, using standard .new semantics, except
    # that it will return Nil if no named arguments were given
    multi method new(::?CLASS: :$raw-error = False, *%in) {
        self.ingest($raw-error, %in)
    }

    # Instantiate from a path, either as a string or as an IO object
    multi method new(::?CLASS: IO(Str) $io, :$raw-error = False) {
        my $basename := $io.basename;
        my &loader = &from-json;
           &loader = &load-yaml if $basename.ends-with(".yml" | ".yaml");
        self.ingest($raw-error, loader $io.slurp)
    }

    method ingest($raw-error, %in) is implementation-detail {

        # Inner SBOM creation logic
        with $*RAW-ERROR {
            self!ingest(%in)
        }

        # Outer SBOM creation logic
        else {
            # Save the initial setting as a dynamic variable so we
            # can access it at any time/level even if :raw-error
            # wasn't passed explicitely
            my $*RAW-ERROR = $raw-error;

            # The bread crumbs of where we are in the data structure,
            # to be used for error message and other informational
            # purposes
            my @*CRUMBS;

            # Where any build error are stored
            my @*ERRORS;

            # To keep track of any bom-refs that were specified, so
            # that they can easily be produced whenever needed
            my %*BOM-REFS;

            my $sbom := self!ingest(%in);
            $sbom.defined
              ?? $sbom!save-dynamic-vars
              !! $sbom
        }
    }

    # Helper method to set dynamic variable like @*ERRORS and %*BOM-REFS
    # on the outer SBOM object
    method !save-dynamic-vars() {
        %!additional-object-info<build-errors> := @*ERRORS.List;
        %!additional-object-info<bom-refs>     := %*BOM-REFS.Map;
        self
    }

    # Basic error handling
    my sub handle-error($_) {
        $*RAW-ERROR
          ?? .rethrow
          !!  @*ERRORS.push(@*CRUMBS.join("/") => $_);
    }

    # DateTime handling is a bit more strict in CycloneDX, so be a
    # little more strict here
    my sub makeDateTime(Str:D $string) {
        if try $string.DateTime -> $datetime {
            my int $chars = $string.chars;
            return $datetime if $string.chars >= 20
        }
        die "Invalid DateTime string '$string'; use an ISO 8601 timestamp (yyyy-mm-ddThh:mm:ss+00:00) instead";
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
        for @names -> $name {
            my \value := (%in{$name}:delete)<>;
            my $type  := %type{$name};

            # Can only set defined values
            if !value.defined {
                # no action
            }

            # We potentially got multiple values
            elsif %positional{$name} {
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
                        @out = value.grep(*.defined);
                    }
                    elsif $type ~~ DateTime {
                        for value.grep(*.defined) {
                            @out.push(
                              $_ ~~ DateTime ?? $_ !! makeDateTime($_)
                            );
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
                elsif $type ~~ Enumify {  # UNCOVERABLE
                    %out{$name} := value ~~ Enumify
                      ?? value
                      !! $type(value);
                }
                elsif $type ~~ DateTime {  # UNCOVERABLE
                    %out{$name} := value ~~ DateTime
                      ?? value
                      !! makeDateTime(value);
                }
                elsif value ~~ Cool {  # UNCOVERABLE
                    %out{$name} := value;
                }
                elsif $type ~~ SBOM {  # UNCOVERABLE
                    %out{$name} := value ~~ SBOM
                      ?? value
                      !! $type.new(|value);
                }
                else {
                    die "Don't know how to handle type $type.^name()";
                }
            }
        }

        # First pass of checking unexpected named arguments
        if %in {

            # Delete any schema related attributes for now
            %in{$_}:delete for %in.keys.grep(*.starts-with('$'));

            # Handle additionally supported named arguments
            if %in{self.TWEAK-nameds}:delete:p -> @additional {
                %out{.key} := .value for @additional;
            }
        }

        # Second pass: not all input arguments accounted for, either save
        # as additional properties if supported, or call it a day.
        if %in {

            # Handle any additional properties
            if %attribute<additional-properties> {
                %out<additional-properties> := %in.pairs.List;
            }

            # Alas, unexpected keys
            else {
                die "Found extra keys in {self.^name}: %in.keys.sort.join(", ")";
            }
        }

        if %out || %required {
            my $sbom := self.bless: |%out;

            if $has-bom-ref {
                %*BOM-REFS{$_} := $sbom with $sbom.bom-ref;
            }
            @*CRUMBS.pop;
            $sbom
        }
        else {
            @*CRUMBS.pop;
            Nil
        }
    }

    # Cannot use the standard .raku semantics, as that would process
    # the arguments before processing their parent, which has all sorts
    # of weird effects, specifically in error reporting.  So instead
    # producing .raku output for each sub-class, just generate the
    # .Map of the arguments and flatten that as the arguments.
    multi method raku(::?CLASS:D:) {
        self.^name ~ ".new(|" ~ self.Map.raku ~ ")"
    }

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

    # Type objects get an empty Map
    multi method Map(::?CLASS:U:) { Map.new }

    # Produce a Map for the object, recursively if necessary.  Takes
    # an optional :ordered named argument to create a special type of
    # map that will produce keys in the attribute definition order.
    multi method Map(::?CLASS:D: :$ordered) {

        # Set up list of keys to render, may have additional keys
        my @keys = (@names,self.TWEAK-nameds).flat;

        # Create initial version of the Map, needs clone as @keys can
        # be added while iterating, causing double adds
        my $map := @keys.clone.map(-> $name {
            my $value := self."$name"();
            my $type  := %type{$name};

            # Generic mapification logic
            sub mapify($value) {
                $type =:= Nil
                  ?? $value ~~ Str:D  # tweaked args that can be Str
                    ?? $value
                    !! $value.Map(:$ordered)
                  !! $type ~~ Cool
                    ?? $value
                    !! ($type ~~ Enumify)  # UNCOVERABLE
                      ?? $value ~~ Enumify
                        ?? $value.name
                        !! $value
                      !! ($type ~~ DateTime)  # UNCOVERABLE
                        ?? $value ~~ DateTime
                          ?? $value.Str.subst("Z","+00:00")
                          !! $value
                        !! $value.Map(:$ordered)
            }

            # Have additional properties, so add them so theu appear
            # in the Map, and thus in the JSON
            if $name eq 'additional-properties' {
                $value.map({ @keys.push(.key); $_ }).Slip
            }

            # An array of sort, add them if they're not empty
            elsif %positional{$name} || $value ~~ Positional {  # UNCOVERABLE
                if $value<>.elems {
                    $name => $value<>.map(&mapify).List
                }
            }

            # A single value
            else {
                $name => mapify($_) with $value;
            }
        }).Map;

        $ordered ?? $map but ordered-list[@keys] !! $map
    }

    # Type objects get an empty Hash
    multi method Hash(::?CLASS:U:) { Hash.new }

    # Produce a Hash for the object, recursively if necessary.  Takes
    # an optional :ordered named argument to create a special type of
    # Hash that will produce keys in the attribute definition order.
    multi method Hash(::?CLASS:D: :$ordered) {

        # Set up list of keys to render, may have additional keys
        my @keys = (@names,self.TWEAK-nameds).flat;

        # Create initial version of the Hash, needs clone as @keys can
        # be added while iterating, causing double adds
        my %hash = @keys.clone.map: -> $name {
            my $value := self."$name"();
            my $type  := %type{$name};

            # Generic mapification logic
            sub mapify($value) {
                $type =:= Nil
                  ?? $value ~~ Str:D  # tweaked args that can be Str
                    ?? $value
                    !! $value.Hash(:$ordered)
                  !! $type ~~ Cool
                    ?? $value
                    !! ($type ~~ Enumify)  # UNCOVERABLE
                      ?? $value ~~ Enumify
                        ?? $value.name
                        !! $value
                      !! ($type ~~ DateTime)  # UNCOVERABLE
                        ?? $value ~~ DateTime
                          ?? $value.Str.subst("Z","+00:00")
                          !! $value
                        !! $value.Hash(:$ordered)
            }

            # Have additional properties, so add them so theu appear
            # in the Map, and thus in the JSON
            if $name eq 'additional-properties' {
                $value.map({ @keys.push(.key); $_ }).Slip
            }

            # An array of sort, add them if they're not empty
            elsif %positional{$name} || $value ~~ Positional {  # UNCOVERABLE
                if $value<>.elems {
                    $name => $value<>.map(&mapify).List
                }
            }

            # A single value
            else {
                $name => mapify($_) with $value;
            }
        }

        $ordered ?? %hash but ordered-list[@keys] !! %hash
    }

    # Produce the JSON for the invocant
    method JSON(::?CLASS:D: --> Str:D) {
        to-json(self.Map(:ordered))
    }

    # Produce the YAML for the invocant
    method YAML(::?CLASS:D: --> Str:D) {
        save-yaml(self.Map(:ordered))
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
