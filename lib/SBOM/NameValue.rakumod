class SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat> {
    has $.name is required;
    has $.value;

    method new(Str:D $name, Str $value? --> SBOM::NameValue:D) {
        self.bless(:$name, :$value)
    }

    multi method Str(SBOM::NameValue:D:) { $.name }
}

subset StrOrNameValue where Str | SBOM::NameValue;

# vim: expandtab shiftwidth=4
