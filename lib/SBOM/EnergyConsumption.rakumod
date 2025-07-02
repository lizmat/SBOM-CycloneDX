use SBOM::ActivityType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CO2Cost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyConsumption:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::ActivityType   $.activity           is required;
    has SBOM::EnergyProvider @.energyProviders    is required;
    has SBOM::EnergyCost     $.activityEnergyCost is required;
    has SBOM::CO2Cost        $.co2CostEquivalent;
    has SBOM::CO2Cost        $.co2CostOffset;
    has SBOM::NameValue      @.properties;
}

# vim: expandtab shiftwidth=4
