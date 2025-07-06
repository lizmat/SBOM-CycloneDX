use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref conformanceValue
>;

#| The conformance of the claim meeting a requirement.
class SBOM::Conformance:ver<0.0.1>:auth<zef:lizmat> {

#| The conformance of the claim between and inclusive of 0 and 1,
#| where 1 is 100% conformance.
    has conformanceValue $.score;

#| The rationale for the conformance score.
    has Str $.rationale;

#| The list of bom-ref to the evidence provided describing the
#| mitigation strategies.
    has bom-ref @.mitigationStrategies;
}

# vim: expandtab shiftwidth=4
