use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  LicenseGranted
>;

use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

my subset OrgOrContact where SBOM::Organization | SBOM::Contact;

#| Licensing details describing the licensor/licensee, license type,
#| renewal and expiration dates, and other important metadata.
class SBOM::Licensing:ver<0.0.1>:auth<zef:lizmat> {

#| License identifiers that may be used to manage licenses and their lifecycle.
    has Str @.altIds;

#| The individual or organization that grants a license to another
#| individual or organization
    has OrgOrContact $.licensor;

#| The individual or organization for which a license was granted to.
    has OrgOrContact $.licensee;

#| The individual or organization that purchased the license.
    has OrgOrContact $.purchaser;

#| The purchase order identifier the purchaser sent to a supplier or
#| vendor to authorize a purchase.
    has Str $.purchaseOrder;

#| The type of license(s) that was granted to the licensee.
    has LicenseGranted @.licenseTypes;

#| The timestamp indicating when the license was last renewed. For
#| new purchases, this is often the purchase or acquisition date. For
#| non-perpetual licenses or subscriptions, this is the timestamp of
#| when the license was last renewed.
    has DateTime $.lastRenewal;

#| The timestamp indicating when the current license expires (if
#| applicable).
    has DateTime $.expiration;
}

# vim: expandtab shiftwidth=4
