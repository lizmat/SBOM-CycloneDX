use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

#| Evidence used to reproduce a vulnerability.
class SBOM::ProofOfConcept:ver<0.0.1>:auth<zef:lizmat> {

#| Precise steps to reproduce the vulnerability.
    has Str $.reproductionSteps;

#| A description of the environment in which reproduction was possible.
    has Str $.environment;

#| Supporting material that helps in reproducing or understanding how
#| reproduction is possible. This may include screenshots, payloads,
#| and PoC exploit code.
    has SBOM::Attachment @.supportingMaterial;
}

# vim: expandtab shiftwidth=4
