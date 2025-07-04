use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  OutputType
>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

#| Represents resources and data output from a task at runtime by executor or task commands
class SBOM::Output:ver<0.0.1>:auth<zef:lizmat> {
    has OutputType           $.type;
    has SBOM::resourceRef    $.source;
    has SBOM::resourceRef    $.target;
    has SBOM::resourceRef    $.resource;
    has SBOM::Text           $.data;
    has SBOM::StrOrNameValue @.environmentVars;
    has SBOM::NameValue      @.properties;

    submethod TWEAK() {
        die "Must have at least 'resource', 'environmentVars' or 'data'"
          unless $!resource  || @!environmentVars || $!data;
    }
}

# vim: expandtab shiftwidth=4
