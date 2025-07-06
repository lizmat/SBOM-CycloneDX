use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Activity
>;

use SBOM::CO2Cost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;

#| Describes energy consumption information incurred during a component's
#| lifecycle activities.
class SBOM::EnergyConsumption:ver<0.0.1>:auth<zef:lizmat> {

#| The type of activity that is part of a machine learning model
#| development or operational lifecycle.
    has Activity $.activity is required;

#| The provider(s) of the energy consumed by the associated model
#| development lifecycle activity.
    has SBOM::EnergyProvider @.energyProviders    is required;

#| The total energy cost associated with the model lifecycle activity.
    has SBOM::EnergyCost $.activityEnergyCost is required;

#| The CO2 cost (debit) equivalent to the total energy cost.
    has SBOM::CO2Cost $.co2CostEquivalent;

#| The CO2 offset (credit) for the CO2 equivalent cost.
    has SBOM::CO2Cost $.co2CostOffset;

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
