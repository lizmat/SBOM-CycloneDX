use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ReleaseType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::ReleaseType.setup(<
  major minor patch pre-release internal
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
