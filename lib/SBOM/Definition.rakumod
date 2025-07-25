use SBOM::subsets:ver<0.0.9>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Requirement:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.9>:auth<zef:lizmat>;

#- RequirementLevel ------------------------------------------------------------
#| The requirement level of a claim.
class SBOM::RequirementLevel:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The identifier used in the standard to identify a specific level.
    has Str $.identifier;

#| The title of the requirement.
    has Str $.title;

#| The description of the requirement.
    has Str $.description;

#| The list of requirement bom-refs that comprise the level.
    has bom-ref @.requirements;

    # These should probably be auto-generated in RakUAST at some point
    method requirements(SBOM::RequirementLevel:D:) { @!requirements.List }
}

#- Standard --------------------------------------------------------------------
#| A standard which may consist of regulations, industry or
#| organizational-specific standards, maturity models, best
#| practices, or any other requirements which can be evaluated
#| against or attested to.
class SBOM::Standard:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The name of the standard. This will often be a shortened, single
#| name of the standard.
    has Str $.name;

#| The version of the standard.
    has Str $.version;

#| The description of the standard.
    has Str $.description;

#| The owner of the standard, often the entity responsible for its
#| release.
    has Str $.owner;

#| The list of requirements comprising the standard.
    has SBOM::Requirement @.requirements;

#| The list of levels associated with the standard. Some standards
#| have different levels of compliance.
    has SBOM::RequirementLevel @.levels;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # These should probably be auto-generated in RakUAST at some point
    method requirements(      SBOM::Standard:D:) { @!requirements.List       }
    method levels(            SBOM::Standard:D:) { @!levels.List             }
    method externalReferences(SBOM::Standard:D:) { @!externalReferences.List }
}

#- Definition ------------------------------------------------------------------
#| Reusable object that may be used elsewhere in the BOM.
class SBOM::Definition:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| The list of standards which may consist of regulations, industry
#| or organizational-specific standards, maturity models, best
#| practices, or any other requirements which can be evaluated against
#| or attested to.
    has SBOM::Standard @.standards;

    # These should probably be auto-generated in RakUAST at some point
    method standards(SBOM::Definition:D:) { @!standards.List }
}

# vim: expandtab shiftwidth=4
