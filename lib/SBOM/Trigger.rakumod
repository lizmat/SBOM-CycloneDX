use SBOM::enums:ver<0.0.3>:auth<zef:lizmat> <
  TriggerEvent
>;

use SBOM::subsets:ver<0.0.3>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Input:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Output:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.3>:auth<zef:lizmat>;

#- Condition -------------------------------------------------------------------
#| A condition that was used to determine a trigger should be activated.
class SBOM::Condition:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| Describes the set of conditions which cause the trigger to activate.
    has Str $.description;

#| The logical expression that was evaluated that determined the trigger
#| should be fired.
    has Str $.expression;;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;
}

#- Event -----------------------------------------------------------------------
#| The event data that caused the associated trigger to activate.
class SBOM::Event:ver<0.0.3>:auth<zef:lizmat> does SBOM {

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

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;
}

#- Trigger ---------------------------------------------------------------------
#| The trigger that initiated a task.
class SBOM::Trigger:ver<0.0.3>:auth<zef:lizmat> does SBOM {

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

#| Any additional properties as name-value pairs.
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
