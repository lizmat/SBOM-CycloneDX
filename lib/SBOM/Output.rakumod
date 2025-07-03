use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  OutputType
>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Output:ver<0.0.1>:auth<zef:lizmat> {
    has OutputType      $.type;
    has resourceRef     $.source;
    has resourceRef     $.target;
    has resourceRef     $.resource;
    has SBOM::Text      $.data;
    has StrOrNameValue  @.environmentVars;
    has SBOM::NameValue @.properties;

    submethod TWEAK() {
        die "Must have at least 'resource', 'environmentVars' or 'data'"
          unless $!resource  || @!environmentVars || $!data;
    }

    method WHY() {
        "Represents resources and data output from a task at runtime by executor or task commands"
    }
}

# vim: expandtab shiftwidth=4
