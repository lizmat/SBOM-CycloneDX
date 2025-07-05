use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Activity
>;

use SBOM::CO2Cost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyConsumption:ver<0.0.1>:auth<zef:lizmat> {
    has Activity             $.activity           is required;
    has SBOM::EnergyProvider @.energyProviders    is required;
    has SBOM::EnergyCost     $.activityEnergyCost is required;
    has SBOM::CO2Cost        $.co2CostEquivalent;
    has SBOM::CO2Cost        $.co2CostOffset;

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
