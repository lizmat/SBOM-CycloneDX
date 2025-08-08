use SBOM::subsets:ver<0.0.13>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::RequirementGrouping:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.13>:auth<zef:lizmat>;

#| An attestations asserted by an assessor that maps requirements
#| to claims.
class SBOM::Attestation:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The short description explaining the main points of the attestation.
    has Str $.summary;

#| The bom-ref to the assessor asserting the attestation.
    has bom-ref $.assessor;

#| The grouping of requirements to claims and the attestors declared
#| conformance and confidence thereof.
    has SBOM::RequirementGrouping @.map;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # These should probably be auto-generated in RakUAST at some point
    method map(SBOM::Attestation:D:) { @!map.List }
}

# vim: expandtab shiftwidth=4
