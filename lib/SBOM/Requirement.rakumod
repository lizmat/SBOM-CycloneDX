use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref CRE
>;

use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;

#| A requirement of a standard.
class SBOM::Requirement:ver<0.0.1>:auth<zef:lizmat> {

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
    has CRE @.openCRE;

#| The optional bom-ref to a parent requirement. This establishes a
#| hierarchy of requirements. Top-level requirements must not define
#| a parent. Only child requirements should define parents.
    has bom-ref $.parent;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::Property @.properties;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences;
}

# vim: expandtab shiftwidth=4
