use SBOM::enums:ver<0.0.10>:auth<zef:lizmat> <
  Crypto CryptoState
>;

use SBOM:ver<0.0.10>:auth<zef:lizmat>;

#- CryptoSecurity --------------------------------------------------------------
#| The mechanism by which a cryptographic asset is secured by.
class SBOM::CryptoSecurity:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| Specifies the mechanism by which the cryptographic asset is secured by.
    has Str $.mechanism;

#| The bom-ref to the algorithm.
    has Str $.algorithmRef;
}

#- CryptoMaterialProperties ----------------------------------------------------
#| Properties for cryptographic assets of asset type:
#| related-crypto-material
class SBOM::CryptoMaterialProperties:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| The type for the related cryptographic material
    has Crypto $.type;

#| The optional unique identifier for the related cryptographic material.
    has Str $.id;

#| The key state as defined by NIST SP 800-57.
    has CryptoState $.state;

#| The bom-ref to the algorithm used to generate the related
#| cryptographic material.
    has Str $.algorithmRef;

#| The date and time (timestamp) when the related cryptographic material
#| was created.
    has DateTime $.creationDate;

#| The date and time (timestamp) when the related cryptographic material
#| was activated.
    has DateTime $.activationDate;

#| The date and time (timestamp) when the related cryptographic material
#| was updated.
    has DateTime $.updateDate;

#| The date and time (timestamp) when the related cryptographic material
#| expires.
    has DateTime $.expirationDate;

#| The associated value of the cryptographic material.
    has Str $.value;

#| The size of the cryptographic asset (in bits).
    has UInt $.size;

#| The format of the related cryptographic material (e.g. P8, PEM, DER).
    has Str $.format;

#| The mechanism by which the cryptographic asset is secured by.
    has SBOM::CryptoSecurity $.securedBy;
}

# vim: expandtab shiftwidth=4
