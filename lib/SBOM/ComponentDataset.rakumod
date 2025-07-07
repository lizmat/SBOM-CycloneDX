use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  DataSource
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::DataContents:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Governance:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Graphics:ver<0.0.1>:auth<zef:lizmat>;

#- ComponentDataset ------------------------------------------------------------
#| A dataset associated with a component.
class SBOM::ComponentDataset:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the dataset
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The general theme or subject matter of the data being specified.
    has DataSource $.type is required;

#| The name of the dataset.
    has Str $.name;

#| The contents or references to the contents of the data being
#| described.
    has SBOM::DataContents $.contents;

#| Data classification tags data according to its type, sensitivity,
#| and value if altered, stolen, or destroyed.
    has Str $.classification;

#| A description of any sensitive data in a dataset.
    has Str @.sensitiveData;

#| A collection of graphics that represent various measurements.
    has SBOM::Graphics $.graphics;

#| A description of the dataset. Can describe size of dataset, whether
#| it's used for source code, training, testing, or validation, etc.
    has Str $.description;

#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing, and
#| safeguarding the data throughout its lifecycle.
    has SBOM::Governance $.governance;
}

# vim: expandtab shiftwidth=4
