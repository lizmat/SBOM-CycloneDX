use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  CO2Cost
>;

#| An expression of CO2 cost.
class SBOM::CO2Cost:ver<0.0.1>:auth<zef:lizmat> {

#| Quantity of carbon dioxide (CO2).
    has Rat $.value is required;

#| Unit of carbon dioxide (CO2).
    has CO2Cost $.unit is required;
}

# vim: expandtab shiftwidth=4
