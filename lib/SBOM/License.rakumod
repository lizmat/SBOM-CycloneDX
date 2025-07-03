use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Acknowledgement LicenseId LicenseName
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref URL
>;

use SBOM::Licensing:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::License:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref         $.bom-ref;
    has LicenseId       $.id;
    has Str             $.name;
    has Acknowledgement $.acknowledgement;
    has SBOM::Text      $.text;
    has URL             $.url;
    has SBOM::Licensing $.licensing;
    has SBOM::NameValue @.properties;

    submethod TWEAK() {
        die "Must have 'id' or 'name' specified"
          unless $!id || $!name;
    }
}

class SBOM::SPDXLicense:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref         $.bom-ref;
    has LicenseName     $.expression is required;
    has Acknowledgement $.acknowledgement;
}

subset SBOM::AnyLicense where SBOM::License | SBOM::SPDXLicense;

# vim: expandtab shiftwidth=4
