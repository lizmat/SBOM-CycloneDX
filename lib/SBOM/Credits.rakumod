use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

#| Individuals or organizations credited with the discovery of a
#| vulnerability.
class SBOM::Credits:ver<0.0.1>:auth<zef:lizmat> {

#| The organizations credited with vulnerability discovery.
    has SBOM::Organization @.organizations;

#| The individuals, not associated with organizations, that are
#| credited with vulnerability discovery.
    has SBOM::Contact @.individuals;
}

# vim: expandtab shiftwidth=4
