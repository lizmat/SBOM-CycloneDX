use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  resourceRef
>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Parameter:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Input:ver<0.0.1>:auth<zef:lizmat> {
    has resourceRef     $.source;
    has resourceRef     $.target;
    has resourceRef     $.resource;
    has SBOM::Parameter @.parameters;
    has StrOrNameValue  @.environmentVars;
    has SBOM::Text      $.data;
    has SBOM::NameValue @.properties;

    submethod TWEAK() {
        die "Must have at least 'resource', 'parameters', 'environmentVars' or 'data'"
          unless $!resoource || @!parameters || @!environmentVars || $!data;
    }

    method WHY() {
        "Type that represents various input data types and formats."
    }
}

# vim: expandtab shiftwidth=4
