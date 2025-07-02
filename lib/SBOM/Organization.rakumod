use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <bom-ref URL>;

use SBOM::Address:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Organization:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref       $.bom-ref;
    has Str           $.name;
    has SBOM::Address $.address;
    has URL           @.url;
    has SBOM::Contact @.contact;
}

# vim: expandtab shiftwidth=4
