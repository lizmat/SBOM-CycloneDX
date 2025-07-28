use SBOM::enums:ver<0.0.10>:auth<zef:lizmat> <
  Activity CO2Cost Energy EnergyUnit
>;

use SBOM::subsets:ver<0.0.10>:auth<zef:lizmat> <
  bom-ref number
>;

use SBOM:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.10>:auth<zef:lizmat>;

#- CO2Cost ---------------------------------------------------------------------
#| An expression of CO2 cost.
class SBOM::CO2Cost:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| Quantity of carbon dioxide (CO2).
    has number $.value is required;

#| Unit of carbon dioxide (CO2).
    has CO2Cost $.unit is required;
}

#- EnergyCost ------------------------------------------------------------------
#| The energy provided by the energy source for an associated activity.
class SBOM::EnergyCost:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| Quantity of energy.
    has number $.value is required;

#| Unit of energy.
    has EnergyUnit $.unit is required;
}

#- EnergyProvider --------------------------------------------------------------
#| The provider of the energy consumed by a model during its
#| development lifecycle activity.
class SBOM::EnergyProvider:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the energy
#| provider elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| A description of the energy provider.
    has Str $.description;

#| The organization that provides energy.
    has SBOM::Organization $.organization is required;

#| The energy source for the energy provider.
    has Energy $.energySource is required;

#| The energy provided by the energy source for an associated activity.
    has SBOM::EnergyCost $.energyProvided is required;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences;

    # These should probably be auto-generated in RakUAST at some point
    method externalReferences(SBOM::EnergyProvider:D:) {
        @!externalReferences.List
    }
}

#- EnergyConsumption -----------------------------------------------------------
#| Describes energy consumption information incurred during a component's
#| lifecycle activities.
class SBOM::EnergyConsumption:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| The type of activity that is part of a machine learning model
#| development or operational lifecycle.
    has Activity $.activity is required;

#| The provider(s) of the energy consumed by the associated model
#| development lifecycle activity.
    has SBOM::EnergyProvider @.energyProviders is required;

#| The total energy cost associated with the model lifecycle activity.
    has SBOM::EnergyCost $.activityEnergyCost is required;

#| The CO2 cost (debit) equivalent to the total energy cost.
    has SBOM::CO2Cost $.co2CostEquivalent;

#| The CO2 offset (credit) for the CO2 equivalent cost.
    has SBOM::CO2Cost $.co2CostOffset;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    # These should probably be auto-generated in RakUAST at some point
    method energyProviders(SBOM::EnergyConsumption:D:) {
        @!energyProviders.List
    }
    method properties(SBOM::EnergyConsumption:D:) {
        @!properties.List
    }
}

#- EthicalConsideration --------------------------------------------------------
#| What are the ethical risks involved in the application of a model?
class SBOM::EthicalConsideration:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| The name of the risk.
    has Str $.name;

#| Strategy used to address this risk.
    has Str $.mitigationStrategy;
}

#- EnvironmentalConsiderations -------------------------------------------------
#| What are the various environmental impacts a machine learning model
#| has exhibited across its lifecycle?
class SBOM::EnvironmentalConsiderations:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| Describes energy consumption information incurred for one or more
#| component lifecycle activities.
    has SBOM::EnergyConsumption @.energyConsumptions;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    # These should probably be auto-generated in RakUAST at some point
    method energyConsumptions(SBOM::EnvironmentalConsiderations:D:) {
        @!energyConsumptions.List
    }
    method properties(SBOM::EnvironmentalConsiderations:D:) {
        @!properties.List
    }
}

#- FairnessAssessment ----------------------------------------------------------
#| How does the model affect groups at risk of being systematically
#| disadvantaged? What are the harms and benefits to the various
#| affected groups?
class SBOM::FairnessAssessment:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| The groups or individuals at risk of being systematically
#| disadvantaged by the model.
    has Str $.groupAtRisk;

#| Expected benefits to the identified groups.
    has Str $.benefits;

#| Expected harms to the identified groups.
    has Str $.harms;

#| With respect to the benefits and harms outlined, please describe any
#| mitigation strategy implemented.
    has Str $.mitigationStrategy;
}

#- Considerations --------------------------------------------------------------
#| What considerations should be taken into account regarding a model's
#| construction, training, and application?
class SBOM::Considerations:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| Who are the intended users of the model?
    has Str @.users;

#| What are the intended use cases of the model?
    has Str @.useCases;

#| What are the known technical limitations of the model? E.g. What
#| kind(s) of data should the model be expected not to perform well
#| on? What are the factors that might degrade model performance?
    has Str @.technicalLimitations;

#| What are the known tradeoffs in accuracy/performance of the model?
    has Str @.performanceTradeoffs;

#| What are the ethical risks involved in the application of this model?
    has SBOM::EthicalConsideration @.ethicalConsiderations;

#| What are the various environmental impacts the corresponding machine
#| learning model has exhibited across its lifecycle?
    has SBOM::EnvironmentalConsiderations $.environmentalConsiderations;

#| How does the model affect groups at risk of being systematically
#| disadvantaged? What are the harms and benefits to the various
#| affected groups?
    has SBOM::FairnessAssessment @.fairnessAssessments;

    # These should probably be auto-generated in RakUAST at some point
    method users(SBOM::Considerations:D:) {
        @!users.List
    }
    method useCases(SBOM::Considerations:D:) {
        @!useCases.List
    }
    method technicalLimitations(SBOM::Considerations:D:) {
        @!technicalLimitations.List
    }
    method performanceTradeoffs(SBOM::Considerations:D:) {
        @!performanceTradeoffs.List
    }
    method ethicalConsiderations(SBOM::Considerations:D:) {
        @!ethicalConsiderations.List
    }
    method fairnessAssessments(SBOM::Considerations:D:) {
        @!fairnessAssessments.List
    }
}

# vim: expandtab shiftwidth=4
