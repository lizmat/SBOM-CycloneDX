use SBOM::EnergyConsumption:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnvironmentalConsiderations:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::EnergyConsumption @.energyConsumptions;
    has SBOM::NameValue         @.properties;
}

# vim: expandtab shiftwidth=4
