use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::AcknowledgementType:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum patchType (
  acknowledgementDeclared => SBOM::AcknowledgementType.new(
    "declared",
    "Declared licenses represent the initial intentions of authors regarding the licensing terms of their code."
  ),
  acknowledgementConcluded => SBOM::AcknowledgementType.new(
    "concluded",
    "Concluded licenses are verified and confirmed."
  )
);

# vim: expandtab shiftwidth=4
