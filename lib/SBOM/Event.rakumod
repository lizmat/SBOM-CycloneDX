use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

#| The event data that caused the associated trigger to activate.
class SBOM::Event:ver<0.0.1>:auth<zef:lizmat> {

#| The unique identifier of the event.
    has Str $.uid;

#| A description of the event.
    has Str $.description;

#| The date and time (timestamp) when the event was received.
    has DateTime $.timeReceived;

#| Encoding of the raw event data.
    has SBOM::Attachment $.data;

#| References the component or service that was the source of the event.
    has SBOM::resourceRef $.source;

#| References the component or service that was the target of the event.
    has SBOM::resourceRef $.target;

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
