use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  ReferenceSource
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  referenceURL
>;

use SBOM::Hash:ver<0.0.1>:auth<zef:lizmat>;

#| External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
class SBOM::Reference:ver<0.0.1>:auth<zef:lizmat> {
    has referenceURL    $.url  is required;
    has ReferenceSource $.type is required;
    has Str             $.comment;
    has SBOM::Hash      @.hashes;
}

subset SBOM::resourceRef where referenceURL | SBOM::Reference;

# vim: expandtab shiftwidth=4
