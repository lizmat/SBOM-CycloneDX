use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Encoding:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum encodingType (
  encodingBase64 => SBOM::Encoding.new(
    "base64",
    "Base64 is a binary-to-text encoding scheme that represents binary data in an ASCII string."
  )
);

# vim: expandtab shiftwidth=4
