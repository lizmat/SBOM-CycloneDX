use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Field
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bomLinkElement bom-ref confidenceValue
>;

use SBOM::EvidenceMethod:ver<0.0.1>:auth<zef:lizmat>;

subset BomRefOrbomLinkElement of Str where bom-ref | bomLinkElement;

class SBOM::Identity:ver<0.0.1>:auth<zef:lizmat> {
    has Field                  $.type is required;
    has confidenceValue        $.confidence;
    has Str                    $.concludedValue;
    has SBOM::EvidenceMethod   @.methods;
    has BomRefOrbomLinkElement @.tools;
}

# vim: expandtab shiftwidth=4
