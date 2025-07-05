use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

#| The event data that caused the associated trigger to activate.
class SBOM::Event:ver<0.0.1>:auth<zef:lizmat> {
    has Str               $.uid;
    has Str               $.description;
    has DateTime          $.timeReceived;
    has SBOM::Text        $.data;
    has SBOM::resourceRef $.source;
    has SBOM::resourceRef $.target;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::NameValue @.properties;
}

# vim: expandtab shiftwidth=4
