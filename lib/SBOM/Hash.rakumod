use SBOM::enums:ver<0.0.1>:auth<zef:lizmat>
  <algorithmHash>;
use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <contentHash>;

class SBOM::Hash:ver<0.0.1>:auth<zef:lizmat> {
    has algorithmHash $.alg     is required;
    has contentHash   $.content is required;
}

# vim: expandtab shiftwidth=4
