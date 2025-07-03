use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Component:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Workflow:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Formulation:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref         $.bom-ref;
    has SBOM::Component @.components;
    has SBOM::Service   @.services;;
    has SBOM::Workflow  @.workflows;
    has SBOM::NameValue @.properties;

    method description() {
        "Describes how a component or service was manufactured or deployed. This is achieved through the use of formulas, workflows, tasks, and steps, which declare the precise steps to reproduce along with the observed formulas describing the steps which transpired in the manufacturing process."
    }
}

# vim: expandtab shiftwidth=4
