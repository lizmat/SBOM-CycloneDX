use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <implementationPlatform>;

use SBOM::AlgorithmPrimitiveType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ExecutionEnvironmentType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::AlgorithmProperties:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::AlgorithmPrimitiveType $.primitive;
    has Str                          $.parameterSetIdentifier;
    has Str                          $.curve;
    has ExecutionEnvironmentType     $.executionEnvironmment;
    has SBOM::QuantitativeAnalysis $.quantitativeAnalysis;
    has SBOM::Considerations       $.considerations;
    has SBOM::NameValue            @.properties;
}

# vim: expandtab shiftwidth=4
