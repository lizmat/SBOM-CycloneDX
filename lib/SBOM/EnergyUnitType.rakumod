use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyUnitType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::EnergyUnitType.setup(
    "kWh",
    "Kilowatt-hour (kWh) is the energy delivered by one kilowatt (kW) of power for one hour (h)."
);

# vim: expandtab shiftwidth=4
