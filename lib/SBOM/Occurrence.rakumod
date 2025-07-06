use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref PositiveInt
>;

#| Evidence of instance of a component spread across multiple locations.
class SBOM::Occurrence:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the occurrence
#| elsewhere in the BOM
    has bom-ref $.bom-ref;

#| The location or path to where the component was found.
    has Str $.location is required;

#| The line number where the component was found.    
    has PositiveInt $.line;

#| The offset where the component was found.
    has PositiveInt $.offset;

#| The symbol name that was found associated with the component.
    has Str $.symbol;

#| Any additional context of the detected component (e.g. a code snippet).
    has Str $.additionalContext;
}

# vim: expandtab shiftwidth=4
