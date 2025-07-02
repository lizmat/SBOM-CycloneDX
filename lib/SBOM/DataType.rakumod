use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::DataType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::DataType.setup(
  "source-code",
  "Any type of code, code snippet, or data-as-code.",

  "configuration",
  "Parameters or settings that may be used by other components.",

  "dataset",
  "A collection of data.",

  "definition",
  "Data that can be used to create new instances of what the definition defines.",

  "other",
  "Any other type of data that does not fit into existing definitions.",
);

# vim: expandtab shiftwidth=4
