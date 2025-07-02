use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <contentHash>;

use SBOM::HashType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Hash:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::HashType $.alg     is required;
    has contentHash    $.content is required;
}

# vim: expandtab shiftwidth=4
