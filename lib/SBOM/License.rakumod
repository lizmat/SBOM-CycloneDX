use SBOM::enums:ver<0.0.10>:auth<zef:lizmat> <
  Acknowledgement LicenseGranted LicenseId LicenseName
>;

use SBOM::subsets:ver<0.0.10>:auth<zef:lizmat> <
  bom-ref URL
>;

use SBOM:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.10>:auth<zef:lizmat>;

#- Licensing -------------------------------------------------------------------
#| Licensing details describing the licensor/licensee, license type,
#| renewal and expiration dates, and other important metadata.
class SBOM::Licensing:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| License identifiers that may be used to manage licenses and their lifecycle.
    has Str @.altIds;

#| The individual or organization that grants a license to another
#| individual or organization
    has SBOM::IndividualOrOrganization $.licensor;

#| The individual or organization for which a license was granted to.
    has SBOM::IndividualOrOrganization $.licensee;

#| The individual or organization that purchased the license.
    has SBOM::IndividualOrOrganization $.purchaser;

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

    # These should probably be auto-generated in RakUAST at some point
    method altIds(      SBOM::Licensing:D:) { @!altIds.List       }
    method licenseTypes(SBOM::Licensing:D:) { @!licenseTypes.List }
}

#- AnyLicense ------------------------------------------------------------------
class SBOM::License     { ... }
class SBOM::SPDXLicense { ... }
class SBOM::LicenseInfo { ... }

#| Either a (modern) License object, or a legacy SPDX License object
class SBOM::AnyLicense:ver<0.0.10>:auth<zef:lizmat> does SBOM {
    multi method new(SBOM::AnyLicense:U: :$raw-error) {
        (%_<license>:exists)
          ?? (%_<expression>:exists)
            ?? die "Cannot have both 'license' and 'expression' specified"
            !! SBOM::License.ingest($raw-error, %_)
          !! %_<expression>
            ?? SBOM::SPDXLicense.ingest($raw-error, %_)
            !! die "Must have either 'license' or 'expression' specified: %_.raku()"
    }
}

#- License ---------------------------------------------------------------------
#| Specifies the details and attributes related to a software license.
#| It can either include a valid SPDX license identifier or a named
#| license, along with additional properties such as license
#| acknowledgment, comprehensive commercial licensing information,
#| and the full text of the license.
class SBOM::License:ver<0.0.10>:auth<zef:lizmat>
  is SBOM::AnyLicense does SBOM {

#| Info on an SPDX license or named license.
    has SBOM::LicenseInfo $.license is required;

    # Calling with license => { } does satisfy the required constraint
    # but doesn't stop it from not creating an object if no arguments
    # are given.  So if we get here without an object, it was called
    # without argumenst, so at least "id" and "name" were missing.
    submethod TWEAK() {
        die "Must have 'id' or 'name' specified" unless $!license;
    }
}

#- LicenseInfo -----------------------------------------------------------------
#| Additional license properties such as license acknowledgment,
#| comprehensive commercial licensing information, and the full
#| text of the license.
class SBOM::LicenseInfo:ver<0.0.10>:auth<zef:lizmat> does SBOM {

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

    # These should probably be auto-generated in RakUAST at some point
    method properties(SBOM::LicenseInfo:D:) { @!properties.List }
}

#- SPDXLicense -----------------------------------------------------------------
class SBOM::SPDXLicense:ver<0.0.10>:auth<zef:lizmat>
  is SBOM::AnyLicense does SBOM {

#| The SPDX license name (as opposed to ID).
    has Str $.expression is required;

#| Stage in licensing process.
    has Acknowledgement $.acknowledgement;

#| An optional identifier which can be used to reference the license
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

    submethod TWEAK(:$expression!) {
        die "Not an SPDX expression: $expression"
          unless try $expression.split(
            / \s+ OR|or|AND|and|WITH|with \s+ /  # XXX SPDX expression
          ).map: { LicenseId($_) }
    }
}

# vim: expandtab shiftwidth=4
