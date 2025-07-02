use SBOM::EnergyUnitType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat> {
    has Rat                  $.value is required;
    has SBOM::EnergyUnitType $.unit  is required;
}

# vim: expandtab shiftwidth=4
