use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  TaskActivity TriggerEvent
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Condition:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Event:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Input:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Output:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;

#| The trigger that initiated the task.
class SBOM::Trigger:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref           $.bom-ref is required;
    has Str               $.uid     is required;
    has Str               $.name;
    has Str               $.description;
    has SBOM::resourceRef @.resourceReferences;
    has TaskActivity      @.taskTypes is required;
    has TriggerEvent      $.type;
    has SBOM::Event       $.event;
    has SBOM::Condition   @.conditions;
    has DateTime          $.timeActivated;
    has SBOM::Input       @.inputs;
    has SBOM::Output      @.outputs;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::NameValue @.properties;

    submethod TWEAK() {
        if @!resourceReferences {
            die "Mixed references"
              unless @!resourceReferences.are(SBOM::Reference)
                  || @!resourceReferences.all ~~ SBOM::resourceRef;
        }
    }
}

# vim: expandtab shiftwidth=4
