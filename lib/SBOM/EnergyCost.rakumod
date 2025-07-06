use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  EnergyUnit
>;

#| The energy provided by the energy source for an associated activity.
class SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat> {

#| Quantity of energy.
    has Rat $.value is required;

#| Unit of energy.
    has EnergyUnit $.unit  is required;
}

# vim: expandtab shiftwidth=4
