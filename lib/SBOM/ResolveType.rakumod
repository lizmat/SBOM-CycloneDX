use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ResolveType:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum resolveType (
  resolveDefect => SBOM::ResolveType.new(
    "defect",
    "A fault, flaw, or bug in software."
  ),
  resolveEnhancement => SBOM::ResolveType.new(
    "enhancement",
    "A new feature or behavior in software."
  ),
  resolveSecurity => SBOM::ResolveType.new(
    "security",
    "A special type of defect which impacts security."
  )
);

# vim: expandtab shiftwidth=4
