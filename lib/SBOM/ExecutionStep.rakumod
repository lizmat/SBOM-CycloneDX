use SBOM:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.5>:auth<zef:lizmat>;

#- Command ---------------------------------------------------------------------
#| Command or directive for a step
class SBOM::Command:ver<0.0.5>:auth<zef:lizmat> does SBOM {

#| A text representation of the executed command.
    has Str $.executed;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;
}

#- ExecutionStep ---------------------------------------------------------------
#| Executes specific commands or tools in order to accomplish its
#| owning task as part of a sequence.
class SBOM::ExecutionStep:ver<0.0.5>:auth<zef:lizmat> does SBOM {

#| A name for the step.
    has Str $.name;

#| A description for the step.
    has Str $.description;;

#| Ordered list of commands or directives for the step.
    has SBOM::Command @.commands;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;
}

# vim: expandtab shiftwidth=4
