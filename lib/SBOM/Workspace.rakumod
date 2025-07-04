use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  AccessMode
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Volume:ver<0.0.1>:auth<zef:lizmat>;

#| A named filesystem or data resource shareable by workflow tasks.
class SBOM::Workspace:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref           $.bom-ref is required;
    has Str               $.uid     is required;
    has Str               $.name;
    has Str               @.aliases;
    has Str               $.description;
    has SBOM::resourceRef @.resourceReferences;
    has AccessMode        $.accessMode;
    has Str               $.mountPath;
    has Str               $.managedDataType;
    has Str               $.volumeRequest;
    has SBOM::Volume      $.volume;
    has SBOM::NameValue   @.properties;
}

# vim: expandtab shiftwidth=4
