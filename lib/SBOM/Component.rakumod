use SBOM::enums:ver<0.0.9>:auth<zef:lizmat> <
  ComponentType Patch Scope
>;

use SBOM::subsets:ver<0.0.9>:auth<zef:lizmat> <
  bom-ref CPE email mime-type omniborId purl SWHID URL
>;

use SBOM::Attachment:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::CryptoProperties:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::ComponentDataset:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::ComponentEvidence:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::HashedString:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::ModelCard:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::ReleaseNotes:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Resolve:ver<0.0.9>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.9>:auth<zef:lizmat>;

#- Development -----------------------------------------------------------------
#| An action during development, such as a commit.
class SBOM::Development:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| The timestamp in which the action occurred.
    has DateTime $.timestamp;

#| The name of the individual who performed the action.
    has Str $.name;

#| The email address of the individual who performed the action.
    has email $.email;
}

#- Commit ----------------------------------------------------------------------
#| Specifies an individual commit.
class SBOM::Commit:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| A unique identifier of the commit. This may be version control
#| specific. For example, Subversion uses revision numbers whereas
#| git uses commit hashes.
    has Str $.uid;

#| The URL to the commit. This URL will typically point to a commit
#| in a version control system.
    has URL $.url;

#| The author who created the changes in the commit.
    has SBOM::Development $.author;

#| The person who committed or pushed the commit.
    has SBOM::Development $.committer;

#| The text description of the contents of the commit.
    has Str $.message;
}

#- SWID ------------------------------------------------------------------------
#| Asserts the identity of the component using ISO-IEC 19770-2 Software
#| Identification (SWID) Tags. Refer to @.evidence.identity to
#| optionally provide evidence that substantiates the assertion of
#| the component's identity.
class SBOM::SWID:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| Maps to the tagId of a SoftwareIdentity.
    has Str:D $.tagId is required;

#| Maps to the name of a SoftwareIdentity.
    has Str:D $.name is required;

#| Maps to the version of a SoftwareIdentity.
    has Str:D $.version = "0.0";

#| Maps to the tagVersion of a SoftwareIdentity.
    has Int:D $.tagVersion = 1;

#| Maps to the patch of a SoftwareIdentity.
    has Bool:D $.patch = False;

#| Specifies the metadata and content of the SWID tag.
    has SBOM::Attachment $.text;

#| The URL to the SWID file.
    has URL $.url;
}

#- Component -------------------------------------------------------------------
class SBOM::Pedigree { ... }

#| A software or hardware component.
class SBOM::Component:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| Specifies the type of the component. For software components,
#| classify as application if no more specific appropriate
#| classification is available or cannot be determined for the
#| component.
    has ComponentType $.type is required;

#| The optional mime-type of the component. When used on file
#| components, the mime-type can provide additional context about the
#| kind of file being represented, such as an image, font, or
#| executable. Some library or framework components may also have an
#| associated mime-type.
    has mime-type $.mime-type;

#| An optional identifier which can be used to reference the component
#| elsewhere in the BOM. Every bom-ref must be unique within the BOM.
#| Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid
#| conflicts with BOM-Links.
    has bom-ref $.bom-ref;

#| The organization that supplied the component. The supplier may often
#| be the manufacturer, but may also be a distributor or repackager.
    has SBOM::Organization $.supplier;

#| The organization that created the component. Manufacturer is common
#| in components created through automated processes. Components created
#| through manual means may have @.authors instead.
    has SBOM::Organization $.manufacturer;

#| The person(s) who created the component. Authors are common in
#| components created through manual processes. Components created
#| through automated means may have @.manufacturer instead.
    has SBOM::Contact @.authors;

# [Deprecated] This will be removed in a future version. Use @.authors
# or @.manufacturer instead. The person(s) or organization(s) that
# authored the component.
    has Str $.author;

#| The person(s) or organization(s) that published the component.
    has Str $.publisher;

#| The grouping name or identifier. This will often be a shortened,
#| single name of the company or project that produced the component,
#| or the source package or domain name. Whitespace and special
#| characters should be avoided. Examples include: apache,
#| org.apache.commons, and apache.org.
    has Str $.group;

#| The name of the component. This will often be a shortened, single
#| name of the component. Examples: commons-lang3 and jquery.
    has Str $.name is required;

