use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  EnergyUnit
>;

class SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat> {
    has Rat        $.value is required;
    has EnergyUnit $.unit  is required;
}

# vim: expandtab shiftwidth=4
