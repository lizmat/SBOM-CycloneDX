use SBOM::enums:ver<0.0.10>:auth<zef:lizmat> <
  DataFlow
>;

use SBOM::subsets:ver<0.0.10>:auth<zef:lizmat> <
  bom-ref bomLinkElement URL versionString
>;

use SBOM:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Governance:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::ReleaseNotes:ver<0.0.10>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.10>:auth<zef:lizmat>;

#| An endpoint for a source or destination of data.
subset Endpoint of Str where URL | bomLinkElement;

#- ServiceDataset --------------------------------------------------------------
#| A dataset associated with a service.
class SBOM::ServiceDataset:ver<0.0.10>:auth<zef:lizmat> does SBOM {

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
    has Endpoint @.source;

#| The URI, URL, or BOM-Link of the components or services the data
#| is sent to.
    has Endpoint @.destination;

    # These should probably be auto-generated in RakUAST at some point
    method source(     SBOM::ServiceDataset:D:) { @!source.List      }
    method destination(SBOM::ServiceDataset:D:) { @!destination.List }
}

#- Service ---------------------------------------------------------------------
#| A service, which may include microservices, function-as-a-service,
#| and other types of network or intra-process services.
class SBOM::Service:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the service
#| elsewhere in the BOM. Every bom-ref must be unique within the BOM.
    has bom-ref $.bom-ref;

#| The organization that provides the service.
    has SBOM::Organization $.provider;

#| The grouping name, namespace, or identifier. This will often be a
#| shortened, single name of the company or project that produced the
#| service or domain name. Whitespace and special characters should be
#| avoided.
    has Str $.group;

#| The name of the service. This will often be a shortened, single
#| name of the service.
    has Str $.name is required;

#| The service version.
    has versionString $.version;

#| Specifies a description for the service.
    has Str $.description;

#| The endpoint URIs of the service.
    has URL @.endpoints;

#| A boolean value indicating if the service requires authentication.
#| A value of true indicates the service requires authentication
#| prior to use. A value of false indicates the service does not
#| require authentication.
    has Bool $.authenticated;

#| A boolean value indicating if use of the service crosses a trust
#| zone or boundary. A value of true indicates that by using the
#| service, a trust boundary is crossed. A value of false indicates
#| that by using the service, a trust boundary is not crossed.
    has Bool $.x-trust-boundary;

#| The name of the trust zone the service resides in.
    has Str $.trustZone;

#| Specifies information about the data including the directional
#| flow of data and the data classification.
    has SBOM::ServiceDataset @.data;

#| EITHER (list of SPDX licenses and/or named licenses) OR (tuple
#| of one SPDX License Expression).
    has SBOM::AnyLicense @.licenses;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences;

#| A list of services included or deployed behind the parent service.
#| This is not a dependency tree. It provides a way to specify ai
#| hierarchical representation of service assemblies.  All items must
#| be unique.
    has SBOM::Service @.services;

#| Specifies optional release notes.
    has SBOM::ReleaseNotes $.releaseNotes;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

#| Textual strings that aid in discovery, search, and retrieval of the
#| associated object. Tags often serve as a way to group or categorize
#| similar or related objects by various attributes.
    has Str @.tags;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    submethod TWEAK(:$identity) {
        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);
    }

    # These should probably be auto-generated in RakUAST at some point
    method endpoints(         SBOM::Service:D:) { @!endpoints.List          }
    method data(              SBOM::Service:D:) { @!data.List               }
    method licenses(          SBOM::Service:D:) { @!licenses.List           }
    method externalReferences(SBOM::Service:D:) { @!externalReferences.List }
    method services(          SBOM::Service:D:) { @!services.List           }
    method properties(        SBOM::Service:D:) { @!properties.List         }
    method tags(              SBOM::Service:D:) { @!tags.List               }
}

# vim: expandtab shiftwidth=4
