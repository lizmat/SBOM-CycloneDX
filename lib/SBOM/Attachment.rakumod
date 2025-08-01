use SBOM::enums:ver<0.0.12>:auth<zef:lizmat> <
  Encoding
>;

use SBOM::subsets:ver<0.0.12>:auth<zef:lizmat> <
  mime-type
>;

use SBOM:ver<0.0.12>:auth<zef:lizmat>;

#| Supporting material that helps in reproducing or understanding. This
#| may include screenshots, payloads, and PoC exploit code.
class SBOM::Attachment:ver<0.0.12>:auth<zef:lizmat> does SBOM {

#| Specifies the format and nature of the data being attached, helping
#| systems correctly interpret and process the content. Common content
#| type examples include application/json for JSON data and text/plain
#| for plan text documents.
    has mime-type $.contentType = "text/plain";

#| Specifies the optional encoding the text is represented in.
    has Encoding $.encoding;

#| The attachment data. Proactive controls such as input validation and
#| sanitization should be employed to prevent misuse of attachment text.
    has Str $.content is required;
}

# vim: expandtab shiftwidth=4
