use SBOM::subsets:ver<0.0.3>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.3>:auth<zef:lizmat>;

#- Address ---------------------------------------------------------------------
#| The physical address (location) of the organization.
class SBOM::Address:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the
#| address elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The country name or the two-letter ISO 3166-1 country code.
    has Str $.country;

#| The region or state in the country.
    has Str $.region;

#| The locality or city within the country.
    has Str $.locality;

#| The post office box number.
    has Str $.postOfficeBoxNumber;

#| The postal code.
    has Str $.postalCode;

#| The street address.
    has Str $.streetAddress;
}

# vim: expandtab shiftwidth=4
