use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::AcknowledgementType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::AcknowledgementType.setup(
  "declared",
  "Declared licenses represent the initial intentions of authors regarding the licensing terms of their code.",

  "concluded",
  "Concluded licenses are verified and confirmed.",
);

# vim: expandtab shiftwidth=4
