use SBOM:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;

#| A person or organization governing data
my subset Governor where SBOM::Organization | SBOM::Contact;

#- Governance ------------------------------------------------------------------
#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing, and
#| safeguarding the data throughout its lifecycle.
class SBOM::Governance:ver<0.0.1>:auth<zef:lizmat> does SBOM {

#| Data custodians are responsible for the safe custody, transport,
#| and storage of data.
    has Governor @.custodians;

#| Data stewards are responsible for data content, context, and
#| associated business rules.
    has Governor @.stewards;

#| Data owners are concerned with risk and appropriate access to data.
    has Governor @.owners;
}

# vim: expandtab shiftwidth=4
