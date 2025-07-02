use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <mime-type>;

use SBOM::EncodingType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Text:ver<0.0.1>:auth<zef:lizmat> {
    has mime-type          $.contentType = "text/plain";
    has SBOM::EncodingType $.encoding;
    has Str                $.content is required;
}

# vim: expandtab shiftwidth=4
