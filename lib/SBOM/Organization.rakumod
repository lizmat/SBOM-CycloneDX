use SBOM::subsets:ver<0.0.2>:auth<zef:lizmat> <
  bom-ref URL
>;

use SBOM:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::Address:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.2>:auth<zef:lizmat>;

#- Organization ----------------------------------------------------------------
#| An organization, as opposed to a person.
class SBOM::Organization:ver<0.0.2>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The name of the organization.
    has Str $.name;

#| The physical address (location) of the organization.
    has SBOM::Address $.address;

#| The URL of the organization. Multiple URLs are allowed.
    has URL @.url;

#| A contact at the organization. Multiple contacts are allowed.
    has SBOM::Contact @.contact;
}

# vim: expandtab shiftwidth=4
