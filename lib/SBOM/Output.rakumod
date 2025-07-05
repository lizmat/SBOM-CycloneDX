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

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::NameValue @.properties;

    submethod TWEAK() {
        die "Must have at least 'resource', 'environmentVars' or 'data'"
          unless $!resource  || @!environmentVars || $!data;
    }
}

# vim: expandtab shiftwidth=4