#| The component version. The version should ideally comply with
#| semantic versioning but is not enforced.
    has versionString $.version;

#| Specifies a description for the component
    has Str $.description;

#| Specifies the scope of the component. If scope is not specified,
#| 'required' scope SHOULD be assumed by the consumer of the BOM.
    has Scope $.scope;

#| The hashes of the component.
    has SBOM::HashedString @.hashes;

#| EITHER (list of SPDX licenses and/or named licenses) OR (tuple
#| of one SPDX License Expression)
    has SBOM::AnyLicense @.licenses;

#| A copyright notice informing users of the underlying claims to
#| copyright ownership in a published work.
    has Str $.copyright;

#| Asserts the identity of the component using CPE. The CPE must
#| conform to the CPE 2.2 or 2.3 specification. See
#| https://nvd.nist.gov/products/cpe. Refer to @.evidence.identity
#| to optionally provide evidence that substantiates the assertion
#| of the component's identity.
    has CPE $.cpe;

#| Asserts the identity of the component using package-url (purl).
#| The purl, if specified, must be valid and conform to the
#| specification defined at: https://github.com/package-url/purl-spec.
#| Refer to @.evidence.identity to optionally provide evidence that
#| substantiates the assertion of the component's identity.
    has purl $.purl;

#| Asserts the identity of the component using the OmniBOR Artifact ID.
#| The OmniBOR, if specified, must be valid and conform to the
#| specification defined at:
#| https://www.iana.org/assignments/uri-schemes/prov/gitoid. Refer to
#| @.evidence.identity to optionally provide evidence that substantiates
#| the assertion of the component's identity.
    has omniborId @.omniborId;

#| Asserts the identity of the component using the Software Heritage
#| persistent identifier (SWHID). The SWHID, if specified, must be
#| valid and conform to the specification defined at:
#| https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
#| Refer to @.evidence.identity to optionally provide evidence that
#| substantiates the assertion of the component's identity.
    has SWHID @.swhid;

#| Asserts the identity of the component using ISO-IEC 19770-2 Software
#| Identification (SWID) Tags. Refer to @.evidence.identity to
#| optionally provide evidence that substantiates the assertion of
#| the component's identity.
    has SBOM::SWID $.swid;

#| [Deprecated] This will be removed in a future version. Use the
#| pedigree element instead to supply information on exactly how the
#| component was modified. A boolean value indicating if the component
#| has been modified from the original. A value of true indicates the
#| component is a derivative of the original. A value of false indicates
#| the component has not been modified from the original.
    has Bool $.modified;

#| Component pedigree is a way to document complex supply chain
#| scenarios where components are created, distributed, modified,
#| redistributed, combined with other components, etc. Pedigree supports
#| viewing this complex chain from the beginning, the end, or anywhere
#| in the middle. It also provides a way to document variants where the
#| exact relation may not be known.
    has SBOM::Pedigree $.pedigree;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external to
#| the BOM.
    has SBOM::Reference @.externalReferences;

#| A list of software and hardware components included in the parent
#| component. This is not a dependency tree. It provides a way to specify
#| a hierarchical representation of component assemblies, similar to
#| system → subsystem → parts assembly in physical supply chains.
    has SBOM::Component @.components;

#| Provides the ability to document evidence collected through various
#| forms of extraction or analysis.
    has SBOM::ComponentEvidence $.evidence;

#| Specifies optional release notes.
    has SBOM::ReleaseNotes $.releaseNotes;

#| A model card describes the intended uses of a machine learning model
#| and potential limitations, including biases and ethical considerations.
#| Model cards typically contain the training parameters, which datasets
#| were used to train the model, performance metrics, and other relevant
#| data useful for ML transparency. This object SHOULD be specified for
#| any component of type machine-learning-model and must not be specified
#| for other component types.
    has SBOM::ModelCard $.modelCard;

#| Data associated with a data component.
    has SBOM::ComponentDataset @.data;

#| Cryptographic assets have properties that uniquely define them and
#| that make them actionable for further reasoning. As an example, it
#| makes a difference if one knows the algorithm family (e.g. AES) or
#| the specific variant or instantiation (e.g. AES-128-GCM). This is
#| because the security level and the algorithm primitive (authenticated
#| encryption) are only defined by the definition of the algorithm
#| variant. The presence of a weak cryptographic algorithm like SHA1
#| vs. HMAC-SHA1 also makes a difference.
    has SBOM::CryptoProperties $.cryptoProperties;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

