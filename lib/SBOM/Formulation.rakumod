use SBOM::subsets:ver<0.0.7>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Component:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Workflow:ver<0.0.7>:auth<zef:lizmat>;

#- Formulation -----------------------------------------------------------------
#| Describes how a component or service was manufactured or deployed.
#| This is achieved through the use of formulas, workflows, tasks, and
#| steps, which declare the precise steps to reproduce along with the
#| observed formulas describing the steps which transpired in the
#| manufacturing process.
class SBOM::Formulation:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the formula
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| Transient components that are used in tasks that constitute one or
#| more of this formula's workflows.
    has SBOM::Component @.components;

#| Transient services that are used in tasks that constitute one or
#| more of this formula's workflows.
    has SBOM::Service @.services;

#| List of workflows that can be declared to accomplish specific
#| orchestrated goals and independently triggered.
    has SBOM::Workflow @.workflows;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    # These should probably be auto-generated in RakUAST at some point
    method components(SBOM::Formulation:D:) { @!components.List }
    method services(  SBOM::Formulation:D:) { @!services.List   }
    method workflows( SBOM::Formulation:D:) { @!workflows.List  }
    method properties(SBOM::Formulation:D:) { @!properties.List }
}

# vim: expandtab shiftwidth=4
