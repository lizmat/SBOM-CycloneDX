use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  TaskActivity TriggerEvent
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::ExecutionStep:ver<0.0.1>:auth<zef:lizmat>
use SBOM::Input:ver<0.0.1>:auth<zef:lizmat>
use SBOM::Output:ver<0.0.1>:auth<zef:lizmat>
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Trigger:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Task:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref              $.bom-ref is required;
    has Str                  $.uid     is required;
    has Str                  $.name;
    has Str                  $.description;
    has resourceRef          @.resourceReferences;
    has TaskActivity         @.taskTypes is required;
    has SBOM::Trigger        $.trigger;
    has SBOM::ExecutionStep  @.steps;
    has SBOM::Input          @.inputs;
    has SBOM::Output         @.outputs;
    has DateTime             $.timeStart;
    has DateTime             $.timeEnd;

    submethod TWEAK() {
        if @!resourceReferences {
            die "Mixed references"
              unless @!resourceReferences.are(SBOM::Reference)
                  || @!resourceReferences.all ~~ resourceRef;
    }

    method WHY() {
        "Describes the inputs, sequence of steps and resources used to accomplish a task and its output."
    }
}

# vim: expandtab shiftwidth=4