#| Textual strings that aid in discovery, search, and retrieval of the
#| associated object. Tags often serve as a way to group or categorize
#| similar or related objects by various attributes.
    has Str @.tags;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    submethod TWEAK() {
        die q/'data' can only be specified if the 'type' is "data"/
          if @!data && $!type.name ne 'data';

        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);
    }

    # These should probably be auto-generated in RakUAST at some point
    method authors(           SBOM::Component:D:) { @!authors.List            }
    method hashes(            SBOM::Component:D:) { @!hashes.List             }
    method licenses(          SBOM::Component:D:) { @!licenses.List           }
    method omniborId(         SBOM::Component:D:) { @!omniborId.List          }
    method swhid(             SBOM::Component:D:) { @!swhid.List              }
    method externalReferences(SBOM::Component:D:) { @!externalReferences.List }
    method components(        SBOM::Component:D:) { @!components.List         }
    method data(              SBOM::Component:D:) { @!data.List               }
    method properties(        SBOM::Component:D:) { @!properties.List         }
    method tags(              SBOM::Component:D:) { @!tags.List               }
}

#- Diff ------------------------------------------------------------------------
#| The patch file (or diff) that shows changes. Refer to
#| https://en.wikipedia.org/wiki/Diff
class SBOM::Diff:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| Specifies the optional text of the diff.
    has SBOM::Attachment $.text;

#| Specifies the URL to the diff.
    has URL $.url;
}

#- Patch -----------------------------------------------------------------------
#| Specifies an individual patch
class SBOM::Patch:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| Specifies the purpose for the patch including the resolution of
#| defects, security issues, or new behavior or functionality.
    has Patch $.type is required;

#| The patch file (or diff) that shows changes. Refer to
#| https://en.wikipedia.org/wiki/Diff
    has SBOM::Diff $.diff;

#| A collection of issues the patch resolves.
    has SBOM::Resolve @.resolves;

    # These should probably be auto-generated in RakUAST at some point
    method resolves(SBOM::Patch:D:) { @!resolves.List }
}

#- Pedigree --------------------------------------------------------------------
#| Component pedigree is a way to document complex supply chain scenarios
#| where components are created, distributed, modified, redistributed,
#| combined with other components, etc. Pedigree supports viewing this
#| complex chain from the beginning, the end, or anywhere in the middle.
#| It also provides a way to document variants where the exact relation
#| may not be known.
class SBOM::Pedigree:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| Describes zero or more components in which a component is derived
#| from. This is commonly used to describe forks from existing projects
#| where the forked version contains a ancestor node containing the
#| original component it was forked from. For example, Component A is
#| the original component. Component B is the component being used and
#| documented in the BOM. However, Component B contains a pedigree node
#| with a single ancestor documenting Component A - the original
#| component from which Component B is derived from.
    has SBOM::Component @.ancestors;

#| Descendants are the exact opposite of ancestors. This provides a way
#| to document all forks (and their forks) of an original or root
#| component.
    has SBOM::Component @.descendants;

#| Variants describe relations where the relationship between the
#| components is not known. For example, if Component A contains nearly
#| identical code to Component B. They are both related, but it is
#| unclear if one is derived from the other, or if they share a common
#| ancestor.
    has SBOM::Component @.variants;

#| A list of zero or more commits which provide a trail describing how
#| the component deviates from an ancestor, descendant, or variant.
    has SBOM::Commit @.commits;

#| A list of zero or more patches describing how the component deviates
#| from an ancestor, descendant, or variant. Patches may be
#| complementary to commits or may be used in place of commits.
    has SBOM::Patch @.patches;

#| Notes, observations, and other non-structured commentary describing
#| the components pedigree.
    has Str $.notes;

    # These should probably be auto-generated in RakUAST at some point
    method ancestors(  SBOM::Pedigree:D:) { @!ancestors.List   }
    method descendants(SBOM::Pedigree:D:) { @!descendants.List }
    method variants(   SBOM::Pedigree:D:) { @!variants.List    }
    method commits(    SBOM::Pedigree:D:) { @!commits.List     }
    method patches(    SBOM::Pedigree:D:) { @!patches.List     }
}

# vim: expandtab shiftwidth=4
