use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  VulnerabilityState
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

class SBOM::Analysis:ver<0.0.1>:auth<zef:lizmat> {
    has VulnerabilityState $.state;
    has URL                $.url;
}

# vim: expandtab shiftwidth=4
