use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  CO2Cost
>;

class SBOM::CO2Cost:ver<0.0.1>:auth<zef:lizmat> {
    has Rat     $.value is required;
    has CO2Cost $.unit  is required;
}

# vim: expandtab shiftwidth=4
