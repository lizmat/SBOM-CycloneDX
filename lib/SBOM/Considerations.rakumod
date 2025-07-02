use SBOM::EthicalConsideration:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Considerations:ver<0.0.1>:auth<zef:lizmat> {
    has Str                        @.users;
    has Str                        @.useCases;
    has Str                        @.technicalLimitations;
    has Str                        @.performanceTradeoffs;
    has SBOM::EthicalConsideration @.ethicalConsiderations;
}

# vim: expandtab shiftwidth=4
