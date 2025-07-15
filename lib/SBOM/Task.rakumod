use SBOM::enums:ver<0.0.5>:auth<zef:lizmat> <
  TaskActivity
>;

use SBOM::subsets:ver<0.0.5>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::ExecutionStep:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::Input:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::Output:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::RuntimeTopology:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::Trigger:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::Workspace:ver<0.0.5>:auth<zef:lizmat>;

#- Task ------------------------------------------------------------------------
#| Describes the inputs, sequence of steps and resources used to
#| accomplish a task and its output.
class SBOM::Task:ver<0.0.5>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the task
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
    has SBOM::ResourceReference @.resourceReferences;

#| Indicates the types of activities performed by the set of
#| workflow tasks.
    has TaskActivity @.taskTypes is required;

#| The trigger that initiated the task.
    has SBOM::Trigger $.trigger;

#| The sequence of steps for the task.
    has SBOM::ExecutionStep @.steps;

#| Represents resources and data brought into a task at runtime by
#| executor or task commands.
    has SBOM::Input @.inputs;

#| Represents resources and data output from a task at runtime by
#| executor or task commands
    has SBOM::Output @.outputs;

#| The date and time (timestamp) when the task started.
    has DateTime $.timeStart;

#| The date and time (timestamp) when the task ended.
    has DateTime $.timeEnd;

#| A set of named filesystem or data resource shareable by workflow
#| tasks.
    has SBOM::Workspace @.workspaces;

#| A graph of the component runtime topology for task's instance.
    has SBOM::RuntimeTopology @.runtimeTopology;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    submethod TWEAK() {
        if @!resourceReferences {
            die "Mixed references"
              unless @!resourceReferences.are(SBOM::Reference)
                  || @!resourceReferences.all ~~ SBOM::ResourceReference;
        }
    }
}

# vim: expandtab shiftwidth=4
