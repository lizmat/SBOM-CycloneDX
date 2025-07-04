use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  TaskActivity
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::ExecutionStep:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Input:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Output:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::RuntimeTopology:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Trigger:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Workspace:ver<0.0.1>:auth<zef:lizmat>;

#| Describes the inputs, sequence of steps and resources used to accomplish a task and its output.
class SBOM::Task:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref               $.bom-ref is required;
    has Str                   $.uid     is required;
    has Str                   $.name;
    has Str                   $.description;
    has SBOM::resourceRef     @.resourceReferences;
    has TaskActivity          @.taskTypes is required;
    has SBOM::Trigger         $.trigger;
    has SBOM::ExecutionStep   @.steps;
    has SBOM::Input           @.inputs;
    has SBOM::Output          @.outputs;
    has DateTime              $.timeStart;
    has DateTime              $.timeEnd;
    has SBOM::Workspace       @.workspaces;
    has SBOM::RuntimeTopology @.runtimeTopology;
    has SBOM::NameValue       @.properties;

    submethod TWEAK() {
        if @!resourceReferences {
            die "Mixed references"
              unless @!resourceReferences.are(SBOM::Reference)
                  || @!resourceReferences.all ~~ SBOM::resourceRef;
        }
    }
}

# vim: expandtab shiftwidth=4
