use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoFunctionType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CryptoFunctionType.setup(<
  generate keygen encrypt decrypt digest tag keyderive sign verify
  encapsulate decapsulate other unknown
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
