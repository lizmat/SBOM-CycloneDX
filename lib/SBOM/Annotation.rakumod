use SBOM::subsets:ver<0.0.7>:auth<zef:lizmat> <
  bom-ref referenceURL
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Component:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.7>:auth<zef:lizmat>;

#- Annotator -------------------------------------------------------------------
#| Person, organization, component, service making an annotation
class SBOM::Annotator:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| The person that created the annotation.
    has SBOM::Contact $.individual;

#| The organization that created the annotation.
    has SBOM::Organization $.organization;

#| The tool or component that created the annotation.
    has SBOM::Component $.component;

#| The service that created the annotation.
    has SBOM::Service $.service;

    submethod TWEAK() is hidden-from-backtrace {
        die "Must have one of <individual organization component service> specified"
          unless one($!individual,$!organization,$!component,$!service);
    }
}

#- Annotation ------------------------------------------------------------------
#| Comments made by people, organizations, or tools about any object
#| with a bom-ref, such as components, services, vulnerabilities, or
#| the BOM itself. Unlike inventory information, annotations may contain
#| opinions or commentary from various stakeholders. Annotations may be
#| inline (with inventory) or externalized via BOM-Link and may
#| optionally be signed.
class SBOM::Annotation:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the annotation
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The object in the BOM identified by its bom-ref. This is often a
#| component or service, but may be any object type supporting bom-refs.
    has referenceURL @.subjects is required;

#| The organization, person, component, or service which created the
#| textual content of the annotation.
    has SBOM::Annotator $.annotator is required;

#| The date and time (timestamp) when the annotation was created.
    has DateTime $.timestamp is required;

#| The textual content of the annotation.
    has Str $.text is required;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    submethod TWEAK() is hidden-from-backtrace {
        self.must-have-elements(@!subjects);
    }
}

# vim: expandtab shiftwidth=4
