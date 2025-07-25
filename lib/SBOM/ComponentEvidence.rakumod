use SBOM::subsets:ver<0.0.9>:auth<zef:lizmat> <
  bom-ref PositiveInt
>;

use SBOM:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Identity:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.9>:auth<zef:lizmat>;

#- Frame -----------------------------------------------------------------------
#| Within a call stack, a frame is a discrete unit that encapsulates
#| an execution context, including local variables, parameters, and
#| the return address. As function calls are made, frames are pushed
#| onto the stack, forming an array-like structure that orchestrates
#| the flow of program execution and manages the sequence of function
#| invocations.
class SBOM::Frame:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| A package organizes modules into namespaces, providing a unique
#| namespace for each type it contains.
    has Str $.package;

#| A module or class that encloses functions/methods and other code.
    has Str $.module is required;

#| A block of code designed to perform a particular task.
    has Str $.function;

#| Optional arguments that are passed to the module or function.
    has Str @.parameters;

#| The line number the code that is called resides on.
    has PositiveInt $.line;

#| The column the code that is called resides.
    has PositiveInt $.column;

#| The full path and filename of the module.
    has Str $.fullFilename;

    # These should probably be auto-generated in RakUAST at some point
    method parameters(SBOM::Frame:D:) { @!parameters.List }
}

#- Callstack -------------------------------------------------------------------
#| Evidence of component use through the callstack.
class SBOM::Callstack:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| The frames seen in the callstack.
    has SBOM::Frame @.frames;

    # These should probably be auto-generated in RakUAST at some point
    method frames(SBOM::Callstack:D:) { @!frames.List }
}

#- Copyright -------------------------------------------------------------------
#| Copyright evidence captures intellectual property assertions,
#| providing evidence of possible ownership and legal protection.
class SBOM::Copyright:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| The textual content of the copyright.
    has Str $.text is required;
}

#- Occurrence ------------------------------------------------------------------
#| Evidence of instance of a component spread across multiple locations.
class SBOM::Occurrence:ver<0.0.9>:auth<zef:lizmat> does SBOM {

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

#- ComponentEvidence -----------------------------------------------------------
#| The ability to document evidence about a component, collected
#| through various forms of extraction or analysis.
class SBOM::ComponentEvidence:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| Evidence of individual instances of a component spread across
#| multiple locations.
    has SBOM::Occurrence @.occurrences;

#| Evidence of the components use through the callstack.
    has SBOM::Callstack $.callstack;

#| EITHER (list of SPDX licenses and/or named licenses) OR (tuple
#| of one SPDX License Expression).
    has SBOM::AnyLicense @.licenses;

#| A copyright notice informing users of the underlying claims to
#| copyright ownership in a published work.
    has SBOM::Copyright @.copyright;

#| [DEPRECATED] Evidence that substantiates the identity of a component.
    has SBOM::Identity $!identity;

#| Evidence that substantiates the identity of a component. The
#| identity may be an object or an array of identity objects.
#| Support for specifying identity as a single object was introduced
#| in CycloneDX v1.5. Arrays were introduced in v1.6. It is
#| recommended that all implementations use arrays, even if only one
#| identity object is specified.
    has SBOM::Identity @!identity;

    method TWEAK-nameds(SBOM::ComponentEvidence:) { ("identity",) }

    submethod TWEAK(:$identity) {
        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);

        if $identity ~~ Positional {
            @!identity = $identity<>.map: {
                $_ ~~ SBOM ?? $_ !! SBOM::Identity.new(|$_)
            }
        }
        elsif $identity.defined {
            $!identity := $identity ~~ SBOM
              ?? $identity<>
              !! SBOM::Identity.new(|$identity<>);
        }

        method identity(SBOM::ComponentEvidence:D:) {
            $!identity // @!identity.List
        }
    }

    # These should probably be auto-generated in RakUAST at some point
    method occurrences(SBOM::ComponentEvidence:D:) { @!occurrences.List }
    method licenses(   SBOM::ComponentEvidence:D:) { @!licenses.List    }
    method copyright(  SBOM::ComponentEvidence:D:) { @!copyright.List   }
}

# vim: expandtab shiftwidth=4
