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

class SBOM::Trigger:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref         $.bom-ref is required;
    has Str             $.uid     is required;
    has Str             $.name;
    has Str             $.description;
    has resourceRef     @.resourceReferences;
    has TaskActivity    @.taskTypes is required;
    has TriggerEvent    $.type;
    has SBOM::Event     $.event;
    has SBOM::Condition @.conditions;
    has DateTime        $.timeActivated;
    has SBOM::Input     @.inputs;
    has SBOM::Output    @.outputs;
    has SBOM::NameValue @.properties;

    submethod TWEAK() {
        if @!resourceReferences {
            die "Mixed references"
              unless @!resourceReferences.are(SBOM::Reference)
                  || @!resourceReferences.all ~~ resourceRef;
        }
    }

    method WHY() {
        "The trigger that initiated the task."
    }
}

# vim: expandtab shiftwidth=4
