use SBOM::Source:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::SourceReference:ver<0.0.1>:auth<zef:lizmat> {
    has Str          $.id;
    has SBOM::Source $.source;
}

# vim: expandtab shiftwidth=4
