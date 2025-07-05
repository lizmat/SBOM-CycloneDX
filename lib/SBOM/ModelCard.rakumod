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

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::NameValue @.properties;
}

# vim: expandtab shiftwidth=4
