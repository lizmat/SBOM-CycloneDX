use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::EnergyType.setup(
  "coal",
  "Energy produced by types of coal.",

  "oil",
  "Petroleum products (primarily crude oil and its derivative fuel oils).",

  "natural-gas",
  "Hydrocarbon gas liquids (HGL) that occur as gases at atmospheric pressure and as liquids under higher pressures including Natural gas (C5H12 and heavier), Ethane (C2H6), Propane (C3H8), etc.",

  "nuclear",
  "Energy produced from the cores of atoms (i.e., through nuclear fission or fusion).",

  "wind",
  "Energy produced from moving air.",

  "solar",
  "Energy produced from the sun (i.e., solar radiation).",

  "geothermal",
  "Energy produced from heat within the earth.",

  "hydropower",
  "Energy produced from flowing water.",

  "biofuel",
  "Liquid fuels produced from biomass feedstocks (i.e., organic materials such as plants or animals).",

  "unknown",
  "The energy source is unknown.",

  "other",
  "An energy source that is not listed.",
);

# vim: expandtab shiftwidth=4
