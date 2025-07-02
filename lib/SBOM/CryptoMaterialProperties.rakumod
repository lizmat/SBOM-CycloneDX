use SBOM::CryptoType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CryptoSecurity:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CryptoStateType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoMaterialProperties:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::CryptoType      $.type;
    has Str                   $.id;
    has SBOM::CryptoStateType $.state;
    has Str                   $.algorithmRef;
    has DateTime              $.creationDate;
    has DateTime              $.activationDate;
    has DateTime              $.expirationDate;
    has Str                   $.value;
    has UInt                  $.size;
    has Str                   $.format;
    has SBOM::CryptoSecurity  $.securedBy;
}

# vim: expandtab shiftwidth=4
