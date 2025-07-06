use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  ReleaseLevel
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Note:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Resolve:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ReleaseNotes:ver<0.0.1>:auth<zef:lizmat> {
    has ReleaseLevel    $.type is required;
    has Str             $.title;
    has URL             $.featuredImage;
    has URL             $.socialImage;
    has Str             $.descrption;
    has DateTime        $.timestamp;
    has Str             @.aliases;
    has Str             @.tags;
    has SBOM::Resolve   @.resolves;
    has SBOM::Note      @.notes;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::Property @.properties;
}

# vim: expandtab shiftwidth=4
