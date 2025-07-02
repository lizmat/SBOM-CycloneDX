use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CertificationPaddingType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CertificationPaddingType.setup(
  "pkcs5",
  "Public Key Cryptography Standard: Password-Based Cryptography",

  "pkcs7",
  "Public Key Cryptography Standard: Cryptographic Message Syntax",

  "pkcs1v15",
  "Public Key Cryptography Standard: RSA Cryptography v1.5",

  "oaep",
  "Optimal asymmetric encryption padding",

  "raw",
  "Raw",

  "other",
  "Another padding scheme",

  "unknown",
  "The padding scheme is not known",
);

# vim: expandtab shiftwidth=4
