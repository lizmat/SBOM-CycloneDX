use SBOM::subsets:ver<0.0.7>:auth<zef:lizmat> <
  URL
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.7>:auth<zef:lizmat>;

#- DataContents ----------------------------------------------------------------
#| The contents or references to the contents of data being described.
class SBOM::DataContents:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| An optional way to include textual or encoded data.
    has SBOM::Attachment $.attachment;

#| The URL to where the data can be retrieved.
    has URL$.url;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;
}

# vim: expandtab shiftwidth=4
