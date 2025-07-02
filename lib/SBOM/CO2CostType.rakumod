use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CO2CostType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CO2CostType.setup(
    "tCO2eq",
    "Tonnes (t) of carbon dioxide (CO2) equivalent (eq)."
);

# vim: expandtab shiftwidth=4
