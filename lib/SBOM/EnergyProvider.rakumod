use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <bom-ref>;

use SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref            $.bom-ref;
    has Str                $.description;
    has SBOM::Organization $.organization   is required;
    has SBOM::EnergyType   $.energySource   is required;
    has SBOM::EnergyCost   $.energyProvided is required;
    has SBOM::Reference    @.externalReferences;
}

# vim: expandtab shiftwidth=4
