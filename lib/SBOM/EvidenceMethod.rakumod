use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <confidenceValue>;

use SBOM::EvidenceType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EvidenceMethod:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::EvidenceType $.technique  is required;
    has confidenceValue    $.confidence is required;
    has Str                $.value;
}

# vim: expandtab shiftwidth=4
