use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoAssetType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CryptoAssetType.setup(
  "algorithm",
  "Mathematical function commonly used for data encryption, authentication, and digital signatures.",

  "certificate",
  "An electronic document that is used to provide the identity or validate a public key.",

  "protocol",
  "A set of rules and guidelines that govern the behavior and communication with each other.",

  "related-crypto-material",
  "Other cryptographic assets related to algorithms, certificates, and protocols such as keys and tokens."
);

# vim: expandtab shiftwidth=4
