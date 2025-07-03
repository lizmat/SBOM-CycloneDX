use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Justification Response VulnerabilityState
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

class SBOM::Analysis:ver<0.0.1>:auth<zef:lizmat> {
    has VulnerabilityState $.state;
    has URL                $.url;
    has Justification      $.justification;
    has Response           $.response;
    has Str                $.detail;
    has DateTime           $.firstIssued;
    has DateTime           $.lastUpdated;
}

# vim: expandtab shiftwidth=4
