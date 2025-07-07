use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Activity CO2Cost Energy EnergyUnit
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;

#- CO2Cost ---------------------------------------------------------------------
#| An expression of CO2 cost.
class SBOM::CO2Cost:ver<0.0.1>:auth<zef:lizmat> {

#| Quantity of carbon dioxide (CO2).
    has Rat $.value is required;

#| Unit of carbon dioxide (CO2).
    has CO2Cost $.unit is required;
}

#- EnergyCost ------------------------------------------------------------------
#| The energy provided by the energy source for an associated activity.
class SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat> {

#| Quantity of energy.
    has Rat $.value is required;

#| Unit of energy.
    has EnergyUnit $.unit  is required;
}

#- EnergyProvider --------------------------------------------------------------
#| The provider of the energy consumed by a model during its
#| development lifecycle activity.
class SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the energy
#| provider elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| A description of the energy provider.
    has Str $.description;

#| The organization that provides energy.
    has SBOM::Organization $.organization is required;

#| The energy source for the energy provider.
    has Energy $.energySource   is required;

#| The energy provided by the energy source for an associated activity.
    has SBOM::EnergyCost  $.energyProvided is required;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference    @.externalReferences;
}

#- EnergyConsumption -----------------------------------------------------------
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

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;
}

# vim: expandtab shiftwidth=4
