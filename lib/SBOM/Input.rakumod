use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Parameter:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

#| Type that represents various input data types and formats.
class SBOM::Input:ver<0.0.1>:auth<zef:lizmat> {

    #| A reference to the component or service that provided the input to the task (e.g., reference to a service with data flow value of inbound)
    has SBOM::resourceRef $.source;

    #| A reference to the component or service that received or stored the input if not the task itself (e.g., a local, named storage workspace)
    has SBOM::resourceRef $.target;

    #| A reference to an independent resource provided as an input to a task by the workflow runtime.
    has SBOM::resourceRef $.resource;

    #| Inputs that have the form of parameters with names and values.
    has SBOM::Parameter @.parameters;

    #| Inputs that have the form of parameters with names and values.
    has SBOM::StrOrProperty @.environmentVars;

    #| Inputs that have the form of data.
    has SBOM::Attachment $.data;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::Property @.properties;

    submethod TWEAK() {
        die "Must have at least 'resource', 'parameters', 'environmentVars' or 'data'"
          unless $!resource || @!parameters || @!environmentVars || $!data;
    }
}

# vim: expandtab shiftwidth=4
