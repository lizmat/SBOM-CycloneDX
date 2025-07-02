use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <serialNumber>;

use SBOM::Component:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Metadata:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.1>:auth<zef:lizmat>;

#-------------------------------------------------------------------------------
class SBOM::CycloneDX:ver<0.0.1>:auth<zef:lizmat> {
    has serialNumber    $.serialNumber;
    has Int             $.version = 1;
    has SBOM::Metadata  $.metadata;
    has SBOM::Component @.components;
    has SBOM::Service   @.services;
    has SBOM::Reference @.externalReferences;

    method bomFormat()   { "CycloneDX" }
    method specVersion() { v1.6        }

    method updated() { ++$!version }
}

# vim: expandtab shiftwidth=4
