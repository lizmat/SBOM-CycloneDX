use SBOM::Encoding:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Subsets:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Text:ver<0.0.1>:auth<zef:lizmat> {
    has mime-type    $.contentType = "text/plain";
    has encodingType $.encoding;
    has Str          $.content is required;
}

# vim: expandtab shiftwidth=4
