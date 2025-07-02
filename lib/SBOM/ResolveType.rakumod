use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ResolveType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::ResolveType.setup(
  "defect",
  "A fault, flaw, or bug in software.",

  "enhancement",
  "A new feature or behavior in software.",

  "security",
  "A special type of defect which impacts security.",
);

# vim: expandtab shiftwidth=4
