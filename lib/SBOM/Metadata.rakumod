use SBOM::Phase:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Tool:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Metadata:ver<0.0.1>:auth<zef:lizmat> {
    has DateTime    $.timestamp;
    has SBOM::Phase @.lifecycles;
    has             $.tools;

    method TWEAK(:$tools) {
        die "improper tool"
          unless $tools ~~ SBOM::LegacyTool
            || ($tools ~~ Positional && $tools.are(SBOM::Tool))
    }
}

# vim: expandtab shiftwidth=4
