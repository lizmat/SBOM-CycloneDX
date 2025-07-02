use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EncodingType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::EncodingType.setup(
    "base64",
    "Base64 is a binary-to-text encoding scheme that represents binary data in an ASCII string.",
);

# vim: expandtab shiftwidth=4
