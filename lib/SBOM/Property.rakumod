class SBOM::Property:ver<0.0.1>:auth<zef:lizmat> {
    has $.name is required;
    has $.value;

    method new(Str:D $name, Str $value? --> SBOM::Property:D) {
        self.bless(:$name, :$value)
    }

    multi method Str(SBOM::Property:D:) { $.name }
}

subset SBOM::StrOrProperty where Str | SBOM::NameValue;

# vim: expandtab shiftwidth=4
