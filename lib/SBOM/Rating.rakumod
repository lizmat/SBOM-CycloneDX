use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  RiskMethodology Severity
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Source:ver<0.0.1>:auth<zef:lizmat>

class SBOM::Rating:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Source    $.source;
    has Rat             $.score;
    has Severity        $.severity;
    has RiskMethodology $.method;
    has Str             $.vector;
    has Str             $.justification;
}

# vim: expandtab shiftwidth=4
