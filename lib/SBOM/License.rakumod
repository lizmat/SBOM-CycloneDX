use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <bom-ref URL>;

use SBOM::AcknowledgementType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::LicenseIdType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::LicenseNameType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Licensing:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::License:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref                   $.bom-ref;
    has SBOM::LicenseIdType       $.id;
    has Str                       $.name;
    has SBOM::AcknowledgementType $.acknowledgement;
    has SBOM::Text                $.text;
    has URL                       $.url;
    has SBOM::Licensing           $.licensing;
    has SBOM::NameValue           @.properties;

    submethod TWEAK() {
        die "Must have 'id' or 'name' specified"
          unless $!id || $!name;
    }
}

class SBOM::SPDXLicense:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref                   $.bom-ref;
    has SBOM::LicenseNameType     $.expression is required;
    has SBOM::AcknowledgementType $.acknowledgement;
}

subset SBOM::AnyLicense where SBOM::License | SBOM::SPDXLicense;

# vim: expandtab shiftwidth=4
