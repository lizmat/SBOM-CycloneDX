use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::DataType:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum patchType (
  datatypeSource-code => SBOM::DataType.new(
    "source-code",
    "Any type of code, code snippet, or data-as-code."
  ),
  datatypeConfiguration => SBOM::DataType.new(
    "configuration",
    "Parameters or settings that may be used by other components."
  ),
  datatypeDataset => SBOM::DataType.new(
    "dataset",
    "A collection of data."
  ),
  datatypeDefinition => SBOM::DataType.new(
    "definition",
    "Data that can be used to create new instances of what the definition defines."
  ),
  datatypeOther => SBOM::DataType.new(
    "other",
    "Any other type of data that does not fit into existing definitions."
  )
);

# vim: expandtab shiftwidth=4
