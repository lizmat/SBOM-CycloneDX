use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CertificationModeType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CertificationModeType.setup(
  "cbc",
  "Cipher block chaining",

  "ecb",
  "Electronic codebook",

  "ccm",
  "Counter with cipher block chaining message authentication code",

  "gcm",
  "Galois/counter",

  "cfb",
  "Cipher feedback",

  "ofb",
  "Output feedback",

  "ctr",
  "Counter",

  "other",
  "Another mode of operation",

  "unknown",
  "The mode of operation is not known",
);

# vim: expandtab shiftwidth=4
