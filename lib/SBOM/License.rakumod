use SBOM::AcknowledgementType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Licensing:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Subsets:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::License:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref                   $.bom-ref;
    has licenseId                 $.id;
    has Str                       $.name;
    has SBOM::AcknowledgementType $.acknowledgement;
    has SBOM::Text                $.text;
    has URL                       $.url;
    has SBOM::Licensing           $.licensing;
    has SBOM::NameValue           @.properties;
}

# vim: expandtab shiftwidth=4
