use SBOM::PhaseType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Tool:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Metadata:ver<0.0.1>:auth<zef:lizmat> {
    has DateTime        $.timestamp;
    has SBOM::PhaseType @.lifecycles;
    has                 $.tools;

    method TWEAK(:$tools) {
        die "improper tool"
          unless $tools ~~ SBOM::Tool
            || ($tools ~~ Positional && $tools.are(SBOM::LegacyTool))
    }
}

# vim: expandtab shiftwidth=4
