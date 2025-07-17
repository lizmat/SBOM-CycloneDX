use SBOM::enums:ver<0.0.7>:auth<zef:lizmat> <
  ReferenceSource
>;

use SBOM::subsets:ver<0.0.7>:auth<zef:lizmat> <
  referenceURL
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::HashedString:ver<0.0.7>:auth<zef:lizmat>;

#- Reference -------------------------------------------------------------------
#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
class SBOM::Reference:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| The URI (URL or URN) to the external reference. External references
#| are URIs and therefore can accept any URL scheme including https
#| (RFC-7230), mailto (RFC-2368), tel (RFC-3966), and dns (RFC-4501).
#| External references may also include formally registered URNs such
#| as CycloneDX BOM-Link to reference CycloneDX BOMs or any object
#| within a BOM. BOM-Link transforms applicable external references
#| into relationships that can be expressed in a BOM or across BOMs.
    has referenceURL $.url is required;

#| An optional comment describing the external reference.
    has Str $.comment;

#| Specifies the type of external reference.
    has ReferenceSource $.type is required;

#| The hashes of the external reference (if applicable).
    has SBOM::HashedString @.hashes;
}

#- ResourceReference -----------------------------------------------------------
#| A reference to a locally defined resource (e.g., a bom-ref) or an
#| externally accessible resource.
class SBOM::ResourceReference:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| References an object by its bom-ref attribute
    has bom-refOrLink $.ref;

#| Reference to an externally accessible resource.
    has SBOM::Reference $.externalReference;

    submethod TWEAK() {
        die "Must either have 'ref' or 'externalReference'"
          unless $!ref || $!externalReference;
    }
}

# vim: expandtab shiftwidth=4
