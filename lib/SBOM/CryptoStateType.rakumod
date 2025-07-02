use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoStateType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CryptoStateType.setup(<
  pre-activation active suspended deactivated compromised destroyed
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
