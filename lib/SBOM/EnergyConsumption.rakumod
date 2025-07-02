use SBOM::ActivityType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyConsumption:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::ActivityType   $.activity        is required;
    has SBOM::EnergyProvider @.energyProviders is required;
}

# vim: expandtab shiftwidth=4
