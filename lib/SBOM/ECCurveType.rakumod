use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ECCurveType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::ECCurveType.setup(<
  P-256 P-384 P-521
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
