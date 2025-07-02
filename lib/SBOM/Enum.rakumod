role SBOM::Enum:ver<0.0.1>:auth<zef:lizmat> {
    has $.name;
    has $.description;

    my %enums is Map;

    method setup(SBOM::Enum:U: *@setup) {
        my %hash;
        for @setup -> $name, $description {
            %hash{$name} := self.new(:$name, :$description);
        }
        %enums := %hash.Map;
    }

    proto method name() {*}
    multi method name(SBOM::Enum:U:) { ""     }
    multi method name(SBOM::Enum:D:) { $!name }

    method WHICH(SBOM::Enum:D:) {
        ValueObjAt.new(self.^name ~ '|' ~ $!name)
    }

    multi method Str(SBOM::Enum:D:) { $.name }

    method CALL-ME(SBOM::Enum:U: Str:D $name) {
        %enums{$name} // Nil
    }
}

# vim: expandtab shiftwidth=4
