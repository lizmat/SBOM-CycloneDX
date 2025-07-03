use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Format Learning
>;

use SBOM::Dataset:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Approach:ver<0.0.1>:auth<zef:lizmat> {
    has Learning $.type;
}

class SBOM::ModelFormat:ver<0.0.1>:auth<zef:lizmat> {
    has Format $.format;
}

class SBOM::ModelParameters:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Approach    $.approach;
    has Str               $.task;
    has Str               $.architectureFamily;
    has Str               $.modelArchitecture;
    has SBOM::Dataset     @.datasets;
    has SBOM::ModelFormat @.inputs;
    has SBOM::ModelFormat @.outputs;
}

# vim: expandtab shiftwidth=4
