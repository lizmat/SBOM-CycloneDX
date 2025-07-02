#use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
#  <bom-ref>;

#use SBOM::Considerations:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Considerations:ver<0.0.1>:auth<zef:lizmat> {
    has Str                        @.users;
    has Str                        @.useCases;
    has Str                        @.technicalLimitations;
    has Str                        @.performanceTradeoffs;
}

# vim: expandtab shiftwidth=4
