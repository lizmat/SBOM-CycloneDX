use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::HashType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::HashType.setup(<
  MD5 SHA-1 SHA-256 SHA-384 SHA-512 SHA3-256 SHA3-384 SHA3-512
  BLAKE2b-256 BLAKE2b-384 BLAKE2b-512 BLAKE3
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
