use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref URL versionString
>;

use SBOM::Dataset:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ReleaseNotes:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;

#| A service, which may include microservices, function-as-a-service, and other types of network or intra-process services.
class SBOM::Service:ver<0.0.1>:auth<zef:lizmat> {
    has Str                  $.name is required;
    has bom-ref              $.bom-ref;
    has SBOM::Organization   $.provider;
    has Str                  $.group;
    has versionString        $.version;
    has Str                  $.description;
    has URL                  @.endpoints;
    has Bool                 $.authenticated;
    has Bool                 $.x-trust-boundary;
    has Str                  $.trustZone;
    has SBOM::Dataset        @.data;
    has SBOM::AnyLicense     @.licenses;
    has SBOM::Reference      @.externalReferences;
    has SBOM::Service        @.services;
    has SBOM::ReleaseNotes   $.releaseNotes;

#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values. Property
#| names of interest to the general public are encouraged to be
#| registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
    has SBOM::NameValue @.properties;
    has Str                  @.tags;
    has SBOM::ValidSignature $.signature;

    submethod TWEAK(:$identity) {
        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);
    }
}

# vim: expandtab shiftwidth=4
