use SBOM::Commit:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ComponentType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Hash:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Patch:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ScopeType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Subsets:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::SWID:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Pedigree { ... }

class SBOM::Component:ver<0.0.1>:auth<zef:lizmat> {
    has Str                 $.name is required;
    has SBOM::ScopeType     $.scope = scopeRequired;
    has Str                 $.version;
    has Str                 $.description;
    has SBOM::ComponentType $.type;
    has mime-type           $.mime-type;
    has bom-ref             $.bom-ref;
    has SBOM::Organization  $.supplier;
    has SBOM::Organization  $.manufacturer;
    has SBOM::Contact       @.authors;
    has Str                 $.publisher;
    has SBOM::Hash          @.hashes;
    has SBOM::License       @.licenses;
    has Str                 $.copyright;
    has CPE                 $.cpe;
    has PURL                $.purl;
    has OmniborID           @.omniborId;
    has SWHID               @.swhid;
    has SBOM::SWID          $.swid;
    has Bool                $.modified;
    has SBOM::Pedigree      $.pedigree;
    has SBOM::Reference     @.externalReferences;
    has SBOM::Component     @.components;

# XXX handle "author" -> "authors" on ingestion
}

class SBOM::Pedigree:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Component   @.ancestors;
    has SBOM::Component   @.descendants;
    has SBOM::Component   @.variants;
    has SBOM::Commit      @.commits;
    has SBOM::Patch       @.patches;
    has Str               $.notes;
}

# vim: expandtab shiftwidth=4
