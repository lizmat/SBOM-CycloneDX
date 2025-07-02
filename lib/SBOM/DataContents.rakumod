use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <URL>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::DataContents:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Text      $.attachment;
    has URL             $.url;
    has SBOM::NameValue @.properties;
}

# vim: expandtab shiftwidth=4
