use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;

#| A condition that was used to determine a trigger should be activated.
class SBOM::Condition:ver<0.0.1>:auth<zef:lizmat> {

#| Describes the set of conditions which cause the trigger to activate.
    has Str $.description;

#| The logical expression that was evaluated that determined the trigger
#| should be fired.
    has Str $.expression;;

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
