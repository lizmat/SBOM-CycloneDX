use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  AccessMode
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Volume:ver<0.0.1>:auth<zef:lizmat>;

#| A named filesystem or data resource shareable by workflow tasks.
class SBOM::Workspace:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the workspace
#| elsewhere in the BOM.
    has bom-ref $.bom-ref is required;

#| The unique identifier for the resource instance within its deployment
#| context.
    has Str $.uid is required;

#| The name of the resource instance.
    has Str $.name;

#| The names for the workspace as referenced by other workflow tasks.
#| Effectively, a name mapping so other tasks can use their own local
#| name in their steps.
    has Str @.aliases;

#| A description of the resource instance.
    has Str $.description;

#| References to component or service resources that are used to realize
#| the resource instance.
    has SBOM::resourceRef @.resourceReferences;

#| Describes the read-write access Acontrol for the workspace relative
#| to the owning resource instance.
    has AccessMode $.accessMode;

#| A path to a location on disk where the workspace will be available
#| to the associated task's steps.
    has Str $.mountPath;

#| The name of a domain-specific data type the workspace represents.
    has Str $.managedDataType;

#| Identifies the reference to the request for a specific volume type
#| and parameters.
    has Str $.volumeRequest;

#| Information about the actual volume instance allocated to the
#| workspace.
    has SBOM::Volume $.volume;

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
