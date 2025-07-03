use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Encoding
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  mime-type
>;

class SBOM::Text:ver<0.0.1>:auth<zef:lizmat> {
    has mime-type $.contentType = "text/plain";
    has Encoding  $.encoding;
    has Str       $.content is required;
}

# vim: expandtab shiftwidth=4
