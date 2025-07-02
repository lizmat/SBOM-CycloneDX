use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::KeyType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::KeyType.setup(<
  EC OKP RSA
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
