use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::SignatureAlgorithmType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::SignatureAlgorithmType.setup(<
  RS256 RS384 RS512 PS256 PS384 PS512 ES256 ES384 ES512 Ed25519 Ed448
  HS256 HS384 HS512
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
