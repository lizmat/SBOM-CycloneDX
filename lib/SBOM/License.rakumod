use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Acknowledgement LicenseId LicenseName
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref URL
>;

use SBOM::Licensing:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

#- License ---------------------------------------------------------------------
class SBOM::License:ver<0.0.1>:auth<zef:lizmat> {

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

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::Property @.properties;

    submethod TWEAK() {
        die "Must have 'id' or 'name' specified"
          unless $!id || $!name;
    }
}

#- SPDXLicense -----------------------------------------------------------------
class SBOM::SPDXLicense:ver<0.0.1>:auth<zef:lizmat> {
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
