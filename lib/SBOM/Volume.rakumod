use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  VolumeMode
>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Volume:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.uid;
    has Str             $.name;
    has VolumeMode      $.mode;
    has Str             $.path;
    has Str             $.sizeAllocated;
    has Bool            $.persistent;
    has Bool            $.remote;
    has SBOM::NameValue @.properties;

    method WHY() {
        "Information about the actual volume instance allocated to the workspace."
    }
}

# vim: expandtab shiftwidth=4
