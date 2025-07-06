use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

my subset OrgOrContact where SBOM::Organization | SBOM::Contact;

#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing, and
#| safeguarding the data throughout its lifecycle.
class SBOM::Governance:ver<0.0.1>:auth<zef:lizmat> {

#| Data custodians are responsible for the safe custody, transport,
#| and storage of data.
    has OrgOrContact @.custdians;

#| Data stewards are responsible for data content, context, and
#| associated business rules.
    has OrgOrContact @.stewards;

#| Data owners are concerned with risk and appropriate access to data.
    has OrgOrContact @.owners;
}

# vim: expandtab shiftwidth=4
