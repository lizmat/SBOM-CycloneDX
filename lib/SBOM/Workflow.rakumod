use SBOM::enums:ver<0.0.9>:auth<zef:lizmat> <
  TaskActivity
>;

use SBOM::subsets:ver<0.0.9>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Dependency:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::ExecutionStep:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::RuntimeTopology:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Task:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Trigger:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Workspace:ver<0.0.9>:auth<zef:lizmat>;

#- Workflow --------------------------------------------------------------------
#| A specialized orchestration task.
class SBOM::Workflow:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the workflow
#| elsewhere in the BOM.
    has bom-ref $.bom-ref is required;

#| The unique identifier for the resource instance within its
#| deployment context.
    has Str $.uid is required;

#| The name of the resource instance.
    has Str $.name;

#| A description of the resource instance.
    has Str $.description;

#| References to component or service resources that are used toi
#| realize the resource instance.
    has SBOM::ResourceReference @.resourceReferences;

#| The tasks that comprise the workflow.
    has SBOM::Task @.tasks;

#| The graph of dependencies between tasks within the workflow.
    has SBOM::Dependency @.taskDependencies;

#| Indicates the types of activities performed by the set of workflow tasks.
    has TaskActivity @.taskTypes;

#| The trigger that initiated the task.
    has SBOM::Trigger $.trigger;

#| The sequence of steps for the task.
    has SBOM::ExecutionStep @.steps;

#| Represents resources and data brought into a task at runtime by
#| executor or task commands.
    has SBOM::Input @.inputs;

#| Represents resources and data output from a task at runtime by
#| executor or task commands.
    has SBOM::Input @.outputs;

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

    # These should probably be auto-generated in RakUAST at some point
    method resourceReferences(SBOM::Workflow:D:) { @!resourceReferences.List }
    method tasks(             SBOM::Workflow:D:) { @!tasks.List              }
    method taskDependecies(   SBOM::Workflow:D:) { @!taskDependencies.List   }
    method taskTypes(         SBOM::Workflow:D:) { @!taskTypes.List          }
    method steps(             SBOM::Workflow:D:) { @!steps.List              }
    method inputs(            SBOM::Workflow:D:) { @!inputs.List             }
    method outputs(           SBOM::Workflow:D:) { @!outputs.List            }
    method workspaces(        SBOM::Workflow:D:) { @!workspaces.List         }
    method runtimeTopology(   SBOM::Workflow:D:) { @!runtimeTopology.List    }
    method properties(        SBOM::Workflow:D:) { @!properties.List         }
}

# vim: expandtab shiftwidth=4
