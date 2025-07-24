use SBOM::subsets:ver<0.0.7>:auth<zef:lizmat> <
  bom-ref conformanceValue
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Confidence:ver<0.0.7>:auth<zef:lizmat>;

#- Conformance -----------------------------------------------------------------
#| The conformance of the claim meeting a requirement.
class SBOM::Conformance:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| The conformance of the claim between and inclusive of 0 and 1,
#| where 1 is 100% conformance.
    has conformanceValue $.score;

#| The rationale for the conformance score.
    has Str $.rationale;

#| The list of bom-ref to the evidence provided describing the
#| mitigation strategies.
    has bom-ref @.mitigationStrategies;

    # These should probably be auto-generated in RakUAST at some point
    method mitigationStrategies(SBOM::Conformance:D:) {
        @!mitigationStrategies.List
    }
}

#- RequirementGrouping ---------------------------------------------------------
#| The grouping of requirements to claims and the attestors declared
#| conformance and confidence thereof.
class SBOM::RequirementGrouping:ver<0.0.7>:auth<zef:lizmat> does SBOM {

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

    # These should probably be auto-generated in RakUAST at some point
    method claims(SBOM::RequirementGrouping:D:) {
        @!claims.List
    }
    method counterClaims(SBOM::RequirementGrouping:D:) {
        @!counterClaims.List
    }
}

# vim: expandtab shiftwidth=4
