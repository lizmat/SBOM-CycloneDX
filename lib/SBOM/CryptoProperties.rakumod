use SBOM::AlgorithmProperties:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CertificateProperties:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CryptoAssetType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CryptoMaterialProperties:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CryptoProtocolProperties:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoProperties:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::CryptoAssetType          $.assetType is required;
    has SBOM::AlgorithmProperties      $.algorithmProperties;
    has SBOM::CertificateProperties    $.certificateProperties;
    has SBOM::CryptoMaterialProperties $.relatedCryptoMaterialProperties;
    has SBOM::CryptoProtocolProperties $.protocolProperties;
    has Str                            $.oid;
}

# vim: expandtab shiftwidth=4
