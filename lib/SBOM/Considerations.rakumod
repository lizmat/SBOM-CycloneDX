use SBOM::EnvironmentalConsiderations:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EthicalConsideration:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::FairnessAssessment:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Considerations:ver<0.0.1>:auth<zef:lizmat> {
    has Str                               @.users;
    has Str                               @.useCases;
    has Str                               @.technicalLimitations;
    has Str                               @.performanceTradeoffs;
    has SBOM::EthicalConsideration        @.ethicalConsiderations;
    has SBOM::EnvironmentalConsiderations $.environmentalConsiderations;
    has SBOM::FairnessAssessment          @.fairnessAssessments;
}

# vim: expandtab shiftwidth=4
