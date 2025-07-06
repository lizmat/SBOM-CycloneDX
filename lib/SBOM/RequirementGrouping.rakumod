use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Confidence:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Conformance:ver<0.0.1>:auth<zef:lizmat>;

#| The grouping of requirements to claims and the attestors declared
#| conformance and confidence thereof.
class SBOM::RequirementGrouping:ver<0.0.1>:auth<zef:lizmat> {

#| The bom-ref to the requirement being attested to.
    has bom-ref $.requirement;

#| The list of bom-ref to the claims being attested to.
    has bom-ref @.claims;

#| The list of bom-ref to the counter claims being attested to.
    has bom-ref @.counterClaims;

#| The conformance of the claim meeting a requirement.
    has SBOM::Conformance $.conformance;

#| The confidence of the claim meeting a requirement.
    has SBOM::Confidence $.confidence;
}

# vim: expandtab shiftwidth=4
