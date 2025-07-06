use SBOM::Affirmation:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Assessor:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Attestation:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Claim:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::DeclarationEvidence:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Target:ver<0.0.1>:auth<zef:lizmat>;

#| Describes the conformance to standards, may include attestations,
#| claims, and evidence.
class SBOM::Declaration:ver<0.0.1>:auth<zef:lizmat> {

#| The list of assessors evaluating claims and determining conformance
#| to requirements and confidence in that assessment.
    has SBOM::Assessor @.assessors;

#| The list of attestations asserted by an assessor that maps
#| requirements to claims.
    has SBOM::Attestation @.attestations;

#| The list of claims.
    has SBOM::Claim @.claims;

#| The list of evidence.
    has SBOM::DeclarationEvidence $.evidence;

#| The list of targets which claims are made against.
    has SBOM::Target @.targets;

#| A concise statement affirmed by an individual regarding all
#| declarations, often used for third-party auditor acceptance or
#| recipient acknowledgment. It includes a list of authorized
#| signatories who assert the validity of the document on behalf
#| of the organization.
    has SBOM::Affirmation $.affirmation;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;
}

# vim: expandtab shiftwidth=4
