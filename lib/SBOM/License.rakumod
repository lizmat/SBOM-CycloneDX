use SBOM::enums:ver<0.0.3>:auth<zef:lizmat> <
  Acknowledgement LicenseGranted LicenseId LicenseName
>;

use SBOM::subsets:ver<0.0.3>:auth<zef:lizmat> <
  bom-ref URL
>;

use SBOM:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.3>:auth<zef:lizmat>;

#| A person or an organization
my subset OrgOrContact where SBOM::Organization | SBOM::Contact;

#- Licensing -------------------------------------------------------------------
#| Licensing details describing the licensor/licensee, license type,
#| renewal and expiration dates, and other important metadata.
class SBOM::Licensing:ver<0.0.3>:auth<zef:lizmat> does SBOM {

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

#- License ---------------------------------------------------------------------
class SBOM::License:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the license
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| A valid SPDX license identifier.
    has LicenseId $.id;

#| The name of the license. This may include the name of a commercial
#| or proprietary license or an open source license that may not be
#| defined by SPDX.
    has Str $.name;

#| Stage in licensing process.
    has Acknowledgement $.acknowledgement;

#| An optional way to include the textual content of a license.
    has SBOM::Attachment $.text;

#| The URL to the license file. If specified, a 'license'
#| externalReference should also be specified for completeness
    has URL $.url;

#| Licensing details describing the licensor/licensee, license type,
#| renewal and expiration dates, and other important metadata
    has SBOM::Licensing $.licensing;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    submethod TWEAK() {
        die "Must have 'id' or 'name' specified"
          unless $!id || $!name;
    }
}

#- SPDXLicense -----------------------------------------------------------------
class SBOM::SPDXLicense:ver<0.0.3>:auth<zef:lizmat> does SBOM {
#| An optional identifier which can be used to reference the license
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The SPDX license name (as opposed to ID).
    has LicenseName $.expression is required;

#| Stage in licensing process.
    has Acknowledgement $.acknowledgement;
}

#| An SPDX licenses and/or named license
subset SBOM::AnyLicense where SBOM::License | SBOM::SPDXLicense;

# vim: expandtab shiftwidth=4
