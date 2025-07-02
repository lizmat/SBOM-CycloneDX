use SBOM::CO2CostType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CO2Cost:ver<0.0.1>:auth<zef:lizmat> {
    has Rat               $.value is required;
    has SBOM::CO2CostType $.unit  is required;
}

# vim: expandtab shiftwidth=4
