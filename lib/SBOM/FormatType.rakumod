use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::FormatType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::FormatType.setup(<
  string image time-series
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
