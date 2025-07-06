use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Energy
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref            $.bom-ref;
    has Str                $.description;
    has SBOM::Organization $.organization   is required;
    has Energy             $.energySource   is required;
    has SBOM::EnergyCost   $.energyProvided is required;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference    @.externalReferences;
}

# vim: expandtab shiftwidth=4
