use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Crypto CryptoState
>;

use SBOM::CryptoSecurity:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoMaterialProperties:ver<0.0.1>:auth<zef:lizmat> {
    has Crypto               $.type;
    has Str                  $.id;
    has CryptoState          $.state;
    has Str                  $.algorithmRef;
    has DateTime             $.creationDate;
    has DateTime             $.activationDate;
    has DateTime             $.expirationDate;
    has Str                  $.value;
    has UInt                 $.size;
    has Str                  $.format;
    has SBOM::CryptoSecurity $.securedBy;
}

# vim: expandtab shiftwidth=4
