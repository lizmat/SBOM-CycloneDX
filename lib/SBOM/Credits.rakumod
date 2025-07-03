use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Credits:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Organization @.organizations;
    has SBOM::Contact      @.individuals;
}

# vim: expandtab shiftwidth=4
