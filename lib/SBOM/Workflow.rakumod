use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::RuntimeTopology:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Workspace:ver<0.0.1>:auth<zef:lizmat>;

#| A specialized orchestration task.
class SBOM::Workflow:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref               $.bom-ref is required;
    has Str                   $.uid     is required;
    has Str                   $.name;
    has Str                   $.description;
    has SBOM::resourceRef     @.resourceReferences;
    has SBOM::Workspace       @.worksSpaces;
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
