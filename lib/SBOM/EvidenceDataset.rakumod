use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  DataSource
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref propertyName
>;

use SBOM::DataContents:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Governance:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Graphics:ver<0.0.1>:auth<zef:lizmat>;

#| Data associated with evidence of a claim.
class SBOM::EvidenceDataset:ver<0.0.1>:auth<zef:lizmat> {

#| The name of the data.
    has Str $.name;

#| The contents or references to the contents of the data being
#| described.
    has SBOM::DataContents $.contents;

#| Data classification tags data according to its type, sensitivity,
#| and value if altered, stolen, or destroyed.
    has Str $.classification;

#| A description of any sensitive data included.
    has Str @.sensitiveData;

#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing,
#| and safeguarding the data throughout its lifecycle.
    has SBOM::Governance $.governance;
}

# vim: expandtab shiftwidth=4
