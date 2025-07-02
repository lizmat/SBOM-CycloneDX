use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <bom-ref>;

use SBOM::DataContents:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::DataType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Governance:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Graphics:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Dataset:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref            $.bom-ref;
    has SBOM::DataType     $.type is required;
    has Str                $.name;
    has SBOM::DataContents $.contents;
    has Str                $.classification;
    has Str                @.sensitiveData;
    has SBOM::Graphics     $.graphics;
    has Str                $.description;
    has SBOM::Governance   $.governance;
}

# vim: expandtab shiftwidth=4
