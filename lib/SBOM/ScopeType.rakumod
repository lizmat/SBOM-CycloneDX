use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ScopeType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::ScopeType.setup(
  "required",
  "The component is required for runtime",

  "optional",
  "The component is optional at runtime. Optional components are components that are not capable of being called due to them not being installed or otherwise accessible by any means. Components that are installed but due to configuration or other restrictions are prohibited from being called must be scoped as 'required'.",

  "excluded",
  "Components that are excluded provide the ability to document component usage for test and other non-runtime purposes. Excluded components are not reachable within a call graph at runtime.",
);

# vim: expandtab shiftwidth=4
