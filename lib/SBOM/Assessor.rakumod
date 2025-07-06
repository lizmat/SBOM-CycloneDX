use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

#| An assessor evaluating claims and determining conformance to
#| requirements and confidence in that assessment.
class SBOM::Assessor:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The boolean indicating if the assessor is outside the organization
#| generating claims. A value of false indicates a self assessor.
    has Bool $.thirdParty;

#| The entity issuing the assessment.
    has SBOM::Organization $.organization
}

# vim: expandtab shiftwidth=4
