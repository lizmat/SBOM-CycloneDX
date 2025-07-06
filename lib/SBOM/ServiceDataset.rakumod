use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  DataFlow
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bomLinkElement URL versionString
>;

#| An endpoint for a source or destination of data
subset Endpoint of Str where URL | bomLinkElement;

use SBOM::Governance:ver<0.0.1>:auth<zef:lizmat>;

#| A dataset associated with a service.
class SBOM::ServiceDataset:ver<0.0.1>:auth<zef:lizmat> {

#| Specifies the flow direction of the data, relative to the service.
    has DataFlow $.flow is required;

#| Data classification tags data according to its type, sensitivity,
#| and value if altered, stolen, or destroyed.
    has Str $.classification is required;

#| Name for the defined data.
    has Str $.name;

#| Short description of the data content and usage.
    has Str $.description;

#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing,
#| and safeguarding the data throughout its lifecycle.
    has SBOM::Governance $.governance;

#| The URI, URL, or BOM-Link of the components or services the data
#| came in from.
    has Endpoint $.source;

#| The URI, URL, or BOM-Link of the components or services the data
#| is sent to.
    has Endpoint $.destination;
}

# vim: expandtab shiftwidth=4
