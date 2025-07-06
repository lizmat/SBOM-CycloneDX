use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;

#| A signatories authorized on behalf of an organization to assert
#| validity of this document.
class SBOM::Signatory:ver<0.0.1>:auth<zef:lizmat> {

#| The signatory's name.
    has Str $.name;

#| The signatory's role within an organization.
    has Str $.role;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

#| The signatory's organization.
    has SBOM::Organization $.organization;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference $.externalReference;
}

# vim: expandtab shiftwidth=4
