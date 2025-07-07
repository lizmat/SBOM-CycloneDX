use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

#- DataContents ----------------------------------------------------------------
#| The contents or references to the contents of data being described.
class SBOM::DataContents:ver<0.0.1>:auth<zef:lizmat> {

#| An optional way to include textual or encoded data.
    has SBOM::Attachment $.attachment;

#| The URL to where the data can be retrieved.
    has URL$.url;

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
