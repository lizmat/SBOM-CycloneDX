use SBOM::enums:ver<0.0.3>:auth<zef:lizmat> <
  OutputType
>;

use SBOM:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.3>:auth<zef:lizmat>;

#- Output ----------------------------------------------------------------------
#| Represents resources and data output from a task at runtime by
#| executor or task commands.
class SBOM::Output:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| Describes the type of data output.
    has OutputType $.type;

#| Component or service that generated or provided the output from
#| a task (e.g., a build tool)
    has SBOM::resourceRef $.source;

#| Component or service that received the output from the task
#| (e.g., reference to an artifactory service with data flow value
#| of outbound).
    has SBOM::resourceRef $.target;

#| A reference to an independent resource generated as output by a task.
    has SBOM::resourceRef $.resource;

#| Outputs that have the form of data.
    has SBOM::Attachment $.data;

#| Outputs that have the form of environment variables.
    has SBOM::StrOrProperty @.environmentVars;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    submethod TWEAK() {
        die "Must have at least 'resource', 'environmentVars' or 'data'"
          unless $!resource  || @!environmentVars || $!data;
    }
}

# vim: expandtab shiftwidth=4
