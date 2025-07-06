use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Energy
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::EnergyCost:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;

#| The provider of the energy consumed by a model during its
#| development lifecycle activity.
class SBOM::EnergyProvider:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the energy
#| provider elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| A description of the energy provider.
    has Str $.description;

#| The organization that provides energy.
    has SBOM::Organization $.organization is required;

#| The energy source for the energy provider.
    has Energy $.energySource   is required;

#| The energy provided by the energy source for an associated activity.
    has SBOM::EnergyCost  $.energyProvided is required;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference    @.externalReferences;
}

# vim: expandtab shiftwidth=4
