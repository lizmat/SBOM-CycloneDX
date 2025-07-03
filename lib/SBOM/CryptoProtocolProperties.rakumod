use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  CryptoProtocol
>;

use SBOM::CipherSuite:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::IKEv2TransformTypes:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoProtocolProperties:ver<0.0.1>:auth<zef:lizmat> {
    has CryptoProtocol            $.type;
    has Str                       $.version;
    has SBOM::CipherSuite         @.cipherSuites;
    has SBOM::IKEv2TransformTypes $.ikev2TransformTypes;
    has Str                       @.cryptoRefArray;
}

# vim: expandtab shiftwidth=4
