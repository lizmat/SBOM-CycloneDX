use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <bom-ref>;

use SBOM::EnergyType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::UnitType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyProvided:ver<0.0.1>:auth<zef:lizmat> {
    has Rat            $.value is required;
    has SBOM::UnitType $.unit  is required;
}

class SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref              $.bom-ref;
    has Str                  $.description;
    has SBOM::Organization   $.organization   is required;
    has SBOM::EnergyType     $.energySource   is required;
    has SBOM::EnergyProvided $.energyProvided is required;
    has SBOM::Reference      @.externalReferences;
}

# vim: expandtab shiftwidth=4
