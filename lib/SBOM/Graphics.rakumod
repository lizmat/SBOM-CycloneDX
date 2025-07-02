use SBOM::Graphic:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Graphics:ver<0.0.1>:auth<zef:lizmat> {
    has Str           $.description;
    has SBOM::Graphic @.collection;
}

# vim: expandtab shiftwidth=4
