use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

my subset OrgOrContact where SBOM::Organization | SBOM::Contact;

class SBOM::Governance:ver<0.0.1>:auth<zef:lizmat> {
    has OrgOrContact @.custdians;
    has OrgOrContact @.stewards;
    has OrgOrContact @.owners;
}

# vim: expandtab shiftwidth=4
