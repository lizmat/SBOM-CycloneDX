use SBOM::enums:ver<0.0.11>:auth<zef:lizmat> <
  BOMFormat
>;

use SBOM::subsets:ver<0.0.11>:auth<zef:lizmat> <
  PositiveInt serialNumber
>;

use SBOM:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Annotation:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Component:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Composition:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Declarations:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Definition:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Dependency:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Formulation:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Metadata:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.11>:auth<zef:lizmat>;
use SBOM::Vulnerability:ver<0.0.11>:auth<zef:lizmat>;

use PURL:ver<0.0.12+>:auth<zef:lizmat>;

#- CycloneDX -------------------------------------------------------------------
#| Providing the CycloneDX v1.6 JSON specification in Raku.
class SBOM::CycloneDX:ver<0.0.11>:auth<zef:lizmat> does SBOM {

#| Specifies the format of the BOM. This helps to identify the file as
#| CycloneDX since BOMs do not have a filename convention, nor does
#| JSON schema support namespaces.
    has BOMFormat $.bomFormat is required;

#| The version of the CycloneDX specification the BOM conforms to.
    has Str $.specVersion is required;

#| Every BOM generated SHOULD have a unique serial number, even if the
#| contents of the BOM have not changed over time. If specified, the serial
#| number must conform to RFC 4122. Use of serial numbers is recommended.
    has serialNumber $.serialNumber;

#| Whenever an existing BOM is modified, either manually or through
#| automated processes, the version of the BOM SHOULD be incremented by 1.
#| When a system is presented with multiple BOMs with identical serial
#| numbers, the system SHOULD use the most recent version of the BOM.
#| The default version is '1'.
    has PositiveInt $.version = 1;

#| Provides additional information about a BOM.
    has SBOM::Metadata $.metadata;

#| A list of software and hardware components. All items must be unique.
    has SBOM::Component @.components;

#| A list of services. This may include microservices,
#| function-as-a-service, and other types of network or intra-process
#| services. All items must be unique.
    has SBOM::Service @.services;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences;

#| Provides the ability to document dependency relationships including
#| provided & implemented components. All items must be unique.
    has SBOM::Dependency @.dependencies;

#| Compositions describe constituent parts (including components,
#| services, and dependency relationships) and their completeness.
#| The completeness of vulnerabilities expressed in a BOM may also be
#| described.
    has SBOM::Composition @.compositions;

#| Vulnerabilities identified in components or services. All items
#| must be unique.
    has SBOM::Vulnerability @.vulnerabilities;

#| Comments made by people, organizations, or tools about any object
#| with a bom-ref, such as components, services, vulnerabilities, or
#| the BOM itself. Unlike inventory information, annotations may
#| contain opinions or commentary from various stakeholders.
#| Annotations may be inline (with inventory) or externalized viai
#| BOM-Link and may optionally be signed. All items must be unique.
    has SBOM::Annotation @.annotations;

#| Describes how a component or service was manufactured or deployed.
#| This is achieved through the use of formulas, workflows, tasks,
#| and steps, which declare the precise steps to reproduce along with
#| the observed formulas describing the steps which transpired in the
#| manufacturing process. All items must be unique.
    has SBOM::Formulation @.formulation;

#| The list of declarations which describe the conformance to
#| standards. Each declaration may include attestations, claims,
#| and evidence.
    has SBOM::Declarations $.declarations;

#| A collection of reusable objects that are defined and may be used
#| elsewhere in the BOM.
    has SBOM::Definition @.definitions;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # Type objects get a minimal hash to allow further building upon
    multi method Hash(SBOM::CycloneDX:U:) {
        Hash.new( (:bomFormat<CycloneDX>, :specVersion("1.6")) )
    }

    # These should probably be auto-generated in RakUAST at some point
    method components(        SBOM::CycloneDX:D:) { @!components.List         }
    method services(          SBOM::CycloneDX:D:) { @!services.List           }
    method externalReferences(SBOM::CycloneDX:D:) { @!externalReferences.List }
    method dependencies(      SBOM::CycloneDX:D:) { @!dependencies.List       }
    method compositions(      SBOM::CycloneDX:D:) { @!compositions.List       }
    method vulnerabilities(   SBOM::CycloneDX:D:) { @!vulnerabilities.List    }
    method annotations(       SBOM::CycloneDX:D:) { @!annotations.List        }
    method formulation(       SBOM::CycloneDX:D:) { @!formulation.List        }
    method definitions(       SBOM::CycloneDX:D:) { @!definitions.List        }
    method properties(        SBOM::CycloneDX:D:) { @!properties.List         }

#| Returns all C<SBOM::Component> objects that can be found.
    method all-components(SBOM::CycloneDX:D:) {
        my @components;

        my sub recursed-components(@deeper) {
            @components.append: @deeper;
            recursed-components(.components) for @deeper;
        }

        recursed-components( ($_,) ) with self.metadata andthen .component;
        recursed-components(self.components);

        @components.List
    }

#| Returns all L<C<PURL>|https://raku.land/zef:lizmat/PURL> objects
#| that can be found.
    method all-purls(SBOM::CycloneDX:D:) {
        self.all-components.map: { PURL.new($_) with .purl }
    }

#| Returns all L<C<VERS>|https://raku.land/zef:lizmat/VERS> objects
#| that can be found.
    method all-verses(SBOM::CycloneDX:D:) {
        self.all-purls.map: { $_ with .VERS }
    }

#| Returns all C<SBOM::Service> objects that can be found.
    method all-services(SBOM::CycloneDX:D:) {
        my @services;

        my sub recursed-services(@deeper) {
            @services.append: @deeper;
            recursed-services(.services) for @deeper;
        }

        recursed-services(self.services);
        @services.List
    }
}

# vim: expandtab shiftwidth=4
