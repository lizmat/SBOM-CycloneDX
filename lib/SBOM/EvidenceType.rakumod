use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::EvidenceType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::EvidenceType.setup(<
  source-code-analysis binary-analysis manifest-analysis ast-fingerprint
  hash-comparison instrumentation dynamic-analysis filename attestation
  other
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
