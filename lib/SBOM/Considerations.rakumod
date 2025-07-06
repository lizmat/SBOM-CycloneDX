use SBOM::EnergyConsumption:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;

#- EthicalConsideration --------------------------------------------------------
#| What are the ethical risks involved in the application of a model?
class SBOM::EthicalConsideration:ver<0.0.1>:auth<zef:lizmat> {

#| The name of the risk.
    has Str $.name;

#| Strategy used to address this risk.
    has Str $.mitigationStragegy;
}

#- EnvironmentalConsiderations -------------------------------------------------
#| What are the various environmental impacts a machine learning model
#| has exhibited across its lifecycle?
class SBOM::EnvironmentalConsiderations:ver<0.0.1>:auth<zef:lizmat> {

#| Describes energy consumption information incurred for one or more
#| component lifecycle activities.
    has SBOM::EnergyConsumption @.energyConsumptions;

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

#- FairnessAssessment ----------------------------------------------------------
#| How does the model affect groups at risk of being systematically
#| disadvantaged? What are the harms and benefits to the various
#| affected groups?
class SBOM::FairnessAssessment:ver<0.0.1>:auth<zef:lizmat> {

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
class SBOM::Considerations:ver<0.0.1>:auth<zef:lizmat> {

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
    has SBOM::EnvironmentalConsiderations $.environmentalConsiderations;
    has SBOM::FairnessAssessment          @.fairnessAssessments;
}

# vim: expandtab shiftwidth=4
