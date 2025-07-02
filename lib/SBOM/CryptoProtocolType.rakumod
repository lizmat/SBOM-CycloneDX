use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoProtocolType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CryptoProtocolType.setup(
  "tls",
  "Transport Layer Security",

  "ssh",
  "Secure Shell",

  "ipsec",
  "Internet Protocol Security",

  "ike",
  "Internet Key Exchange",

  "sstp",
  "Secure Socket Tunneling Protocol",

  "wpa",
  "Wi-Fi Protected Access",

  "other",
  "Another protocol type",

  "unknown",
  "The protocol type is not known",
);

# vim: expandtab shiftwidth=4
