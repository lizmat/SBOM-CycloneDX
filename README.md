[![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions) [![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions) [![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions)

NAME
====

SBOM::CycloneDX - Software Bill Of Materials, CycloneDX style

SYNOPSIS
========

```raku
use SBOM::CycloneDX;

my $from-path = SBOM::CycloneDX.new($path);  # read from path

my $from-io = SBOM::CycloneDX.new($io);      # read from IO object

my $minimal = SBOM::CycloneDX.new(           # create from named args
  bomFormat   => "CycloneDX",
  specVersion => "1.6"
);
```

DESCRIPTION
===========

`SBOM::CycloneDX` provides a distribution for the implementation of the Software Bill Of Materials standard provided by CycloneDX using the [JSON Reference version 1.6](https://cyclonedx.org/docs/1.6/json/).

SCRIPTS
=======

cyclonedx
---------

    $ cyclonedx t/valid/valid-metadata-tool-1.6.json
    't/valid/valid-metadata-tool-1.6.json' is a valid CycloneDX SBOM

The `cyclonedx` script takes **one** positional argument: the path of a CycloneDX file. It will attempt to load the file and report on any errors seen (if possible). Sets `$!` to `1` if an error occurred, or `0` if all is ok.

Accepts the following optional named arguments:

<table class="pod-table">
<thead><tr>
<th>parameter</th> <th>description</th>
</tr></thead>
<tbody>
<tr> <td>--raw</td> <td>whether to show raw errors</td> </tr> <tr> <td>--silent</td> <td>whether to be silent on success</td> </tr>
</tbody>
</table>

    $ cyclonedx t/valid/valid-metadata-tool-1.6.json --silent
    $ echo $!
    0

cyclonedx-enums
---------------

    $ cyclonedx-enums
    All possible enum classes:

    AccessMode
    Acknowledgement
    ...

    $ cyclonedx-enums AccessMode
    All possible values in the 'AccessMode' enum:

    read-only
    read-write
    ...

The `cyclonedx` script takes **one** optional positional argument: the name of the enum class to display information for. It defaults to `all`, in which case all possible enum classes will be displayed.

Accepts the following optional named arguments:

<table class="pod-table">
<thead><tr>
<th>parameter</th> <th>description</th>
</tr></thead>
<tbody>
<tr> <td>--verbose</td> <td>whether to also show the associated WHY info</td> </tr> <tr> <td>--silent</td> <td>whether to not show headers</td> </tr>
</tbody>
</table>

INTROSPECTION METHODS
=====================

A number of introspection methods will be provided, making it easier to search for certain conditions in a given SBOM. Suggestions for types of introspection are very welcome.

CLASSES PROVIDED
================

All classes can be instantiated by calling the `.new` method with named arguments. Each named argument can either be a `SBOM::` object, or a hash containing named arguments.

All `SBOM::` classes also provide the following methods on instances:

  * .build-errors

Returns a list of `Pair`s indicating any elements that were for some reason incorrect, and where thus not added to the object. Should be empty for a completely succesful creation of an instance of a `SBOM::` class.

The key contains the crumb trail of where in the object the problem occurred (e.g. "CycloneDX/Component"), and the value is the `Exception` object that was caught. Usually one is only interested in the `.message` on that object, but during development the complete stack trace provided by the `Exception` object may also be of interest.

  * .bom-refs

Returns a sorted list of bom-refs that have been seen in the instance.

  * .JSON

Returns a JSON representation of the instance.

  * .Map

Returns a `Map` representation of the instance, which can be used as an input to `.new` when flattened.

  * .Hash

Returns a `Hash` representation of the instance, which can be used as an input to `.new` when flattened. This is the mutable version of `.Map`, intended to be used for creation / updates by modifying the returned hash, and using that to create a new object with.

  * .raku

Returns a string representation of the instance, which can be used in an `EVAL`.

SBOM::CycloneDX
---------------

Providing the CycloneDX v1.6 JSON specification in Raku. Accepts these named arguments:

  * BOMFormat `:$bomFormat` (required)

Specifies the format of the BOM. This helps to identify the file as CycloneDX since BOMs do not have a filename convention, nor does JSON schema support namespaces.

  * Str `:$specVersion` (required)

The version of the CycloneDX specification the BOM conforms to.

  * serialNumber `:$serialNumber`

Every BOM generated SHOULD have a unique serial number, even if the contents of the BOM have not changed over time. If specified, the serial number must conform to RFC 4122. Use of serial numbers is recommended.

  * PositiveInt `:$version`

Whenever an existing BOM is modified, either manually or through automated processes, the version of the BOM SHOULD be incremented by 1. When a system is presented with multiple BOMs with identical serial numbers, the system SHOULD use the most recent version of the BOM. The default version is '1'.

  * SBOM::Metadata `:$metadata`

Provides additional information about a BOM.

  * SBOM::Component `:@components`

A list of software and hardware components. All items must be unique.

  * SBOM::Service `:@services`

A list of services. This may include microservices, function-as-a-service, and other types of network or intra-process services. All items must be unique.

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

  * SBOM::Dependency `:@dependencies`

Provides the ability to document dependency relationships including provided & implemented components. All items must be unique.

  * SBOM::Composition `:@compositions`

Compositions describe constituent parts (including components, services, and dependency relationships) and their completeness. The completeness of vulnerabilities expressed in a BOM may also be described.

  * SBOM::Vulnerability `:@vulnerabilities`

Vulnerabilities identified in components or services. All items must be unique.

  * SBOM::Annotation `:@annotations`

Comments made by people, organizations, or tools about any object with a bom-ref, such as components, services, vulnerabilities, or the BOM itself. Unlike inventory information, annotations may contain opinions or commentary from various stakeholders. Annotations may be inline (with inventory) or externalized viai BOM-Link and may optionally be signed. All items must be unique.

  * SBOM::Formulation `:@formulation`

Describes how a component or service was manufactured or deployed. This is achieved through the use of formulas, workflows, tasks, and steps, which declare the precise steps to reproduce along with the observed formulas describing the steps which transpired in the manufacturing process. All items must be unique.

  * SBOM::Declarations `:$declarations`

The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.

  * SBOM::Definition `:@definitions`

A collection of reusable objects that are defined and may be used elsewhere in the BOM.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::Address
-------------

The physical address (location) of the organization. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the address elsewhere in the BOM.

  * Str `:$country`

The country name or the two-letter ISO 3166-1 country code.

  * Str `:$region`

The region or state in the country.

  * Str `:$locality`

The locality or city within the country.

  * Str `:$postOfficeBoxNumber`

The post office box number.

  * Str `:$postalCode`

The postal code.

  * Str `:$streetAddress`

The street address.

SBOM::Advisory
--------------

An advisory of a vulnerability. Accepts these named arguments:

  * Str `:$title`

An optional name of the advisory.

  * URL `:$url` (required)

Location where the advisory can be obtained.

SBOM::AffectedVersion
---------------------

A version or range of versions and their status. Accepts these named arguments:

  * versionString `:$version`

A single version of a component or service.

  * versionRange `:$range`

A version range specified in Package URL Version Range syntax

  * VersionAffection `:$status`

The vulnerability status for the version or range of versions.

SBOM::Affects
-------------

The components or services that are affected by the vulnerability. Accepts these named arguments:

  * bom-refOrLink `:$ref` (required)

References a component or service by the objects bom-ref.

  * SBOM::AffectedVersion `:@versions`

Zero or more individual versions or range of versions.

SBOM::Affirmation
-----------------

A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorizedi signatories who assert the validity of the document on behalf of the organization. Accepts these named arguments:

  * Str `:$statement`

The brief statement affirmed by an individual regarding all declarations. This could be an affirmation of acceptance by a third-party auditor or receiving individual of a file.

  * SBOM::Signatory `:@signatories`

The list of signatories authorized on behalf of an organization to assert validity of this document.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::AlgorithmProperties
-------------------------

Properties specific to a cryptographic algorithm. Accepts these named arguments:

  * AlgorithmPrimitive `:$primitive`

Cryptographic building blocks used in higher-level cryptographic systems and protocols.

  * Str `:$parameterSetIdentifier`

An identifier for the parameter set of the cryptographic algorithm. Examples: in AES128, '128' identifies the key length in bits, in SHA256, '256' identifies the digest length, '128' in SHAKE128 identifies its maximum security level in bits, and 'SHA2-128s' identifies a parameter set used in SLH-DSA (FIPS205).

  * Str `:$curve`

The specific underlying Elliptic Curve (EC) definition employed which is an indicator of the level of security strength, performance and complexity. Absent an authoritative source of curve names, CycloneDX recommends using curve names as defined at https://neuromancer.sk/std/, the source of which can be found at https://github.com/J08nY/std-curves.

  * ExecutionEnvironment `:$executionEnvironment`

The target and execution environment in which the algorithm is implemented in.

  * Platform `:$implementationPlatform`

The target platform for which the algorithm is implemented. The implementation can be 'generic', running on any platform or for a specific platform.

  * Certification `:@certificationLevel`

The certification that the implementation of the cryptographic algorithm has received, if any. Certifications include revisions and levels of FIPS 140 or Common Criteria of different Extended Assurance Levels (CC-EAL).

  * CertificationMode `:$mode`

The mode of operation in which the cryptographic algorithm (block cipher) is used.

  * CertificationPadding `:$padding`

The padding scheme that is used for the cryptographic algorithm.

  * CryptoFunction `:@cryptoFunctions`

The cryptographic functions implemented by the cryptographic algorithm.

  * UInt `:$classicalSecurityLevel`

The classical security level that a cryptographic algorithm provides (in bits).

  * nistQuantumSecurityLevel `:$nistQuantumSecurityLevel`

The NIST security strength category as defined in https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria). A value of 0 indicates that none of the categories are met.

SBOM::Analysis
--------------

An assessment of the impact and exploitability of a vulnerability. Accepts these named arguments:

  * VulnerabilityState `:$state`

Declares the current state of an occurrence of a vulnerability, after automated or manual analysis.

  * Justification `:$justification`

The rationale of why the impact analysis state was asserted.

  * Response `:@response`

A response to the vulnerability by the manufacturer, supplier, or project responsible for the affected component or service. More than one response is allowed. Responses are strongly encouraged for vulnerabilities where the analysis state is exploitable.

  * Str `:$detail`

Detailed description of the impact including methods used during assessment. If a vulnerability is not exploitable, this field should include specific details on why the component or service is not impacted by this vulnerability.

  * DateTime `:$firstIssued`

The date and time (timestamp) when the analysis was first issued.

  * DateTime `:$lastUpdated`

The date and time (timestamp) when the analysis was last updated.

SBOM::Annotation
----------------

Comments made by people, organizations, or tools about any object with a bom-ref, such as components, services, vulnerabilities, or the BOM itself. Unlike inventory information, annotations may contain opinions or commentary from various stakeholders. Annotations may be inline (with inventory) or externalized via BOM-Link and may optionally be signed. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the annotation elsewhere in the BOM.

  * referenceURL `:@subjects` (required)

The object in the BOM identified by its bom-ref. This is often a component or service, but may be any object type supporting bom-refs.

  * SBOM::Annotator `:$annotator` (required)

The organization, person, component, or service which created the textual content of the annotation.

  * DateTime `:$timestamp` (required)

The date and time (timestamp) when the annotation was created.

  * Str `:$text` (required)

The textual content of the annotation.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::Annotator
---------------

Person, organization, component, service making an annotation Accepts these named arguments:

  * SBOM::Contact `:$individual`

The person that created the annotation.

  * SBOM::Organization `:$organization`

The organization that created the annotation.

  * SBOM::Component `:$component`

The tool or component that created the annotation.

  * SBOM::Service `:$service`

The service that created the annotation.

SBOM::AnyLicense
----------------

Either a (modern) License object, or a legacy SPDX License object Accepts these named arguments:

SBOM::Approach
--------------

The overall approach to learning used by the model for problem solving. Accepts these named arguments:

  * Learning `:$type`

Learning types describing the learning problem or hybrid learning problem.

SBOM::Assessor
--------------

An assessor evaluating claims and determining conformance to requirements and confidence in that assessment. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the object elsewhere in the BOM.

  * Bool `:$thirdParty`

The boolean indicating if the assessor is outside the organization generating claims. A value of false indicates a self assessor.

  * SBOM::Organization `:$organization`

The entity issuing the assessment.

SBOM::Attachment
----------------

Supporting material that helps in reproducing or understanding. This may include screenshots, payloads, and PoC exploit code. Accepts these named arguments:

  * mime-type `:$contentType`

Specifies the format and nature of the data being attached, helping systems correctly interpret and process the content. Common content type examples include application/json for JSON data and text/plain for plan text documents.

  * Encoding `:$encoding`

Specifies the optional encoding the text is represented in.

  * Str `:$content` (required)

The attachment data. Proactive controls such as input validation and sanitization should be employed to prevent misuse of attachment text.

SBOM::Attestation
-----------------

An attestations asserted by an assessor that maps requirements to claims. Accepts these named arguments:

  * Str `:$summary`

The short description explaining the main points of the attestation.

  * bom-ref `:$assessor`

The bom-ref to the assessor asserting the attestation.

  * SBOM::RequirementGrouping `:@map`

The grouping of requirements to claims and the attestors declared conformance and confidence thereof.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::Callstack
---------------

Evidence of component use through the callstack. Accepts these named arguments:

  * SBOM::Frame `:@frames`

The frames seen in the callstack.

SBOM::CertificateProperties
---------------------------

Properties for cryptographic assets of asset type 'certificate' Accepts these named arguments:

  * Str `:$subjectName`

The subject name for the certificate.

  * Str `:$issuerName`

The issuer name for the certificate.

  * DateTime `:$notValidBefore`

The date and time according to ISO-8601 standard from which the certificate is valid.

  * DateTime `:$notValidAfter`

The date and time according to ISO-8601 standard from which the certificate is not valid anymore.

  * Str `:$signatureAlgorithmRef`

The bom-ref to signature algorithm used by the certificate.

  * Str `:$subjectPublicKeyRef`

The bom-ref to the public key of the subject.

  * Str `:$certificateFormat`

The format of the certificate.

  * Str `:$certificateExtension`

The file extension of the certificate.

SBOM::CipherSuite
-----------------

A cipher suite related to a protocol. Accepts these named arguments:

  * Str `:$name`

A common name for the cipher suite.

  * Str `:@algorithms`

A list of algorithms related to the cipher suite.

  * Str `:@identifiers`

A list of common identifiers for the cipher suite.

SBOM::Claim
-----------

A claim. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the object elsewhere in the BOM.

  * bom-ref `:$target`

The bom-ref to a target representing a specific system, application, API, module, team, person, process, business unit, company, etc... that this claim is being applied to.

  * Str `:$predicate`

The specific statement or assertion about the target.

  * bom-ref `:@mitigationStrategies`

The list of bom-ref to the evidence provided describing the mitigation strategies. Each mitigation strategy should include an explanation of how any weaknesses in the evidence will be mitigated.

  * Str `:$reasoning`

The written explanation of why the evidence provided substantiates the claim.

  * bom-ref `:@evidence`

The list of bom-ref to evidence that supports this claim.

  * bom-ref `:@counterEvidence`

The list of bom-ref to counter evidence that supports this claim.

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::CO2Cost
-------------

An expression of CO2 cost. Accepts these named arguments:

  * number `:$value` (required)

Quantity of carbon dioxide (CO2).

  * CO2Cost `:$unit` (required)

Unit of carbon dioxide (CO2).

SBOM::Command
-------------

Command or directive for a step Accepts these named arguments:

  * Str `:$executed`

A text representation of the executed command.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Commit
------------

Specifies an individual commit. Accepts these named arguments:

  * Str `:$uid`

A unique identifier of the commit. This may be version control specific. For example, Subversion uses revision numbers whereas git uses commit hashes.

  * URL `:$url`

The URL to the commit. This URL will typically point to a commit in a version control system.

  * SBOM::Development `:$author`

The author who created the changes in the commit.

  * SBOM::Development `:$committer`

The person who committed or pushed the commit.

  * Str `:$message`

The text description of the contents of the commit.

SBOM::Component
---------------

A software or hardware component. Accepts these named arguments:

  * ComponentType `:$type` (required)

Specifies the type of the component. For software components, classify as application if no more specific appropriate classification is available or cannot be determined for the component.

  * mime-type `:$mime-type`

The optional mime-type of the component. When used on file components, the mime-type can provide additional context about the kind of file being represented, such as an image, font, or executable. Some library or framework components may also have an associated mime-type.

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the component elsewhere in the BOM. Every bom-ref must be unique within the BOM. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts with BOM-Links.

  * SBOM::Organization `:$supplier`

The organization that supplied the component. The supplier may often be the manufacturer, but may also be a distributor or repackager.

  * SBOM::Organization `:$manufacturer`

The organization that created the component. Manufacturer is common in components created through automated processes. Components created through manual means may have @.authors instead.

  * SBOM::Contact `:@authors`

The person(s) who created the component. Authors are common in components created through manual processes. Components created through automated means may have @.manufacturer instead.

  * Str `:$author`

  * Str `:$publisher`

The person(s) or organization(s) that published the component.

  * Str `:$group`

The grouping name or identifier. This will often be a shortened, single name of the company or project that produced the component, or the source package or domain name. Whitespace and special characters should be avoided. Examples include: apache, org.apache.commons, and apache.org.

  * Str `:$name` (required)

The name of the component. This will often be a shortened, single name of the component. Examples: commons-lang3 and jquery.

  * versionString `:$version`

The component version. The version should ideally comply with semantic versioning but is not enforced.

  * Str `:$description`

Specifies a description for the component

  * Scope `:$scope`

Specifies the scope of the component. If scope is not specified, 'required' scope SHOULD be assumed by the consumer of the BOM.

  * SBOM::HashedString `:@hashes`

The hashes of the component.

  * SBOM::AnyLicense `:@licenses`

EITHER (list of SPDX licenses and/or named licenses) OR (tuple of one SPDX License Expression)

  * Str `:$copyright`

A copyright notice informing users of the underlying claims to copyright ownership in a published work.

  * CPE `:$cpe`

Asserts the identity of the component using CPE. The CPE must conform to the CPE 2.2 or 2.3 specification. See https://nvd.nist.gov/products/cpe. Refer to @.evidence.identity to optionally provide evidence that substantiates the assertion of the component's identity.

  * PURL `:$purl`

Asserts the identity of the component using package-url (purl). The purl, if specified, must be valid and conform to the specification defined at: https://github.com/package-url/purl-spec. Refer to @.evidence.identity to optionally provide evidence that substantiates the assertion of the component's identity.

  * omniborId `:@omniborId`

Asserts the identity of the component using the OmniBOR Artifact ID. The OmniBOR, if specified, must be valid and conform to the specification defined at: https://www.iana.org/assignments/uri-schemes/prov/gitoid. Refer to @.evidence.identity to optionally provide evidence that substantiates the assertion of the component's identity.

  * SWHID `:@swhid`

Asserts the identity of the component using the Software Heritage persistent identifier (SWHID). The SWHID, if specified, must be valid and conform to the specification defined at: https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html. Refer to @.evidence.identity to optionally provide evidence that substantiates the assertion of the component's identity.

  * SBOM::SWID `:$swid`

Asserts the identity of the component using ISO-IEC 19770-2 Software Identification (SWID) Tags. Refer to @.evidence.identity to optionally provide evidence that substantiates the assertion of the component's identity.

  * Bool `:$modified`

[Deprecated] This will be removed in a future version. Use the pedigree element instead to supply information on exactly how the component was modified. A boolean value indicating if the component has been modified from the original. A value of true indicates the component is a derivative of the original. A value of false indicates the component has not been modified from the original.

  * SBOM::Pedigree `:$pedigree`

Component pedigree is a way to document complex supply chain scenarios where components are created, distributed, modified, redistributed, combined with other components, etc. Pedigree supports viewing this complex chain from the beginning, the end, or anywhere in the middle. It also provides a way to document variants where the exact relation may not be known.

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

  * SBOM::Component `:@components`

A list of software and hardware components included in the parent component. This is not a dependency tree. It provides a way to specify a hierarchical representation of component assemblies, similar to system → subsystem → parts assembly in physical supply chains.

  * SBOM::ComponentEvidence `:$evidence`

Provides the ability to document evidence collected through various forms of extraction or analysis.

  * SBOM::ReleaseNotes `:$releaseNotes`

Specifies optional release notes.

  * SBOM::ModelCard `:$modelCard`

A model card describes the intended uses of a machine learning model and potential limitations, including biases and ethical considerations. Model cards typically contain the training parameters, which datasets were used to train the model, performance metrics, and other relevant data useful for ML transparency. This object SHOULD be specified for any component of type machine-learning-model and must not be specified for other component types.

  * SBOM::ComponentDataset `:@data`

Data associated with a data component.

  * SBOM::CryptoProperties `:$cryptoProperties`

Cryptographic assets have properties that uniquely define them and that make them actionable for further reasoning. As an example, it makes a difference if one knows the algorithm family (e.g. AES) or the specific variant or instantiation (e.g. AES-128-GCM). This is because the security level and the algorithm primitive (authenticated encryption) are only defined by the definition of the algorithm variant. The presence of a weak cryptographic algorithm like SHA1 vs. HMAC-SHA1 also makes a difference.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * Str `:@tags`

Textual strings that aid in discovery, search, and retrieval of the associated object. Tags often serve as a way to group or categorize similar or related objects by various attributes.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::ComponentDataset
----------------------

A dataset associated with a component. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the dataset elsewhere in the BOM.

  * DataSource `:$type` (required)

The general theme or subject matter of the data being specified.

  * Str `:$name`

The name of the dataset.

  * SBOM::DataContents `:$contents`

The contents or references to the contents of the data being described.

  * Str `:$classification`

Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.

  * Str `:@sensitiveData`

A description of any sensitive data in a dataset.

  * SBOM::Graphics `:$graphics`

A collection of graphics that represent various measurements.

  * Str `:$description`

A description of the dataset. Can describe size of dataset, whether it's used for source code, training, testing, or validation, etc.

  * SBOM::Governance `:$governance`

Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle.

SBOM::ComponentEvidence
-----------------------

The ability to document evidence about a component, collected through various forms of extraction or analysis. Accepts these named arguments:

  * SBOM::Occurrence `:@occurrences`

Evidence of individual instances of a component spread across multiple locations.

  * SBOM::Callstack `:$callstack`

Evidence of the components use through the callstack.

  * SBOM::AnyLicense `:@licenses`

EITHER (list of SPDX licenses and/or named licenses) OR (tuple of one SPDX License Expression).

  * SBOM::Copyright `:@copyright`

A copyright notice informing users of the underlying claims to copyright ownership in a published work.

  * SBOM::Identity `:$identity`

[DEPRECATED] Evidence that substantiates the identity of a component.

  * SBOM::Identity `:@identity`

Evidence that substantiates the identity of a component. The identity may be an object or an array of identity objects. Support for specifying identity as a single object was introduced in CycloneDX v1.5. Arrays were introduced in v1.6. It is recommended that all implementations use arrays, even if only one identity object is specified.

SBOM::Composition
-----------------

Compositions describe constituent parts (including components, services, and dependency relationships) and their completeness. The completeness of vulnerabilities expressed in a BOM may also be described. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the composition elsewhere in the BOM.

  * Aggregate `:$aggregate`

Specifies an aggregate type that describes how complete a relationship is.

  * bom-refOrLink `:@assemblies`

The bom-ref identifiers of the components or services being described. Assemblies refer to nested relationships whereby a constituent part may include other constituent parts. References do not cascade to child parts. References are explicit for the specified constituent part only.

  * bom-ref `:@dependencies`

The bom-ref identifiers of the components or services being described. Dependencies refer to a relationship whereby an independent constituent part requires another independent constituent part. References do not cascade to transitive dependencies. References are explicit for the specified dependency only.

  * bom-ref `:@vulnerabilities`

The bom-ref identifiers of the vulnerabilities being described.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::Condition
---------------

A condition that was used to determine a trigger should be activated. Accepts these named arguments:

  * Str `:$description`

Describes the set of conditions which cause the trigger to activate.

  * Str `:$expression`

The logical expression that was evaluated that determined the trigger should be fired.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Confidence
----------------

The confidence of the claim meeting the requirement. Accepts these named arguments:

  * confidenceValue `:$score`

The confidence of the claim between and inclusive of 0 and 1, where 1 is 100% confidence.

  * Str `:$rationale`

The rationale for the confidence score.

SBOM::ConfidenceInterval
------------------------

The confidence interval of a metric. Accepts these named arguments:

  * Str `:$lowerBound`

The lower bound of the confidence interval.

  * Str `:$upperBound`

The upper bound of the confidence interval.

SBOM::Conformance
-----------------

The conformance of the claim meeting a requirement. Accepts these named arguments:

  * conformanceValue `:$score`

The conformance of the claim between and inclusive of 0 and 1, where 1 is 100% conformance.

  * Str `:$rationale`

The rationale for the conformance score.

  * bom-ref `:@mitigationStrategies`

The list of bom-ref to the evidence provided describing the mitigation strategies.

SBOM::Considerations
--------------------

What considerations should be taken into account regarding a model's construction, training, and application? Accepts these named arguments:

  * Str `:@users`

Who are the intended users of the model?

  * Str `:@useCases`

What are the intended use cases of the model?

  * Str `:@technicalLimitations`

What are the known technical limitations of the model? E.g. What kind(s) of data should the model be expected not to perform well on? What are the factors that might degrade model performance?

  * Str `:@performanceTradeoffs`

What are the known tradeoffs in accuracy/performance of the model?

  * SBOM::EthicalConsideration `:@ethicalConsiderations`

What are the ethical risks involved in the application of this model?

  * SBOM::EnvironmentalConsiderations `:$environmentalConsiderations`

What are the various environmental impacts the corresponding machine learning model has exhibited across its lifecycle?

  * SBOM::FairnessAssessment `:@fairnessAssessments`

How does the model affect groups at risk of being systematically disadvantaged? What are the harms and benefits to the various affected groups?

SBOM::Contact
-------------

A person. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the person elsewhere in the BOM.

  * Str `:$name`

The name of a contact.

  * email `:$email`

The email address of the contact.

  * Str `:$phone`

The phone number of the contact.

SBOM::Copyright
---------------

Copyright evidence captures intellectual property assertions, providing evidence of possible ownership and legal protection. Accepts these named arguments:

  * Str `:$text` (required)

The textual content of the copyright.

SBOM::Credits
-------------

Individuals or organizations credited with the discovery of a vulnerability. Accepts these named arguments:

  * SBOM::Organization `:@organizations`

The organizations credited with vulnerability discovery.

  * SBOM::Contact `:@individuals`

The individuals, not associated with organizations, that are credited with vulnerability discovery.

SBOM::CryptoMaterialProperties
------------------------------

Properties for cryptographic assets of asset type: related-crypto-material Accepts these named arguments:

  * Crypto `:$type`

The type for the related cryptographic material

  * Str `:$id`

The optional unique identifier for the related cryptographic material.

  * CryptoState `:$state`

The key state as defined by NIST SP 800-57.

  * Str `:$algorithmRef`

The bom-ref to the algorithm used to generate the related cryptographic material.

  * DateTime `:$creationDate`

The date and time (timestamp) when the related cryptographic material was created.

  * DateTime `:$activationDate`

The date and time (timestamp) when the related cryptographic material was activated.

  * DateTime `:$updateDate`

The date and time (timestamp) when the related cryptographic material was updated.

  * DateTime `:$expirationDate`

The date and time (timestamp) when the related cryptographic material expires.

  * Str `:$value`

The associated value of the cryptographic material.

  * UInt `:$size`

The size of the cryptographic asset (in bits).

  * Str `:$format`

The format of the related cryptographic material (e.g. P8, PEM, DER).

  * SBOM::CryptoSecurity `:$securedBy`

The mechanism by which the cryptographic asset is secured by.

SBOM::CryptoProperties
----------------------

Cryptographic assets have properties that uniquely define them and that make them actionable for further reasoning. As an example, it makes a difference if one knows the algorithm family (e.g. AES) or the specific variant or instantiation (e.g. AES-128-GCM). This is because the security level and the algorithm primitive (authenticated encryption) are only defined by the definition of the algorithm variant. The presence of a weak cryptographic algorithm like SHA1 vs. HMAC-SHA1 also makes a difference. Accepts these named arguments:

  * CryptoAsset `:$assetType` (required)

Type of crypto asset.

  * SBOM::AlgorithmProperties `:$algorithmProperties`

Additional properties specific to a cryptographic algorithm.

  * SBOM::CertificateProperties `:$certificateProperties`

Properties for cryptographic assets of asset type 'certificate'.

  * SBOM::CryptoMaterialProperties `:$relatedCryptoMaterialProperties`

Properties for cryptographic assets of asset type 'related-crypto-material'.

  * SBOM::CryptoProtocolProperties `:$protocolProperties`

Properties specific to cryptographic assets of type: protocol.

  * Str `:$oid`

The object identifier (OID) of the cryptographic asset.

SBOM::CryptoProtocolProperties
------------------------------

Properties specific to cryptographic assets of type: protocol. Accepts these named arguments:

  * CryptoProtocol `:$type`

The concrete protocol type.

  * versionString `:$version`

The version of the protocol.

  * SBOM::CipherSuite `:@cipherSuites`

A list of cipher suites related to the protocol.

  * SBOM::IKEv2TransformTypes `:$ikev2TransformTypes`

The IKEv2 transform types supported (types 1-4), defined in RFC 7296 section 3.3.2, and additional properties.

  * IDnotbomLink `:@cryptoRefArray`

A list of protocol-related cryptographic assets, Identifier for referable and therefore interlinkable elements.

SBOM::CryptoSecurity
--------------------

The mechanism by which a cryptographic asset is secured by. Accepts these named arguments:

  * Str `:$mechanism`

Specifies the mechanism by which the cryptographic asset is secured by.

  * Str `:$algorithmRef`

The bom-ref to the algorithm.

SBOM::DataContents
------------------

The contents or references to the contents of data being described. Accepts these named arguments:

  * SBOM::Attachment `:$attachment`

An optional way to include textual or encoded data.

  * URL `:$url`

The URL to where the data can be retrieved.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::DeclarationEvidence
-------------------------

Evidence used in a declaration. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the object elsewhere in the BOM.

  * propertyName `:$propertyName`

The reference to the property name as defined in the CycloneDX Property Taxonomy.

  * Str `:$description`

The written description of what this evidence is and how it was created.

  * SBOM::EvidenceDataset `:@data`

The output or analysis that supports claims.

  * DateTime `:$created`

The date and time (timestamp) when the evidence was created.

  * DateTime `:$expires`

The date and time (timestamp) when the evidence is no longer valid.

  * SBOM::Contact `:$author`

The author of the evidence.

  * SBOM::Contact `:$reviewer`

The reviewer of the evidence.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::Declarations
------------------

Describes the conformance to standards, may include attestations, claims, and evidence. Accepts these named arguments:

  * SBOM::Assessor `:@assessors`

The list of assessors evaluating claims and determining conformance to requirements and confidence in that assessment.

  * SBOM::Attestation `:@attestations`

The list of attestations asserted by an assessor that maps requirements to claims.

  * SBOM::Claim `:@claims`

The list of claims.

  * SBOM::DeclarationEvidence `:@evidence`

The list of evidence.

  * SBOM::Target `:@targets`

The list of targets which claims are made against.

  * SBOM::Affirmation `:$affirmation`

A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorized signatories who assert the validity of the document on behalf of the organization.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::Definition
----------------

Reusable object that may be used elsewhere in the BOM. Accepts these named arguments:

  * SBOM::Standard `:@standards`

The list of standards which may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to.

SBOM::Dependency
----------------

Defines the direct dependencies of a component, service, or the components provided/implemented by a given component. Components or services that do not have their own dependencies must be declared as empty elements within the graph. Components or services that are not represented in the dependency graph may have unknown dependencies. It is recommended that implementations assume this to be opaque and not an indicator of an object being dependency-free. It is recommended to leverage compositions to indicate unknown dependency graphs. Accepts these named arguments:

  * bom-ref `:$ref`

References a component or service by its bom-ref attribute.

  * bom-ref `:@dependsOn`

The bom-ref identifiers of the components or services that are dependencies of this dependency object.

  * bom-ref `:@provides`

The bom-ref identifiers of the components or services that define a given specification or standard, which are provided or implemented by this dependency object. For example, a cryptographic library which implements a cryptographic algorithm. A component which implements another component does not imply that the implementation is in use.

SBOM::Development
-----------------

An action during development, such as a commit. Accepts these named arguments:

  * DateTime `:$timestamp`

The timestamp in which the action occurred.

  * Str `:$name`

The name of the individual who performed the action.

  * email `:$email`

The email address of the individual who performed the action.

SBOM::Diff
----------

The patch file (or diff) that shows changes. Refer to https://en.wikipedia.org/wiki/Diff Accepts these named arguments:

  * SBOM::Attachment `:$text`

Specifies the optional text of the diff.

  * URL `:$url`

Specifies the URL to the diff.

SBOM::EnergyConsumption
-----------------------

Describes energy consumption information incurred during a component's lifecycle activities. Accepts these named arguments:

  * Activity `:$activity` (required)

The type of activity that is part of a machine learning model development or operational lifecycle.

  * SBOM::EnergyProvider `:@energyProviders` (required)

The provider(s) of the energy consumed by the associated model development lifecycle activity.

  * SBOM::EnergyCost `:$activityEnergyCost` (required)

The total energy cost associated with the model lifecycle activity.

  * SBOM::CO2Cost `:$co2CostEquivalent`

The CO2 cost (debit) equivalent to the total energy cost.

  * SBOM::CO2Cost `:$co2CostOffset`

The CO2 offset (credit) for the CO2 equivalent cost.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::EnergyCost
----------------

The energy provided by the energy source for an associated activity. Accepts these named arguments:

  * number `:$value` (required)

Quantity of energy.

  * EnergyUnit `:$unit` (required)

Unit of energy.

SBOM::EnergyProvider
--------------------

The provider of the energy consumed by a model during its development lifecycle activity. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the energy provider elsewhere in the BOM.

  * Str `:$description`

A description of the energy provider.

  * SBOM::Organization `:$organization` (required)

The organization that provides energy.

  * Energy `:$energySource` (required)

The energy source for the energy provider.

  * SBOM::EnergyCost `:$energyProvided` (required)

The energy provided by the energy source for an associated activity.

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

SBOM::EnvironmentalConsiderations
---------------------------------

What are the various environmental impacts a machine learning model has exhibited across its lifecycle? Accepts these named arguments:

  * SBOM::EnergyConsumption `:@energyConsumptions`

Describes energy consumption information incurred for one or more component lifecycle activities.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::EthicalConsideration
--------------------------

What are the ethical risks involved in the application of a model? Accepts these named arguments:

  * Str `:$name`

The name of the risk.

  * Str `:$mitigationStrategy`

Strategy used to address this risk.

SBOM::Event
-----------

The event data that caused the associated trigger to activate. Accepts these named arguments:

  * Str `:$uid`

The unique identifier of the event.

  * Str `:$description`

A description of the event.

  * DateTime `:$timeReceived`

The date and time (timestamp) when the event was received.

  * SBOM::Attachment `:$data`

Encoding of the raw event data.

  * SBOM::ResourceReference `:$source`

References the component or service that was the source of the event.

  * SBOM::ResourceReference `:$target`

References the component or service that was the target of the event.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::EvidenceDataset
---------------------

Data associated with evidence of a claim. Accepts these named arguments:

  * Str `:$name`

The name of the data.

  * SBOM::DataContents `:$contents`

The contents or references to the contents of the data being described.

  * Str `:$classification`

Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.

  * Str `:@sensitiveData`

A description of any sensitive data included.

  * SBOM::Governance `:$governance`

Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle.

SBOM::EvidenceMethod
--------------------

A method used to extract and/or analyze the evidence. Accepts these named arguments:

  * Evidence `:$technique` (required)

The technique used in this method of analysis.

  * confidenceValue `:$confidence` (required)

The confidence of the evidence from 0 - 1, where 1 is 100% confidence. Confidence is specific to the technique used. Each technique of analysis can have independent confidence.

  * Str `:$value`

The value or contents of the evidence.

SBOM::ExecutionStep
-------------------

Executes specific commands or tools in order to accomplish its owning task as part of a sequence. Accepts these named arguments:

  * Str `:$name`

A name for the step.

  * Str `:$description`

A description for the step.

  * SBOM::Command `:@commands`

Ordered list of commands or directives for the step.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::FairnessAssessment
------------------------

How does the model affect groups at risk of being systematically disadvantaged? What are the harms and benefits to the various affected groups? Accepts these named arguments:

  * Str `:$groupAtRisk`

The groups or individuals at risk of being systematically disadvantaged by the model.

  * Str `:$benefits`

Expected benefits to the identified groups.

  * Str `:$harms`

Expected harms to the identified groups.

  * Str `:$mitigationStrategy`

With respect to the benefits and harms outlined, please describe any mitigation strategy implemented.

SBOM::Formulation
-----------------

Describes how a component or service was manufactured or deployed. This is achieved through the use of formulas, workflows, tasks, and steps, which declare the precise steps to reproduce along with the observed formulas describing the steps which transpired in the manufacturing process. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the formula elsewhere in the BOM.

  * SBOM::Component `:@components`

Transient components that are used in tasks that constitute one or more of this formula's workflows.

  * SBOM::Service `:@services`

Transient services that are used in tasks that constitute one or more of this formula's workflows.

  * SBOM::Workflow `:@workflows`

List of workflows that can be declared to accomplish specific orchestrated goals and independently triggered.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Frame
-----------

Within a call stack, a frame is a discrete unit that encapsulates an execution context, including local variables, parameters, and the return address. As function calls are made, frames are pushed onto the stack, forming an array-like structure that orchestrates the flow of program execution and manages the sequence of function invocations. Accepts these named arguments:

  * Str `:$package`

A package organizes modules into namespaces, providing a unique namespace for each type it contains.

  * Str `:$module` (required)

A module or class that encloses functions/methods and other code.

  * Str `:$function`

A block of code designed to perform a particular task.

  * Str `:@parameters`

Optional arguments that are passed to the module or function.

  * PositiveInt `:$line`

The line number the code that is called resides on.

  * PositiveInt `:$column`

The column the code that is called resides.

  * Str `:$fullFilename`

The full path and filename of the module.

SBOM::Governance
----------------

Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle. Accepts these named arguments:

  * SBOM::Governor `:@custodians`

Data custodians are responsible for the safe custody, transport, and storage of data.

  * SBOM::Governor `:@stewards`

Data stewards are responsible for data content, context, and associated business rules.

  * SBOM::Governor `:@owners`

Data owners are concerned with risk and appropriate access to data.

SBOM::Governor
--------------

A person or organization governing data Accepts these named arguments:

  * SBOM::Organization `:$organization`

A governing organization

  * SBOM::Contact `:$contact`

A governing individual

SBOM::Graphic
-------------

A single graphic Accepts these named arguments:

  * Str `:$name`

The name of the graphic.

  * SBOM::Attachment `:$image`

The graphic (vector or raster).

SBOM::Graphics
--------------

A collection of graphics that represent various measurements. Accepts these named arguments:

  * Str `:$description`

A description of this collection of graphics.

  * SBOM::Graphic `:@collection`

A collection of graphics.

SBOM::HashedString
------------------

A hashed representation of data Accepts these named arguments:

  * HashAlgorithm `:$alg` (required)

The algorithm that generated the hash value.

  * contentHash `:$content` (required)

The value of the hash.

SBOM::Identity
--------------

Evidence that substantiates the identity of a component. Accepts these named arguments:

  * Field `:$field` (required)

The identity field of the component which the evidence describes.

  * confidenceValue `:$confidence`

The overall confidence of the evidence from 0 - 1, where 1 is 100% confidence.

  * Str `:$concludedValue`

The value of the field (cpe, purl, etc) that has been concluded based on the aggregate of all methods (if available).

  * SBOM::EvidenceMethod `:@methods`

The methods used to extract and/or analyze the evidence.

  * bom-refOrLink `:@tools`

The object in the BOM identified by its bom-ref. This is often a component or service but may be any object type supporting bom-refs. Tools used for analysis should already be defined in the BOM, either in the metadata/tools, components, or formulation.

SBOM::IKEv2TransformTypes
-------------------------

The IKEv2 transform types supported (types 1-4), defined in RFC 7296 section 3.3.2, and additional properties. Accepts these named arguments:

  * Str `:@encr`

Transform Type 1: encryption algorithms.

  * Str `:@prf`

Transform Type 2: pseudorandom functions.

  * Str `:@integ`

Transform Type 3: integrity algorithms.

  * Str `:@ke`

Transform Type 4: Key Exchange Method (KE) per RFC 9370, formerly called Diffie-Hellman Group (D-H).

  * Bool `:$esn`

Specifies if an Extended Sequence Number (ESN) is used.

  * IDnotbomLink `:@auth`

IKEv2 Authentication methods: identifier for referable and therefore interlinkable elements.

SBOM::Input
-----------

Type that represents various input data types and formats. Accepts these named arguments:

  * SBOM::ResourceReference `:$source`

A reference to the component or service that provided the input to the task (e.g., reference to a service with data flow value of inbound)

  * SBOM::ResourceReference `:$target`

A reference to the component or service that received or stored the input if not the task itself (e.g., a local, named storage workspace)

  * SBOM::ResourceReference `:$resource`

A reference to an independent resource provided as an input to a task by the workflow runtime.

  * SBOM::Parameter `:@parameters`

Inputs that have the form of parameters with names and values.

  * SBOM::Attachment `:$data`

Inputs that have the form of data.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * Mu `:@environmentVars`

Inputs that have the form of parameters with names and values.

SBOM::LegacyTool
----------------

Legacy format of the description of a tool used to identify, confirm, or score a vulnerability. Accepts these named arguments:

  * Str `:$vendor`

The name of the vendor who created the tool.

  * Str `:$name`

The name of the tool.

  * versionString `:$version`

The version of the tool.

  * SBOM::HashedString `:@hashes`

The hashes of the tool (if applicable).

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

SBOM::Lifecycle
---------------

Lifecycles communicate the stage(s) in which data in the BOM was captured. Different types of data may be available at various phases of a lifecycle, such as the Software Development Lifecycle (SDLC), IT Asset Management (ITAM), and Software Asset Management (SAM). Thus, a BOM may include data specific to or only obtainable in a given lifecycle. Accepts these named arguments:

  * Phase `:$phase`

A pre-defined phase in the product lifecycle.

  * Str `:$name`

The name of the lifecycle phase.

  * Str `:$description`

The description of the lifecycle phase.

SBOM::Metadata
--------------

Provides additional information about a BOM. Accepts these named arguments:

  * DateTime `:$timestamp`

The date and time (timestamp) when the BOM was created.

  * SBOM::Lifecycle `:@lifecycles`

The product lifecycle(s) that this BOM represents.

  * SBOM::Organization `:$manufacture`

[Deprecated] This will be removed in a future version. Use the "manufacturer" instead. The organization that manufactured the component that the BOM describes.

  * SBOM::Organization `:$manufacturer`

The organization that created the BOM. Manufacturer is common in BOMs created through automated processes. BOMs created through manual means may have @.authors instead.

  * SBOM::Contact `:@authors`

The person(s) who created the BOM. Authors are common in BOMs created through manual processes. BOMs created through automated means may have $.manufacturer instead.

  * SBOM::Component `:$component`

The component that the BOM describes.

  * SBOM::Organization `:$supplier`

The organization that supplied the component that the BOM describes. The supplier may often be the manufacturer, but may also be a distributor or repackager.

  * SBOM::AnyLicense `:@licenses`

The license information for the BOM document. This may be different from the license(s) of the component(s) that the BOM describes.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * SBOM::LegacyTool `:@tools`

The legacy tools used in the creation, enrichment, and validation the BOM.

  * SBOM::Tool `:$tools`

The tool used in the creation, enrichment, and validation of the BOM.

SBOM::ModelCard
---------------

A model card describes the intended uses of a machine learning model and potential limitations, including biases and ethical considerations. Model cards typically contain the training parameters, which datasets were used to train the model, performance metrics, and other relevant data useful for ML transparency. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the model card elsewhere in the BOM.

  * SBOM::ModelParameters `:$modelParameters`

Hyper-parameters for construction of the model.

  * SBOM::QuantitativeAnalysis `:$quantitativeAnalysis`

A quantitative analysis of the model

  * SBOM::Considerations `:$considerations`

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::ModelDataset
------------------

A dataset used to train and evaluate the model. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the dataset elsewhere in the BOM.

  * DataSource `:$type` (required)

The general theme or subject matter of the data being specified.

  * Str `:$name`

The name of the dataset.

  * SBOM::DataContents `:$contents`

The contents or references to the contents of the data being described.

  * Str `:$classification`

Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.

  * Str `:@sensitiveData`

A description of any sensitive data in a dataset.

  * SBOM::Graphics `:$graphics`

A collection of graphics that represent various measurements.

  * Str `:$description`

A description of the dataset. Can describe size of dataset, whether it's used for source code, training, testing, or validation, etc.

  * SBOM::Governance `:$governance`

Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle.

SBOM::ModelFormat
-----------------

The input / output format of a model Accepts these named arguments:

  * Str `:$format`

The data format for input/output to the model, e.g. "string", "image", "time-series".

SBOM::ModelParameters
---------------------

Hyper-parameters for construction of the model. Accepts these named arguments:

  * SBOM::Approach `:$approach`

The overall approach to learning used by the model for problem solving.

  * Str `:$task`

Directly influences the input and/or output. Examples include classification, regression, clustering, etc.

  * Str `:$architectureFamily`

The model architecture family such as transformer network, convolutional neural network, residual neural network, LSTM neural network, etc.

  * Str `:$modelArchitecture`

The specific architecture of the model such as GPT-1, ResNet-50, YOLOv3, etc.

  * SBOM::ModelDataset `:@datasets`

The datasets used to train and evaluate the model.

  * SBOM::ModelFormat `:@inputs`

The input format(s) of the model.

  * SBOM::ModelFormat `:@outputs`

The output format(s) of the model.

SBOM::Note
----------

A release note containing the locale and content. Accepts these named arguments:

  * locale `:$locale`

The ISO-639 (or higher) language code and optional ISO-3166 (or higher) country code.

  * SBOM::Attachment `:$text` (required)

Specifies the full content of the release note.

SBOM::Occurrence
----------------

Evidence of instance of a component spread across multiple locations. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the occurrence elsewhere in the BOM

  * Str `:$location` (required)

The location or path to where the component was found.

  * PositiveInt `:$line`

The line number where the component was found.

  * PositiveInt `:$offset`

The offset where the component was found.

  * Str `:$symbol`

The symbol name that was found associated with the component.

  * Str `:$additionalContext`

Any additional context of the detected component (e.g. a code snippet).

SBOM::Organization
------------------

An organization, as opposed to a person. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the object elsewhere in the BOM.

  * Str `:$name`

The name of the organization.

  * SBOM::Address `:$address`

The physical address (location) of the organization.

  * URL `:@url`

The URL of the organization. Multiple URLs are allowed.

  * SBOM::Contact `:@contact`

A contact at the organization. Multiple contacts are allowed.

SBOM::Output
------------

Represents resources and data output from a task at runtime by executor or task commands. Accepts these named arguments:

  * OutputType `:$type`

Describes the type of data output.

  * SBOM::ResourceReference `:$source`

Component or service that generated or provided the output from a task (e.g., a build tool)

  * SBOM::ResourceReference `:$target`

Component or service that received the output from the task (e.g., reference to an artifactory service with data flow value of outbound).

  * SBOM::ResourceReference `:$resource`

A reference to an independent resource generated as output by a task.

  * SBOM::Attachment `:$data`

Outputs that have the form of data.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * Mu `:@environmentVars`

Outputs that have the form of environment variables.

SBOM::Parameter
---------------

A representation of a functional parameter. Accepts these named arguments:

  * Str `:$name`

The name of the parameter.

  * Str `:$value`

The value of the parameter.

  * Str `:$dataType`

The data type of the parameter.

SBOM::Patch
-----------

Specifies an individual patch Accepts these named arguments:

  * Patch `:$type` (required)

Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.

  * SBOM::Diff `:$diff`

The patch file (or diff) that shows changes. Refer to https://en.wikipedia.org/wiki/Diff

  * SBOM::Resolve `:@resolves`

A collection of issues the patch resolves.

SBOM::Pedigree
--------------

Component pedigree is a way to document complex supply chain scenarios where components are created, distributed, modified, redistributed, combined with other components, etc. Pedigree supports viewing this complex chain from the beginning, the end, or anywhere in the middle. It also provides a way to document variants where the exact relation may not be known. Accepts these named arguments:

  * SBOM::Component `:@ancestors`

Describes zero or more components in which a component is derived from. This is commonly used to describe forks from existing projects where the forked version contains a ancestor node containing the original component it was forked from. For example, Component A is the original component. Component B is the component being used and documented in the BOM. However, Component B contains a pedigree node with a single ancestor documenting Component A - the original component from which Component B is derived from.

  * SBOM::Component `:@descendants`

Descendants are the exact opposite of ancestors. This provides a way to document all forks (and their forks) of an original or root component.

  * SBOM::Component `:@variants`

Variants describe relations where the relationship between the components is not known. For example, if Component A contains nearly identical code to Component B. They are both related, but it is unclear if one is derived from the other, or if they share a common ancestor.

  * SBOM::Commit `:@commits`

A list of zero or more commits which provide a trail describing how the component deviates from an ancestor, descendant, or variant.

  * SBOM::Patch `:@patches`

A list of zero or more patches describing how the component deviates from an ancestor, descendant, or variant. Patches may be complementary to commits or may be used in place of commits.

  * Str `:$notes`

Notes, observations, and other non-structured commentary describing the components pedigree.

SBOM::PerformanceMetric
-----------------------

The model performance metrics being reported. Examples may include accuracy, F1 score, precision, top-3 error rates, MSC, etc. Accepts these named arguments:

  * Str `:$type`

The type of performance metric.

  * Str `:$value`

The value of the performance metric.

  * Str `:$slice`

The name of the slice this metric was computed on. By default, assume this metric is not sliced.

  * SBOM::ConfidenceInterval `:$confidenceInterval`

The confidence interval of the metric.

SBOM::ProofOfConcept
--------------------

Evidence used to reproduce a vulnerability. Accepts these named arguments:

  * Str `:$reproductionSteps`

Precise steps to reproduce the vulnerability.

  * Str `:$environment`

A description of the environment in which reproduction was possible.

  * SBOM::Attachment `:@supportingMaterial`

Supporting material that helps in reproducing or understanding how reproduction is possible. This may include screenshots, payloads, and PoC exploit code.

SBOM::Property
--------------

Provides the ability to document properties in a name-value store. This provides flexibility to include data not officially supported in the standard without having to use additional namespaces or create extensions. Unlike key-value stores, properties support duplicate names, each potentially having different values. Property names of interest to the general public are encouraged to be registered in the CycloneDX Property Taxonomy. Formal registration is optional. Accepts these named arguments:

  * Str `:$name` (required)

The name of the property. Duplicate names are allowed.

  * Str `:$value`

The value of the property.

SBOM::QuantitativeAnalysis
--------------------------

A quantitative analysis of a model Accepts these named arguments:

  * SBOM::PerformanceMetric `:@performanceMetrics`

The model performance metrics being reported.

  * SBOM::Graphics `:$graphics`

A collection of graphics that represent various measurements.

SBOM::Rating
------------

Defines the severity or risk ratings of a vulnerability. Accepts these named arguments:

  * SBOM::Source `:$source`

The source that calculated the severity or risk rating of the vulnerability.

  * number `:$score`

The numerical score of the rating.

  * Severity `:$severity`

Textual representation of the severity that corresponds to the numerical score of the rating.

  * RiskMethodology `:$method`

Specifies the severity or risk scoring methodology or standard used.

  * Str `:$vector`

Textual representation of the metric values used to score the vulnerability.

  * Str `:$justification`

An optional reason for rating the vulnerability as it was.

SBOM::Reference
---------------

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM. Accepts these named arguments:

  * referenceURL `:$url` (required)

The URI (URL or URN) to the external reference. External references are URIs and therefore can accept any URL scheme including https (RFC-7230), mailto (RFC-2368), tel (RFC-3966), and dns (RFC-4501). External references may also include formally registered URNs such as CycloneDX BOM-Link to reference CycloneDX BOMs or any object within a BOM. BOM-Link transforms applicable external references into relationships that can be expressed in a BOM or across BOMs.

  * Str `:$comment`

An optional comment describing the external reference.

  * ReferenceSource `:$type` (required)

Specifies the type of external reference.

  * SBOM::HashedString `:@hashes`

The hashes of the external reference (if applicable).

SBOM::ReleaseNotes
------------------

  * ReleaseLevel `:$type` (required)

The software versioning type the release note describes.

  * Str `:$title`

The title of the release.

  * URL `:$featuredImage`

The URL to an image that may be prominently displayed with the release note.

  * URL `:$socialImage`

The URL to an image that may be used in messaging on social media platforms.

  * Str `:$description`

A short description of the release.

  * DateTime `:$timestamp`

The date and time (timestamp) when the release note was created.

  * Str `:@aliases`

One or more alternate names the release may be referred to. This may include unofficial terms used by development and marketing teams (e.g. code names).

  * Str `:@tags`

Textual strings that aid in discovery, search, and retrieval of the associated object. Tags often serve as a way to group or categorize similar or related objects by various attributes.

  * SBOM::Resolve `:@resolves`

A collection of issues that have been resolved.

  * SBOM::Note `:@notes`

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Requirement
-----------------

A requirement of a standard. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the object elsewhere in the BOM.

  * Str `:$identifier`

The unique identifier used in the standard to identify a specific requirement. This should match what is in the standard and should not be the requirements bom-ref.

  * Str `:$title`

The title of the requirement.

  * Str `:$text`

The textual content of the requirement.

  * Str `:@descriptions`

The supplemental text that provides additional guidance or context to the requirement, but is not directly part of the requirement.

  * CRE `:@openCre`

The Common Requirements Enumeration (CRE) identifier(s).

  * bom-ref `:$parent`

The optional bom-ref to a parent requirement. This establishes a hierarchy of requirements. Top-level requirements must not define a parent. Only child requirements should define parents.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

SBOM::RequirementGrouping
-------------------------

The grouping of requirements to claims and the attestors declared conformance and confidence thereof. Accepts these named arguments:

  * bom-ref `:$requirement`

The bom-ref to the requirement being attested to.

  * bom-ref `:@claims`

The list of bom-ref to the claims being attested to.

  * bom-ref `:@counterClaims`

The list of bom-ref to the counter claims being attested to.

  * SBOM::Conformance `:$conformance`

The conformance of the claim meeting a requirement.

  * SBOM::Confidence `:$confidence`

The confidence of the claim meeting a requirement.

SBOM::RequirementLevel
----------------------

The requirement level of a claim. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the object elsewhere in the BOM.

  * Str `:$identifier`

The identifier used in the standard to identify a specific level.

  * Str `:$title`

The title of the requirement.

  * Str `:$description`

The description of the requirement.

  * bom-ref `:@requirements`

The list of requirement bom-refs that comprise the level.

SBOM::Resolve
-------------

An issue that has been resolved. Accepts these named arguments:

  * ResolveType `:$type` (required)

Specifies the type of issue.

  * Str `:$id`

The identifier of the issue assigned by the source of the issue.

  * Str `:$name`

The name of the issue.

  * Str `:$description`

A description of the issue.

  * SBOM::Source `:$source`

The source of the issue where it is documented.

  * URL `:@references`

A collection of URL's for reference. Multiple URLs are allowed.

SBOM::ResourceReference
-----------------------

A reference to a locally defined resource (e.g., a bom-ref) or an externally accessible resource. Accepts these named arguments:

  * bom-refOrLink `:$ref`

References an object by its bom-ref attribute

  * SBOM::Reference `:$externalReference`

Reference to an externally accessible resource.

SBOM::RuntimeTopology
---------------------

Defines the direct dependencies of a component, service, or the components provided/implemented by a given component. Components or services that do not have their own dependencies must be declared as empty elements within the graph. Components or services that are not represented in the dependency graph may have unknown dependencies. It is recommended that implementations assume this to be opaque and not an indicator of an object being dependency-free. It is recommended to leverage compositions to indicate unknown dependency graphs. Accepts these named arguments:

  * Str `:$ref` (required)

References a component or service by its bom-ref attribute

  * Str `:@dependsOn`

The bom-ref identifiers of the components or services that are dependencies of this dependency object.

  * Str `:@provides`

The bom-ref identifiers of the components or services that define a given specification or standard, which are provided or implemented by this dependency object. For example, a cryptographic library which implements a cryptographic algorithm. A component which implements another component does not imply that the implementation is in use.

SBOM::Service
-------------

A service, which may include microservices, function-as-a-service, and other types of network or intra-process services. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the service elsewhere in the BOM. Every bom-ref must be unique within the BOM.

  * SBOM::Organization `:$provider`

The organization that provides the service.

  * Str `:$group`

The grouping name, namespace, or identifier. This will often be a shortened, single name of the company or project that produced the service or domain name. Whitespace and special characters should be avoided.

  * Str `:$name` (required)

The name of the service. This will often be a shortened, single name of the service.

  * versionString `:$version`

The service version.

  * Str `:$description`

Specifies a description for the service.

  * URL `:@endpoints`

The endpoint URIs of the service.

  * Bool `:$authenticated`

A boolean value indicating if the service requires authentication. A value of true indicates the service requires authentication prior to use. A value of false indicates the service does not require authentication.

  * Bool `:$x-trust-boundary`

A boolean value indicating if use of the service crosses a trust zone or boundary. A value of true indicates that by using the service, a trust boundary is crossed. A value of false indicates that by using the service, a trust boundary is not crossed.

  * Str `:$trustZone`

The name of the trust zone the service resides in.

  * SBOM::ServiceDataset `:@data`

Specifies information about the data including the directional flow of data and the data classification.

  * SBOM::AnyLicense `:@licenses`

EITHER (list of SPDX licenses and/or named licenses) OR (tuple of one SPDX License Expression).

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

  * SBOM::Service `:@services`

A list of services included or deployed behind the parent service. This is not a dependency tree. It provides a way to specify ai hierarchical representation of service assemblies. All items must be unique.

  * SBOM::ReleaseNotes `:$releaseNotes`

Specifies optional release notes.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * Str `:@tags`

Textual strings that aid in discovery, search, and retrieval of the associated object. Tags often serve as a way to group or categorize similar or related objects by various attributes.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::ServiceDataset
--------------------

A dataset associated with a service. Accepts these named arguments:

  * DataFlow `:$flow` (required)

Specifies the flow direction of the data, relative to the service.

  * Str `:$classification` (required)

Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.

  * Str `:$name`

Name for the defined data.

  * Str `:$description`

Short description of the data content and usage.

  * SBOM::Governance `:$governance`

Data governance captures information regarding data ownership, stewardship, and custodianship, providing insights into the individuals or entities responsible for managing, overseeing, and safeguarding the data throughout its lifecycle.

  * Endpoint `:@source`

The URI, URL, or BOM-Link of the components or services the data came in from.

  * Endpoint `:@destination`

The URI, URL, or BOM-Link of the components or services the data is sent to.

SBOM::Signatory
---------------

A signatories authorized on behalf of an organization to assert validity of this document. Accepts these named arguments:

  * Str `:$name`

The signatory's name.

  * Str `:$role`

The signatory's role within an organization.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

  * SBOM::Organization `:$organization`

The signatory's organization.

  * SBOM::Reference `:$externalReference`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

SBOM::Source
------------

Defines a source of documentation, e.g. about vulnerabilities. Accepts these named arguments:

  * URL `:$url`

The url of documentation as provided by the source.

  * Str `:$name`

The name of the source.

SBOM::SourceReference
---------------------

A reference to a source that published a vulnerability. Accepts these named arguments:

  * Str `:$id`

An identifier that uniquely identifies the vulnerability.

  * SBOM::Source `:$source`

The source that published the vulnerability.

SBOM::Standard
--------------

A standard which may consist of regulations, industry or organizational-specific standards, maturity models, best practices, or any other requirements which can be evaluated against or attested to. Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the object elsewhere in the BOM.

  * Str `:$name`

The name of the standard. This will often be a shortened, single name of the standard.

  * Str `:$version`

The version of the standard.

  * Str `:$description`

The description of the standard.

  * Str `:$owner`

The owner of the standard, often the entity responsible for its release.

  * SBOM::Requirement `:@requirements`

The list of requirements comprising the standard.

  * SBOM::RequirementLevel `:@levels`

The list of levels associated with the standard. Some standards have different levels of compliance.

  * SBOM::Reference `:@externalReferences`

External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.

  * SBOM::ValidSignature `:$signature`

Enveloped signature in JSON Signature Format (JSF).

SBOM::SWID
----------

Asserts the identity of the component using ISO-IEC 19770-2 Software Identification (SWID) Tags. Refer to @.evidence.identity to optionally provide evidence that substantiates the assertion of the component's identity. Accepts these named arguments:

  * Str:D `:$tagId` (required)

Maps to the tagId of a SoftwareIdentity.

  * Str:D `:$name` (required)

Maps to the name of a SoftwareIdentity.

  * Str:D `:$version`

Maps to the version of a SoftwareIdentity.

  * Int:D `:@tagVersion`

Maps to the tagVersion of a SoftwareIdentity.

  * Bool:D `:$patch`

Maps to the patch of a SoftwareIdentity.

  * SBOM::Attachment `:$text`

Specifies the metadata and content of the SWID tag.

  * URL `:$url`

The URL to the SWID file.

SBOM::Target
------------

A target against which claims are made. Accepts these named arguments:

  * SBOM::Organization `:@organizations`

The list of organizations which claims are made against.

  * SBOM::Component `:@components`

The list of components which claims are made against.

  * SBOM::Service `:@services`

The list of services which claims are made against.

SBOM::Task
----------

Describes the inputs, sequence of steps and resources used to accomplish a task and its output. Accepts these named arguments:

  * bom-ref `:$bom-ref` (required)

An optional identifier which can be used to reference the task elsewhere in the BOM.

  * Str `:$uid` (required)

The unique identifier for the resource instance within its deployment context.

  * Str `:$name`

The name of the resource instance.

  * Str `:$description`

A description of the resource instance.

  * SBOM::ResourceReference `:@resourceReferences`

References to component or service resources that are used to realize the resource instance.

  * TaskActivity `:@taskTypes` (required)

Indicates the types of activities performed by the set of workflow tasks.

  * SBOM::Trigger `:$trigger`

The trigger that initiated the task.

  * SBOM::ExecutionStep `:@steps`

The sequence of steps for the task.

  * SBOM::Input `:@inputs`

Represents resources and data brought into a task at runtime by executor or task commands.

  * SBOM::Output `:@outputs`

Represents resources and data output from a task at runtime by executor or task commands

  * DateTime `:$timeStart`

The date and time (timestamp) when the task started.

  * DateTime `:$timeEnd`

The date and time (timestamp) when the task ended.

  * SBOM::Workspace `:@workspaces`

A set of named filesystem or data resource shareable by workflow tasks.

  * SBOM::RuntimeTopology `:@runtimeTopology`

A graph of the component runtime topology for task's instance.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Tool
----------

Description of a tool used to identify, confirm, or score a vulnerability. Accepts these named arguments:

  * SBOM::Component `:@components`

A list of software and hardware components used as tools.

  * SBOM::Service `:@services`

A list of services used as tools. This may include microservices, function-as-a-service, and other types of network or intra-process services.

SBOM::Trigger
-------------

The trigger that initiated a task. Accepts these named arguments:

  * bom-ref `:$bom-ref` (required)

An optional identifier which can be used to reference the trigger elsewhere in the BOM.

  * Str `:$uid` (required)

The unique identifier for the resource instance within its deployment context.

  * Str `:$name`

The name of the resource instance.

  * Str `:$description`

A description of the resource instance.

  * SBOM::ResourceReference `:@resourceReferences`

References to component or service resources that are used to realize the resource instance.

  * TriggerEvent `:$type`

The source type of event which caused the trigger to fire.

  * SBOM::Event `:$event`

The event data that caused the associated trigger to activate.

  * SBOM::Condition `:@conditions`

A list of conditions used to determine if a trigger should be activated.

  * DateTime `:$timeActivated`

The date and time (timestamp) when the trigger was activated.

  * SBOM::Input `:@inputs`

Represents resources and data brought into a task at runtime by executor or task commands.

  * SBOM::Output `:@outputs`

Represents resources and data output from a task at runtime by executor or task commands.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Volume
------------

Information about the actual volume instance allocated to the workspace. Accepts these named arguments:

  * Str `:$uid`

The unique identifier for the volume instance within its deployment context.

  * Str `:$name`

The name of the volume instance.

  * VolumeMode `:$mode`

The mode for the volume instance.

  * Str `:$path`

The underlying path created from the actual volume.

  * Str `:$sizeAllocated`

The allocated size of the volume accessible to the associated workspace. This should include the scalar size as well as IEC standard unit in either decimal or binary form.

  * Bool `:$persistent`

Indicates if the volume persists beyond the life of the resource it is associated with.

  * Bool `:$remote`

Indicates if the volume is remotely (i.e., network) attached.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Vulnerability
-------------------

A Vulnerability identified in components or services Accepts these named arguments:

  * bom-ref `:$bom-ref`

An optional identifier which can be used to reference the vulnerability elsewhere in the BOM.

  * Str `:$id`

The identifier that uniquely identifies the vulnerability.

  * SBOM::Source `:$source`

The source that published the vulnerability.

  * SBOM::SourceReference `:@references`

Zero or more pointers to vulnerabilities that are the equivalent of the vulnerability specified. Often times, the same vulnerability may exist in multiple sources of vulnerability intelligence, but have different identifiers. References provide a way to correlate vulnerabilities across multiple sources of vulnerability intelligence.

  * SBOM::Rating `:@ratings`

List of vulnerability ratings.

  * PositiveInt `:@cwes`

List of Common Weaknesses Enumerations (CWEs) codes that describes this vulnerability. For example 399 (of https://cwe.mitre.org/data/definitions/399.html).

  * Str `:$description`

A description of the vulnerability as provided by the source.

  * Str `:$detail`

If available, an in-depth description of the vulnerability as provided by the source organization. Details often include information useful in understanding root cause.

  * Str `:$recommendation`

Recommendations of how the vulnerability can be remediated or mitigated.

  * Str `:$workaround`

A bypass, usually temporary, of the vulnerability that reduces its likelihood and/or impact. Workarounds often involve changes to configuration or deployments.

  * SBOM::ProofOfConcept `:$proofOfConcept`

Evidence used to reproduce the vulnerability.

  * SBOM::Advisory `:@advisories`

Published advisories of the vulnerability if provided.

  * DateTime `:$created`

The date and time (timestamp) when the vulnerability record was created in the vulnerability database.

  * DateTime `:$published`

The date and time (timestamp) when the vulnerability record was first published.

  * DateTime `:$updated`

The date and time (timestamp) when the vulnerability record was last updated.

  * DateTime `:$rejected`

The date and time (timestamp) when the vulnerability record was rejected (if applicable).

  * SBOM::Credits `:$credits`

Individuals or organizations credited with the discovery of the vulnerability.

  * SBOM::Analysis `:$analysis`

An assessment of the impact and exploitability of the vulnerability.

  * SBOM::Affects `:@affects`

The components or services that are affected by the vulnerability.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

  * SBOM::LegacyTool `:@tools`

The legacy tools used to identify, confirm, or score the vulnerability.

  * SBOM::Tool `:$tools`

The tool used to identify, confirm, or score the vulnerability.

SBOM::Workflow
--------------

A specialized orchestration task. Accepts these named arguments:

  * bom-ref `:$bom-ref` (required)

An optional identifier which can be used to reference the workflow elsewhere in the BOM.

  * Str `:$uid` (required)

The unique identifier for the resource instance within its deployment context.

  * Str `:$name`

The name of the resource instance.

  * Str `:$description`

A description of the resource instance.

  * SBOM::ResourceReference `:@resourceReferences`

References to component or service resources that are used toi realize the resource instance.

  * SBOM::Task `:@tasks`

The tasks that comprise the workflow.

  * SBOM::Dependency `:@taskDependencies`

The graph of dependencies between tasks within the workflow.

  * TaskActivity `:@taskTypes`

Indicates the types of activities performed by the set of workflow tasks.

  * SBOM::Trigger `:$trigger`

The trigger that initiated the task.

  * SBOM::ExecutionStep `:@steps`

The sequence of steps for the task.

  * SBOM::Input `:@inputs`

Represents resources and data brought into a task at runtime by executor or task commands.

  * SBOM::Input `:@outputs`

Represents resources and data output from a task at runtime by executor or task commands.

  * DateTime `:$timeStart`

The date and time (timestamp) when the task started.

  * DateTime `:$timeEnd`

The date and time (timestamp) when the task ended.

  * SBOM::Workspace `:@workspaces`

A set of named filesystem or data resource shareable by workflow tasks.

  * SBOM::RuntimeTopology `:@runtimeTopology`

A graph of the component runtime topology for task's instance.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SBOM::Workspace
---------------

A named filesystem or data resource shareable by workflow tasks. Accepts these named arguments:

  * bom-ref `:$bom-ref` (required)

An optional identifier which can be used to reference the workspace elsewhere in the BOM.

  * Str `:$uid` (required)

The unique identifier for the resource instance within its deployment context.

  * Str `:$name`

The name of the resource instance.

  * Str `:@aliases`

The names for the workspace as referenced by other workflow tasks. Effectively, a name mapping so other tasks can use their own local name in their steps.

  * Str `:$description`

A description of the resource instance.

  * SBOM::ResourceReference `:@resourceReferences`

References to component or service resources that are used to realize the resource instance.

  * AccessMode `:$accessMode`

Describes the read-write access Acontrol for the workspace relative to the owning resource instance.

  * Str `:$mountPath`

A path to a location on disk where the workspace will be available to the associated task's steps.

  * Str `:$managedDataType`

The name of a domain-specific data type the workspace represents.

  * Str `:$volumeRequest`

Identifies the reference to the request for a specific volume type and parameters.

  * SBOM::Volume `:$volume`

Information about the actual volume instance allocated to the workspace.

  * SBOM::Property `:@properties`

Any additional properties as name-value pairs.

SUBSETS PROVIDED
================

bom-ref
-------

Identifier which can be used to reference a component in the BOM. Every bom-ref must be unique within the BOM. Must be at least 1 characters long.

bom-refOrLink
-------------

Reference that is either a bom-ref or a bomLinkElement

confidenceValue
---------------

The confidence value between and inclusive of 0 and 1, where 1 is 100% confidence.

conformanceValue
----------------

The conformance value between and inclusive of 0 and 1, where 1 is 100% conformant.

contentHash
-----------

The value of a hash. Must match regular expression: ^([a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64}|[a-fA-F0-9]{96}|[a-fA-F0-9]{128})$.

CPE
---

A CPE must conform to the CPE 2.2 or 2.3 specification. See https://nvd.nist.gov/products/cpe.

CRE
---

A Common Requirements Enumeration (CRE) identifier. CRE is a structured and standardized framework for uniting security standards and guidelines. CRE links each section of a resource to a shared topic identifier (a Common Requirement). Through this shared topic link, all resources map to each other. Use of CRE promotes clear and unambiguous communication among stakeholders.

email
-----

An email address.

Endpoint
--------

An endpoint for a source or destination of data.

IDnotbomLink
------------

Identifier for referable and therefore interlinkable elements. Value SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts |with BOM-Links.

locale
------

The ISO-639 (or higher) language code and optional ISO-3166 (or higher) country code. Examples include: "en", "en-US", "fr" and "fr-CA". Must match regular expression: ^([a-z]{2})(-[A-Z]{2})?$.

mime-type
---------

A MIME-type. Must match regular expression: ^[-+a-z0-9.]+/[-+a-z0-9.]+$

nistQuantumSecurityLevel
------------------------

The NIST security strength category as defined in https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria). A value of 0 indicates that none of the categories are met.

number
------

A numeric value.

omniborId
---------

An OmniBOR Artifact ID. The OmniBOR, if specified, must be valid and conform to the specification defined at: https://www.iana.org/assignments/uri-schemes/prov/gitoid.

PositiveInt
-----------

A positive integer value (> 0).

propertyName
------------

A reference to the property name as defined in the CycloneDX Property Taxonomy.

PURL
----

A package-url (purl). The purl, if specified, must be valid and conform to the specification defined at: https://github.com/package-url/purl-spec.

referenceURL
------------

Either a URL, a bomLinkDocument or a bomLinkElement.

serialNumber
------------

Every BOM generated SHOULD have a unique serial number, even if the contents of the BOM have not changed over time. If specified, the serial number must conform to RFC 4122. Use of serial numbers is recommended. Must match regular expression: ^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$

SWHID
-----

A Software Heritage persistent identifier (SWHID). The SWHID, if specified, must be valid and conform to the specification defined at: https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.

UInt
----

An unsigned integer value (>= 0)

URL
---

A URL.

versionRange
------------

A version range specified in Package URL Version Range syntax (vers) which is defined at https://github.com/package-url/purl-spec/blob/master/VERSION-RANGE-SPEC.rst

versionString
-------------

A version should ideally comply with semantic versioning but is not enforced. Must be at most 1024 characters long.

SUBSETS API
===========

ENUMS PROVIDED
==============

AccessMode
----------

Describes the read-write access control for a workspace relative to the owning resource instance.

Supported strings:

  * read-only

  * read-write

  * read-write-once

  * write-once

  * write-only

Acknowledgement
---------------

Declared licenses and concluded licenses represent two different stages in the licensing process within software development. Declared licenses refer to the initial intention of the software authors regarding the licensing terms under which their code is released. On the other hand, concluded licenses are the result of a comprehensive analysis of the project's codebase to identify and confirm the actual licenses of the components used, which may differ from the initially declared licenses. While declared licenses provide an upfront indication of the licensing intentions, concluded licenses offer a more thorough understanding of the actual licensing within a project, facilitating proper compliance and risk management. Observed licenses are defined in @.evidence.licenses. Observed licenses form the evidence necessary to substantiate a concluded license.

Supported strings:

  * concluded

  * declared

Activity
--------

The type of activity that is part of a machine learning model development or operational lifecycle.

Supported strings:

  * data-collection

  * data-preparation

  * deployment

  * design

  * fine-tuning

  * inference

  * other

  * training

  * validation

Aggregate
---------

Specifies an aggregate type that describes how complete a relationship is.

Supported strings:

  * complete

  * incomplete

  * incomplete_first_party_only

  * incomplete_first_party_opensource_only

  * incomplete_first_party_proprietary_only

  * incomplete_third_party_only

  * incomplete_third_party_opensource_only

  * incomplete_third_party_proprietary_only

  * not_specified

  * unknown

AlgorithmPrimitive
------------------

Cryptographic building blocks used in higher-level cryptographic systems and protocols. Primitives represent different cryptographic routines: deterministic random bit generators (drbg, e.g. CTR_DRBG from NIST SP800-90A-r1), message authentication codes (mac, e.g. HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20), signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key encryption schemes (pke, e.g. RSA), extended output functions (xof, e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM), authenticated encryption (ae, e.g. AES-GCM) and the combination of multiple algorithms (combiner, e.g. SP800-56Cr2).

Supported strings:

  * ae

  * block-cipher

  * combiner

  * drbg

  * hash

  * kdf

  * kem

  * key-agree

  * mac

  * other

  * pke

  * signature

  * stream-cipher

  * unknown

  * xof

BOMFormat
---------

Specifies the format of the BOM. This helps to identify the file as CycloneDX since BOMs do not have a filename convention, nor does JSON schema support namespaces.

Supported strings:

  * CycloneDX

CO2Cost
-------

Unit of CO2 cost.

Supported strings:

  * tCO2eq

Certification
-------------

The certification that an implementation of a cryptographic algorithm has received. Certifications include revisions and levels of FIPS 140 or Common Criteria of different Extended Assurance Levels (CC-EAL).

Supported strings:

  * cc-eal1

  * cc-eal1+

  * cc-eal2

  * cc-eal2+

  * cc-eal3

  * cc-eal3+

  * cc-eal4

  * cc-eal4+

  * cc-eal5

  * cc-eal5+

  * cc-eal6

  * cc-eal6+

  * cc-eal7

  * cc-eal7+

  * fips140-1-l1

  * fips140-1-l2

  * fips140-1-l3

  * fips140-1-l4

  * fips140-2-l1

  * fips140-2-l2

  * fips140-2-l3

  * fips140-2-l4

  * fips140-3-l1

  * fips140-3-l2

  * fips140-3-l3

  * fips140-3-l4

  * none

  * other

  * unknown

CertificationMode
-----------------

The mode of operation in which a cryptographic algorithm (block cipher) is used.

Supported strings:

  * cbc

  * ccm

  * cfb

  * ctr

  * ecb

  * gcm

  * ofb

  * other

  * unknown

CertificationPadding
--------------------

The padding scheme that is used for a cryptographic algorithm.

Supported strings:

  * oaep

  * other

  * pkcs1v15

  * pkcs5

  * pkcs7

  * raw

  * unknown

ComponentType
-------------

Specifies the type of a component.

Supported strings:

  * application

  * container

  * cryptographic-asset

  * data

  * device

  * device-driver

  * file

  * firmware

  * framework

  * library

  * machine-learning-model

  * operating-system

  * platform

Crypto
------

The type for the related cryptographic material.

Supported strings:

  * additional-data

  * ciphertext

  * credential

  * digest

  * initialization-vector

  * key

  * nonce

  * other

  * password

  * private-key

  * public-key

  * salt

  * secret-key

  * seed

  * shared-secret

  * signature

  * tag

  * token

  * unknown

CryptoAsset
-----------

Cryptographic assets occur in several forms. Algorithms and protocols are most commonly implemented in specialized cryptographic libraries. They may, however, also be 'hardcoded' in software components. Certificates and related cryptographic material like keys, tokens, secrets or passwords are other cryptographic assets to be modelled.

Supported strings:

  * algorithm

  * certificate

  * protocol

  * related-crypto-material

CryptoFunction
--------------

A cryptographic function implemented by a cryptographic algorithm.

Supported strings:

  * decapsulate

  * decrypt

  * digest

  * encapsulate

  * encrypt

  * generate

  * keyderive

  * keygen

  * other

  * sign

  * tag

  * unknown

  * verify

CryptoKey
---------

Public key type indicator.

Supported strings:

  * EC

  * OKP

  * RSA

CryptoProtocol
--------------

A concrete cryptographic protocol type.

Supported strings:

  * ike

  * ipsec

  * other

  * ssh

  * sstp

  * tls

  * unknown

  * wpa

CryptoState
-----------

The key state as defined by NIST SP 800-57.

Supported strings:

  * active

  * compromised

  * deactivated

  * destroyed

  * pre-activation

  * suspended

DataFlow
--------

Specifies information about the directional flow of data.

Supported strings:

  * bi-directional

  * inbound

  * outbound

  * unknown

DataSource
----------

The general theme or subject matter of model data being specified.

Supported strings:

  * configuration

  * dataset

  * definition

  * other

  * source-code

ECCurve
-------

EC curve name.

Supported strings:

  * P-256

  * P-384

  * P-521

EdDSA
-----

EdDSA curve name.

Supported strings:

  * Ed25519

  * Ed448

Encoding
--------

Specifies the optional encoding a text is represented in.

Supported strings:

  * base64

Energy
------

The energy source of an energy provider.

Supported strings:

  * biofuel

  * coal

  * geothermal

  * hydropower

  * natural-gas

  * nuclear

  * oil

  * other

  * solar

  * unknown

  * wind

EnergyUnit
----------

Unit of energy.

Supported strings:

  * kWh

Evidence
--------

A technique used in method of analysis.

Supported strings:

  * ast-fingerprint

  * attestation

  * binary-analysis

  * dynamic-analysis

  * filename

  * hash-comparison

  * instrumentation

  * manifest-analysis

  * other

  * source-code-analysis

ExecutionEnvironment
--------------------

The target and execution environment in which an algorithm is implemented in.

Supported strings:

  * hardware

  * other

  * software-encrypted-ram

  * software-plain-ram

  * software-tee

  * unknown

Field
-----

The identity field of the component which an evidence describes.

Supported strings:

  * cpe

  * group

  * hash

  * name

  * omniborId

  * purl

  * swhid

  * swid

  * version

HashAlgorithm
-------------

An algorithm to generate a hash value with.

Supported strings:

  * BLAKE2b-256

  * BLAKE2b-384

  * BLAKE2b-512

  * BLAKE3

  * MD5

  * SHA-1

  * SHA-256

  * SHA-384

  * SHA-512

  * SHA3-256

  * SHA3-384

  * SHA3-512

Justification
-------------

The rationale of why the impact analysis state was asserted.

Supported strings:

  * code_not_present

  * code_not_reachable

  * protected_at_perimeter

  * protected_at_runtime

  * protected_by_compiler

  * protected_by_mitigating_control

  * requires_configuration

  * requires_dependency

  * requires_environment

Learning
--------

Learning types describing the learning problem or hybrid learning problem.

Supported strings:

  * reinforcement-learning

  * self-supervised

  * semi-supervised

  * supervised

  * unsupervised

LicenseGranted
--------------

A type of license that was granted to the licensee.

Supported strings:

  * academic

  * appliance

  * client-access

  * concurrent-user

  * core-points

  * custom-metric

  * device

  * evaluation

  * named-user

  * node-locked

  * oem

  * other

  * perpetual

  * processor-points

  * subscription

  * user

LicenseId
---------

A valid SPDX license identifier.

699 strings supported.

LicenseName
-----------

A valid SPDX license name.

686 strings supported.

OutputType
----------

Describes the type of data output.

Supported strings:

  * artifact

  * attestation

  * evidence

  * log

  * metrics

  * other

Patch
-----

Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.

Supported strings:

  * backport

  * cherry-pick

  * monkey

  * unofficial

Phase
-----

Lifecycles communicate the stage(s) in which data in the BOM was captured. Different types of data may be available at various phases of a lifecycle, such as the Software Development Lifecycle (SDLC), IT Asset Management (ITAM), and Software Asset Management (SAM). Thus, a BOM may include data specific to or only obtainable in a given lifecycle.

Supported strings:

  * build

  * decommision

  * design

  * discovery

  * operations

  * post-build

  * pre-build

Platform
--------

A platform for which an algorithm is implemented.

Supported strings:

  * armv7-a

  * armv7-m

  * armv8-a

  * armv8-m

  * armv9-a

  * armv9-m

  * generic

  * other

  * ppc64

  * ppc64le

  * s390x

  * unknown

  * x86_32

  * x86_64

ReferenceSource
---------------

Specifies the type of external reference.

Supported strings:

  * adversary-model

  * advisories

  * attestation

  * bom

  * build-meta

  * build-system

  * certification-report

  * chat

  * codified-infrastructure

  * component-analysis-report

  * configuration

  * digital-signature

  * distribution

  * distribution-intake

  * documentation

  * dynamic-analysis-report

  * electronic-signature

  * evidence

  * exploitability-statement

  * formulation

  * issue-tracker

  * license

  * log

  * mailing-list

  * maturity-report

  * model-card

  * other

  * pentest-report

  * poam

  * quality-metrics

  * release-notes

  * rfc-9116

  * risk-assessment

  * runtime-analysis-report

  * security-contact

  * social

  * source-distribution

  * static-analysis-report

  * support

  * threat-model

  * vcs

  * vulnerability-assertion

  * website

ReleaseLevel
------------

The software versioning type of a release note.

Supported strings:

  * internal

  * major

  * minor

  * patch

  * pre-release

ResolveType
-----------

A type of issue resolvement.

Supported strings:

  * defect

  * enhancement

  * security

Response
--------

A response to the vulnerability by the manufacturer, supplier, or project responsible for the affected component or service. Responses are strongly encouraged for vulnerabilities where the analysis state is exploitable.

Supported strings:

  * can_not_fix

  * rollback

  * update

  * will_not_fix

  * workaround_available

RiskMethodology
---------------

Specifies the severity or risk scoring methodology or standard used.

Supported strings:

  * CVSSv2

  * CVSSv3

  * CVSSv31

  * CVSSv4

  * OWASP

  * SSVC

  * other

Scope
-----

The scope of a component.

Supported strings:

  * excluded

  * optional

  * required

Severity
--------

Textual representation of a severity.

Supported strings:

  * critical

  * high

  * info

  * low

  * medium

  * none

  * unknown

SignatureAlgorithm
------------------

Signature algorithm. The currently recognized JWA [RFC7518] and RFC8037 [RFC8037] asymmetric key algorithms. Unlike RFC8037 [RFC8037] JSF requires explicit Ed* algorithm names instead ofi "EdDSA".

Supported strings:

  * ES256

  * ES384

  * ES512

  * Ed25519

  * Ed448

  * HS256

  * HS384

  * HS512

  * PS256

  * PS384

  * PS512

  * RS256

  * RS384

  * RS512

TaskActivity
------------

Indicates the types of activities performed by the set of workflow tasks.

Supported strings:

  * build

  * clean

  * clone

  * copy

  * deliver

  * deploy

  * lint

  * merge

  * other

  * release

  * scan

  * test

TriggerEvent
------------

The source type of event which caused a trigger to fire.

Supported strings:

  * api

  * manual

  * scheduled

  * webhook

VersionAffection
----------------

The vulnerability status for the version or range of versions.

Supported strings:

  * affected

  * unaffected

  * unknown

VolumeMode
----------

The mode for a volume instance.

Supported strings:

  * block

  * filesystem

VulnerabilityState
------------------

Declares the current state of an occurrence of a vulnerability, after automated or manual analysis.

Supported strings:

  * exploitable

  * false_positive

  * in_triage

  * not_affected

  * resolved

  * resolved_with_pedigree

ENUMS API
=========

The `SBOM::enums` module provides a number of functional enum values. Note however that these are **NOT** enums in the pure Raku sense, but Raku classes doing the `Enumify` role. This to allow for an easy check to see whether a given string is allowed for the given "enum".

```raku
use SBOM::enums;  # import *all* enum classes

say ComponentType<application>;  # ComponentType("application")
say ComponentType<foo>;          # Nil

say ComponentType{$name};
```

One can check for the validity of a string for the given enum class by considering it an `Associative`.

```raku
use SBOM::enums <DataFlow>;  # Just import DataFlow enum

say DataFlow.WHY;           # Specifies information about the...
say DataFlow<inbound>.WHY;  # Data that enters a service.
```

If only interested in one or more enum classes, then these can be specified as positional arguments in the `use` statement. If one wants to know what a specific enum class is about, one can call the `WHY` method on it, either on an enum instance (to get information about that particular enum), or on the whole enum class (when called on the enum type).

```raku
use SBOM::enums <DataFlow>;  # Just import DataFlow enum

say DataFlow.keys;  # (bi-directional inbound outbound unknown)
```

The `keys` method can be called on the type object of an enum class to get a sorted list of allowable strings.

```raku
use SBOM::enums <Enumify>;  # Just import Enumify role

say Enumify.keys;   # (AccessMode Acknowledgement Activity...
```

The `keys` method can also be called on the underlying `Enumify` role to obtain a sorted list of the names of all classes of enums available.

THANKS
======

This module wouldn't exist without the nudging and support of *Salve J. Nilsen*.

CREDITS
=======

The SBOM test files in the `t/valid` directory were taken from [Giuseppe Di Terlizzi's SBOM::CycloneDX repository](https://github.com/giterlizzi/perl-SBOM-CycloneDX/).

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

