use SBOM::Command:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;

#| Executes specific commands or tools in order to accomplish its
#| owning task as part of a sequence.
class SBOM::ExecutionStep:ver<0.0.1>:auth<zef:lizmat> {

#| A name for the step.
    has Str $.name;
    
#| A description for the step.
    has Str $.description;;

#| Ordered list of commands or directives for the step.
    has SBOM::Command @.commands;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::Property @.properties;
}

# vim: expandtab shiftwidth=4
