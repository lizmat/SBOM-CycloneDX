use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

#| The requirement level of a claim.
class SBOM::RequirementLevel:ver<0.0.1>:auth<zef:lizmat> {

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
}

# vim: expandtab shiftwidth=4
