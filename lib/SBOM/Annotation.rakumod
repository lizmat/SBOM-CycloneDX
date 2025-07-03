use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref referenceURL
>;

use SBOM::Annotator:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Annotation:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref              $.bom-ref;
    has referenceURL         @.subjects  is required;
    has SBOM::Annotator      $.annotator is required;
    has DateTime             $.timestamp is required;
    has Str                  $.text      is required;
    has SBOM::ValidSignature $.signature;

    method description() {
        "Comments made by people, organizations, or tools about any object with a bom-ref, such as components, services, vulnerabilities, or the BOM itself. Unlike inventory information, annotations may contain opinions or commentary from various stakeholders. Annotations may be inline (with inventory) or externalized via BOM-Link and may optionally be signed."
    }
}

# vim: expandtab shiftwidth=4
