use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref propertyName
>;

use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EvidenceDataset:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;

#| Evidence used in a declaration.
class SBOM::DeclarationEvidence:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The reference to the property name as defined in the CycloneDX
#| Property Taxonomy.
    has propertyName $.propertyName;

#| The written description of what this evidence is and how it was
#| created.
    has Str $.description;

#| The output or analysis that supports claims.
    has SBOM::EvidenceDataset @.data;

#| The date and time (timestamp) when the evidence was created.
    has DateTime $.created;

#| The date and time (timestamp) when the evidence is no longer valid.
    has DateTime $.expires;

#| The author of the evidence.
    has SBOM::Contact $.author;

#| The reviewer of the evidence.
    has SBOM::Contact $.reviewer;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;
}

# vim: expandtab shiftwidth=4
