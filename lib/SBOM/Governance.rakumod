use SBOM:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.3>:auth<zef:lizmat>;

#- Governance ------------------------------------------------------------------
#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing, and
#| safeguarding the data throughout its lifecycle.
class SBOM::Governance:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| Data custodians are responsible for the safe custody, transport,
#| and storage of data.
    has SBOM::Governor @.custodians;

#| Data stewards are responsible for data content, context, and
#| associated business rules.
    has SBOM::Governor @.stewards;

#| Data owners are concerned with risk and appropriate access to data.
    has SBOM::Governor @.owners;
}

# vim: expandtab shiftwidth=4
