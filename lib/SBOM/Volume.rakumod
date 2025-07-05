use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  VolumeMode
>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

#| Information about the actual volume instance allocated to the workspace.
class SBOM::Volume:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.uid;
    has Str             $.name;
    has VolumeMode      $.mode;
    has Str             $.path;
    has Str             $.sizeAllocated;
    has Bool            $.persistent;
    has Bool            $.remote;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::NameValue @.properties;
}

# vim: expandtab shiftwidth=4
