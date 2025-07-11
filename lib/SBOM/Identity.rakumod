use SBOM::enums:ver<0.0.3>:auth<zef:lizmat> <
  Evidence Field
>;

use SBOM::subsets:ver<0.0.3>:auth<zef:lizmat> <
  bomLinkElement bom-ref confidenceValue
>;

use SBOM:ver<0.0.3>:auth<zef:lizmat>;

#| A bom-ref or a bomlink element
subset BomRefOrbomLinkElement of Str where bom-ref | bomLinkElement;

#- EvidenceMethod --------------------------------------------------------------
#| A method used to extract and/or analyze the evidence.
class SBOM::EvidenceMethod:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| The technique used in this method of analysis.
    has Evidence $.technique  is required;

#| The confidence of the evidence from 0 - 1, where 1 is 100% confidence.
#| Confidence is specific to the technique used. Each technique of
#| analysis can have independent confidence.
    has confidenceValue $.confidence is required;

#| The value or contents of the evidence.
    has Str $.value;
}

#- Identity --------------------------------------------------------------------
#| Evidence that substantiates the identity of a component.
class SBOM::Identity:ver<0.0.3>:auth<zef:lizmat> does SBOM {
#| The identity field of the component which the evidence describes.
    has Field $.type is required;

#| The overall confidence of the evidence from 0 - 1, where 1 is
#| 100% confidence.
    has confidenceValue $.confidence;

#| The value of the field (cpe, purl, etc) that has been concluded
#| based on the aggregate of all methods (if available).
    has Str $.concludedValue;

#| The methods used to extract and/or analyze the evidence.
    has SBOM::EvidenceMethod @.methods;

#| The object in the BOM identified by its bom-ref. This is often a
#| component or service but may be any object type supporting bom-refs.
#| Tools used for analysis should already be defined in the BOM, either
#| in the metadata/tools, components, or formulation.
    has BomRefOrbomLinkElement @.tools;
}

# vim: expandtab shiftwidth=4
