use SBOM::Signatory:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;

#| A concise statement affirmed by an individual regarding all
#| declarations, often used for third-party auditor acceptance or
#| recipient acknowledgment. It includes a list of authorizedi
#| signatories who assert the validity of the document on behalf
#| of the organization.
class SBOM::Affirmation:ver<0.0.1>:auth<zef:lizmat> {

#| The brief statement affirmed by an individual regarding all
#| declarations.  This could be an affirmation of acceptance by a
#| third-party auditor or receiving individual of a file.
    has Str $.statement;

#| The list of signatories authorized on behalf of an organization to
#| assert validity of this document.
    has SBOM::Signatory @.signatories;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;
}

# vim: expandtab shiftwidth=4
