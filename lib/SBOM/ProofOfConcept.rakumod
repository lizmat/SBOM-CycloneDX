use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ProofOfConcept:ver<0.0.1>:auth<zef:lizmat> {
    has Str        $.reproductionSteps;
    has Str        $.environment;
    has SBOM::Text @.supportingMaterial;
}

# vim: expandtab shiftwidth=4
