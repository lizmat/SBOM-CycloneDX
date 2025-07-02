use SBOM::CryptoAssetType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoProperties:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::CryptoAssetType      $.assetType is required;
    has SBOM::ModelParameters      $.modelParameters;
    has SBOM::QuantitativeAnalysis $.quantitativeAnalysis;
    has SBOM::Considerations       $.considerations;
    has SBOM::NameValue            @.properties;
}

# vim: expandtab shiftwidth=4
