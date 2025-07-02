use SBOM::Component:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Hash:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Tool:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Component @.components;
    has SBOM::Service   @.services;
}

class SBOM::LegacyTool:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.vendor;
    has Str             $.name;
    has Str             $.version;
    has SBOM::Hash      @.hashes;
    has SBOM::Reference @.externalReferences
}

subset SBOM::AnyTool where {
    $_ ~~ SBOM::Tool
      || ($_ ~~ Positional && .are(SBOM::LegacyTool))
}

# vim: expandtab shiftwidth=4
