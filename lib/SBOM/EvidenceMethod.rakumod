use SBOM::enums:ver<0.0.1>:auth<zef:lizmat>
  <evidenceTechnique>;
use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <confidenceValue>;

class SBOM::EvidenceMethod:ver<0.0.1>:auth<zef:lizmat> {
    has evidenceTechnique $.technique  is required;
    has confidenceValue   $.confidence is required;
    has Str               $.value;
}

# vim: expandtab shiftwidth=4
