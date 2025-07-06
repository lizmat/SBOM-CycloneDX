use SBOM::Component:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.1>:auth<zef:lizmat>;

#| A target against which claims are made.
class SBOM::Target:ver<0.0.1>:auth<zef:lizmat> {

#| The list of organizations which claims are made against.
    has SBOM::Organization @.organizations;

#| The list of components which claims are made against.
    has SBOM::Component @.components;

#| The list of services which claims are made against.
    has SBOM::Service @.services;
}

# vim: expandtab shiftwidth=4
