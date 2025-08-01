use SBOM::enums:ver<0.0.12>:auth<zef:lizmat> <
  OutputType
>;

use SBOM:ver<0.0.12>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.12>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.12>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.12>:auth<zef:lizmat>;

#- Output ----------------------------------------------------------------------
#| Represents resources and data output from a task at runtime by
#| executor or task commands.
class SBOM::Output:ver<0.0.12>:auth<zef:lizmat> does SBOM {

#| Describes the type of data output.
    has OutputType $.type;

#| Component or service that generated or provided the output from
#| a task (e.g., a build tool)
    has SBOM::ResourceReference $.source;

#| Component or service that received the output from the task
#| (e.g., reference to an artifactory service with data flow value
#| of outbound).
    has SBOM::ResourceReference $.target;

#| A reference to an independent resource generated as output by a task.
    has SBOM::ResourceReference $.resource;

#| Outputs that have the form of data.
    has SBOM::Attachment $.data;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

#| Outputs that have the form of environment variables.
    has @.environmentVars is built(False);

    method TWEAK-nameds(SBOM::Output:) { ("environmentVars",) }

    submethod TWEAK(:@!environmentVars) {

        for @!environmentVars {
            $_ = SBOM::Property.new(|$_) if $_ ~~ Associative;
        }

        die "Must have at least 'resource', 'environmentVars' or 'data'"
          unless $!resource  || @!environmentVars || $!data;
    }

    # These should probably be auto-generated in RakUAST at some point
    method properties(     SBOM::Output:D:) { @!properties.List      }
    method environmentVars(SBOM::Output:D:) { @!environmentVars.List }
}

# vim: expandtab shiftwidth=4
