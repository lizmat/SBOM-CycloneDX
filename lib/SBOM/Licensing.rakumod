use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  LicenseGranted
>;

use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

my subset OrgOrContact where SBOM::Organization | SBOM::Contact;

class SBOM::Licensing:ver<0.0.1>:auth<zef:lizmat> {
    has Str            @.altIds;
    has OrgOrContact   $.licensor;
    has OrgOrContact   $.licensee;
    has OrgOrContact   $.purchaser;
    has Str            $.purchaseOrder;
    has LicenseGranted @.licenseTypes;
    has DateTime       $.lastRenewal;
    has DateTime       $.expiration;
}

# vim: expandtab shiftwidth=4
