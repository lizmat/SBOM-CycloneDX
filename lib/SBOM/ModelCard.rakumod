use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM::Considerations:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ModelParameters:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::QuantitativeAnalysis:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ModelCard:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref                    $.bom-ref;
    has SBOM::ModelParameters      $.modelParameters;
    has SBOM::QuantitativeAnalysis $.quantitativeAnalysis;
    has SBOM::Considerations       $.considerations;
    has SBOM::NameValue            @.properties;
}

# vim: expandtab shiftwidth=4
