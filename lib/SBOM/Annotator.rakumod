use SBOM::Component:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.1>:auth<zef:lizmat>;

#| The organization, person, component, or service which created the textual content of the annotation.
class SBOM::Annotator:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Organization $.organization;
    has SBOM::Contact      $.individual;
    has SBOM::Component    $.component;
    has SBOM::Service      $.service;

    submethod TWEAK() {
        die "Must specify organization, individual, component or service"
          unless $!organization || $!individual || $!component || $!service;
    }
}

# vim: expandtab shiftwidth=4
