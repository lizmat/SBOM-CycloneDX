use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  VolumeMode
>;

use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;

#| Information about the actual volume instance allocated to the workspace.
class SBOM::Volume:ver<0.0.1>:auth<zef:lizmat> {

#| The unique identifier for the volume instance within its deployment
#| context.
    has Str $.uid;

#| The name of the volume instance.
    has Str $.name;

#| The mode for the volume instance.
    has VolumeMode $.mode;

#| The underlying path created from the actual volume.
    has Str $.path;

#| The allocated size of the volume accessible to the associated
#| workspace. This should include the scalar size as well as IEC
#| standard unit in either decimal or binary form.
    has Str $.sizeAllocated;

#| Indicates if the volume persists beyond the life of the resource it
#| is associated with.
    has Bool $.persistent;

#| Indicates if the volume is remotely (i.e., network) attached.
    has Bool $.remote;

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
