use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::FieldType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::FieldType.setup(<
  group name version purl cpe omniborId swhid swid hash
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
