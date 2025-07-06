use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  TriggerEvent
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Condition:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Event:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Input:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Output:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;

#| The trigger that initiated a task.
class SBOM::Trigger:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the trigger
#| elsewhere in the BOM.
    has bom-ref $.bom-ref is required;

#| The unique identifier for the resource instance within its
#| deployment context.
    has Str $.uid is required;

#| The name of the resource instance.
    has Str $.name;

#| A description of the resource instance.
    has Str $.description;

#| References to component or service resources that are used to
#| realize the resource instance.
    has SBOM::resourceRef @.resourceReferences;

#| The source type of event which caused the trigger to fire.
    has TriggerEvent $.type;

#| The event data that caused the associated trigger to activate.
    has SBOM::Event $.event;

#| A list of conditions used to determine if a trigger should be
#| activated.
    has SBOM::Condition @.conditions;

#| The date and time (timestamp) when the trigger was activated.
    has DateTime $.timeActivated;

#| Represents resources and data brought into a task at runtime by
#| executor or task commands.
    has SBOM::Input @.inputs;

#| Represents resources and data output from a task at runtime by
#| executor or task commands.
    has SBOM::Output @.outputs;

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
        if @!resourceReferences {
            die "Mixed references"
              unless @!resourceReferences.are(SBOM::Reference)
                  || @!resourceReferences.all ~~ SBOM::resourceRef;
        }
    }
}

# vim: expandtab shiftwidth=4
