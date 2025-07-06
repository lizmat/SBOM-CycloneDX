use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  ReferenceSource
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  referenceURL
>;

use SBOM::Hash:ver<0.0.1>:auth<zef:lizmat>;

#| External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
class SBOM::Reference:ver<0.0.1>:auth<zef:lizmat> {

#| The URI (URL or URN) to the external reference. External references
#| are URIs and therefore can accept any URL scheme including https
#| (RFC-7230), mailto (RFC-2368), tel (RFC-3966), and dns (RFC-4501).
#| External references may also include formally registered URNs such
#| as CycloneDX BOM-Link to reference CycloneDX BOMs or any object
#| within a BOM. BOM-Link transforms applicable external references
#| into relationships that can be expressed in a BOM or across BOMs.
    has referenceURL $.url  is required;

#| An optional comment describing the external reference.
    has Str $.comment;

#| Specifies the type of external reference.
    has ReferenceSource $.type is required;

#| The hashes of the external reference (if applicable).
    has SBOM::Hash @.hashes;
}

subset SBOM::resourceRef where referenceURL | SBOM::Reference;

# vim: expandtab shiftwidth=4
