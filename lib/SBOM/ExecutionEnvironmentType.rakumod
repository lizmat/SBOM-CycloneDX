use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ExecutionEnvironmentType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::ExecutionEnvironmentType.setup(
  "software-plain-ram",
  "A software implementation running in plain unencrypted RAM.",

  "software-encrypted-ram",
  "A software implementation running in encrypted RAM.",

  "software-tee",
  "A software implementation running in a trusted execution environment.",

  "hardware",
  "A hardware implementation.",

  "other",
  "Another implementation environment.",

  "unknown",
  "The execution environment is not known.",
);

# vim: expandtab shiftwidth=4
