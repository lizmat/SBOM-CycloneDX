use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  RiskMethodology Severity
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Source:ver<0.0.1>:auth<zef:lizmat>;

#| Defines the severity or risk ratings of a vulnerability.
class SBOM::Rating:ver<0.0.1>:auth<zef:lizmat> {

#| The source that calculated the severity or risk rating of the
#| vulnerability.
    has SBOM::Source $.source;

#| The numerical score of the rating.
    has Rat $.score;

#| Textual representation of the severity that corresponds to the
#| numerical score of the rating.
    has Severity $.severity;

#| Specifies the severity or risk scoring methodology or standard used.
    has RiskMethodology $.method;

#| Textual representation of the metric values used to score the
#| vulnerability.
    has Str $.vector;

#| An optional reason for rating the vulnerability as it was.
    has Str $.justification;
}

# vim: expandtab shiftwidth=4
