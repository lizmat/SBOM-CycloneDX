use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Component:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Workflow:ver<0.0.1>:auth<zef:lizmat>;

#- Formulation -----------------------------------------------------------------
#| Describes how a component or service was manufactured or deployed.
#| This is achieved through the use of formulas, workflows, tasks, and
#| steps, which declare the precise steps to reproduce along with the
#| observed formulas describing the steps which transpired in the
#| manufacturing process.
class SBOM::Formulation:ver<0.0.1>:auth<zef:lizmat> {

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

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::Property @.properties;
}

# vim: expandtab shiftwidth=4
