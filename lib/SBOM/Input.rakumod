use SBOM:ver<0.0.12>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.12>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.12>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.12>:auth<zef:lizmat>;

#- Parameter -------------------------------------------------------------------
#| A representation of a functional parameter.
class SBOM::Parameter:ver<0.0.12>:auth<zef:lizmat> does SBOM {
#| The name of the parameter.
    has Str $.name;

#| The value of the parameter.
    has Str $.value;

#| The data type of the parameter.
    has Str $.dataType;
}

#- Input -----------------------------------------------------------------------
#| Type that represents various input data types and formats.
class SBOM::Input:ver<0.0.12>:auth<zef:lizmat> does SBOM {

#| A reference to the component or service that provided the input to the task (e.g., reference to a service with data flow value of inbound)
    has SBOM::ResourceReference $.source;

#| A reference to the component or service that received or stored the input if not the task itself (e.g., a local, named storage workspace)
    has SBOM::ResourceReference $.target;

#| A reference to an independent resource provided as an input to a task by the workflow runtime.
    has SBOM::ResourceReference $.resource;

#| Inputs that have the form of parameters with names and values.
    has SBOM::Parameter @.parameters;

#| Inputs that have the form of data.
    has SBOM::Attachment $.data;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

#| Inputs that have the form of parameters with names and values.
    has @.environmentVars is built(False);

    method TWEAK-nameds(SBOM::Input:) { ("environmentVars",) }

    submethod TWEAK(:@!environmentVars) {

        for @!environmentVars {
            $_ = SBOM::Property.new(|$_) if $_ ~~ Associative;
        }

        die "Must have at least 'resource', 'parameters', 'environmentVars' or 'data'"
          unless $!resource || @!parameters || @!environmentVars || $!data;
    }

    # These should probably be auto-generated in RakUAST at some point
    method parameters(     SBOM::Input:D:) { @!parameters.List      }
    method properties(     SBOM::Input:D:) { @!properties.List      }
    method environmentVars(SBOM::Input:D:) { @!environmentVars.List }
}

# vim: expandtab shiftwidth=4
