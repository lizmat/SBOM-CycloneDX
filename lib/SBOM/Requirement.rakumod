use SBOM::subsets:ver<0.0.14>:auth<zef:lizmat> <
  bom-ref CRE
>;

use SBOM:ver<0.0.14>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.14>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.14>:auth<zef:lizmat>;

#- Requirement -----------------------------------------------------------------
#| A requirement of a standard.
class SBOM::Requirement:ver<0.0.14>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The unique identifier used in the standard to identify a specific
#| requirement. This should match what is in the standard and should
#| not be the requirements bom-ref.
    has Str $.identifier;

#| The title of the requirement.
    has Str $.title;

#| The textual content of the requirement.
    has Str $.text;

#| The supplemental text that provides additional guidance or context
#| to the requirement, but is not directly part of the requirement.
    has Str @.descriptions;

#| The Common Requirements Enumeration (CRE) identifier(s).
    has CRE @.openCre;

#| The optional bom-ref to a parent requirement. This establishes a
#| hierarchy of requirements. Top-level requirements must not define
#| a parent. Only child requirements should define parents.
    has bom-ref $.parent;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences;

    # These should probably be auto-generated in RakUAST at some point
    method descriptions(SBOM::Requirement:D:) {
        @!descriptions.List
    }
    method openCre(SBOM::Requirement:D:) {
        @!openCre.List
    }
    method properties(SBOM::Requirement:D:) {
        @!properties.List
    }
    method externalReferences(SBOM::Requirement:D:) {
        @!externalReferences.List
    }
}

# vim: expandtab shiftwidth=4
