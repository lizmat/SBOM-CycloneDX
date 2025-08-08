use SBOM::enums:ver<0.0.13>:auth<zef:lizmat> <
  DataSource
>;

use SBOM::subsets:ver<0.0.13>:auth<zef:lizmat> <
  bom-ref propertyName
>;

use SBOM:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Claim:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Component:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::DataContents:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Governance:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Graphics:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::RequirementGrouping:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.13>:auth<zef:lizmat>;

#- EvidenceDataset -------------------------------------------------------------
#| Data associated with evidence of a claim.
class SBOM::EvidenceDataset:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The name of the data.
    has Str $.name;

#| The contents or references to the contents of the data being
#| described.
    has SBOM::DataContents $.contents;

#| Data classification tags data according to its type, sensitivity,
#| and value if altered, stolen, or destroyed.
    has Str $.classification;

#| A description of any sensitive data included.
    has Str @.sensitiveData;

#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing,
#| and safeguarding the data throughout its lifecycle.
    has SBOM::Governance $.governance;

    # These should probably be auto-generated in RakUAST at some point
    method sensitiveData(SBOM::EvidenceDataset:D:) { @!sensitiveData.List }
}

#- Signatory -------------------------------------------------------------------
#| A signatories authorized on behalf of an organization to assert
#| validity of this document.
class SBOM::Signatory:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The signatory's name.
    has Str $.name;

#| The signatory's role within an organization.
    has Str $.role;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

#| The signatory's organization.
    has SBOM::Organization $.organization;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference $.externalReference;

    submethod TWEAK() {
        die "Must either have 'signature', or 'externalReference' and 'organization' specified"
          unless $!signature || ($!externalReference && $!organization);
    }
}

#- Affirmation ----------------------------------------------------------------
#| A concise statement affirmed by an individual regarding all
#| declarations, often used for third-party auditor acceptance or
#| recipient acknowledgment. It includes a list of authorizedi
#| signatories who assert the validity of the document on behalf
#| of the organization.
class SBOM::Affirmation:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The brief statement affirmed by an individual regarding all
#| declarations.  This could be an affirmation of acceptance by a
#| third-party auditor or receiving individual of a file.
    has Str $.statement;

#| The list of signatories authorized on behalf of an organization to
#| assert validity of this document.
    has SBOM::Signatory @.signatories;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # These should probably be auto-generated in RakUAST at some point
    method signatories(SBOM::Affirmation:D:) { @!signatories.List }
}

#- Assessor --------------------------------------------------------------------
#| An assessor evaluating claims and determining conformance to
#| requirements and confidence in that assessment.
class SBOM::Assessor:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The boolean indicating if the assessor is outside the organization
#| generating claims. A value of false indicates a self assessor.
    has Bool $.thirdParty;

#| The entity issuing the assessment.
    has SBOM::Organization $.organization
}

#- Attestation -----------------------------------------------------------------
#| An attestations asserted by an assessor that maps requirements
#| to claims.
class SBOM::Attestation:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The short description explaining the main points of the attestation.
    has Str $.summary;

#| The bom-ref to the assessor asserting the attestation.
    has bom-ref $.assessor;

#| The grouping of requirements to claims and the attestors declared
#| conformance and confidence thereof.
    has SBOM::RequirementGrouping @.map;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # These should probably be auto-generated in RakUAST at some point
    method map(SBOM::Attestation:D:) { @!map.List }
}

#- DeclarationEvidence ---------------------------------------------------------
#| Evidence used in a declaration.
class SBOM::DeclarationEvidence:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The reference to the property name as defined in the CycloneDX
#| Property Taxonomy.
    has propertyName $.propertyName;

#| The written description of what this evidence is and how it was
#| created.
    has Str $.description;

#| The output or analysis that supports claims.
    has SBOM::EvidenceDataset @.data;

#| The date and time (timestamp) when the evidence was created.
    has DateTime $.created;

#| The date and time (timestamp) when the evidence is no longer valid.
    has DateTime $.expires;

#| The author of the evidence.
    has SBOM::Contact $.author;

#| The reviewer of the evidence.
    has SBOM::Contact $.reviewer;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # These should probably be auto-generated in RakUAST at some point
    method data(SBOM::DeclarationEvidence:D:) { @!data.List }
}

#- Target ----------------------------------------------------------------------
#| A target against which claims are made.
class SBOM::Target:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The list of organizations which claims are made against.
    has SBOM::Organization @.organizations;

#| The list of components which claims are made against.
    has SBOM::Component @.components;

#| The list of services which claims are made against.
    has SBOM::Service @.services;

    # These should probably be auto-generated in RakUAST at some point
    method organizations(SBOM::Target:D:) { @!organizations.List }
    method components(   SBOM::Target:D:) { @!components.List    }
    method services(     SBOM::Target:D:) { @!services.List      }
}

#- Declaration -----------------------------------------------------------------
#| Describes the conformance to standards, may include attestations,
#| claims, and evidence.
class SBOM::Declarations:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The list of assessors evaluating claims and determining conformance
#| to requirements and confidence in that assessment.
    has SBOM::Assessor @.assessors;

#| The list of attestations asserted by an assessor that maps
#| requirements to claims.
    has SBOM::Attestation @.attestations;

#| The list of claims.
    has SBOM::Claim @.claims;

#| The list of evidence.
    has SBOM::DeclarationEvidence @.evidence;

#| The list of targets which claims are made against.
    has SBOM::Target @.targets;

#| A concise statement affirmed by an individual regarding all
#| declarations, often used for third-party auditor acceptance or
#| recipient acknowledgment. It includes a list of authorized
#| signatories who assert the validity of the document on behalf
#| of the organization.
    has SBOM::Affirmation $.affirmation;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # These should probably be auto-generated in RakUAST at some point
    method assessors(   SBOM::Declarations:D:) { @!assessors.List    }
    method attestations(SBOM::Declarations:D:) { @!attestations.List }
    method claims(      SBOM::Declarations:D:) { @!claims.List       }
    method evidence(    SBOM::Declarations:D:) { @!evidence.List     }
    method targets(     SBOM::Declarations:D:) { @!targets.List      }
}

# vim: expandtab shiftwidth=4
