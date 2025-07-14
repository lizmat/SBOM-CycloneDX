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

SBOM::CycloneDX
---------------

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

```raku
use SBOM::subsets <serialNumber>;

my $serial = "urn:uuid:3e671687-395b-41f5-a30f-a58921a69b79";
say "valid" if $serial ~~ serialNumber;  # valid
```

The subsets are provided by the `SBOM::subsets` module. Either all possible subsets are imported, or just the ones specifed in the `use` statement.

To get information about a `subset` you can call the `.WHY` method:

```raku
use SBOM::subsets <email>;

say email.WHY;  # An email address.
```

The provided information may of course be more or less verbose.

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

The type for the related cryptographic material

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

CREDITS
=======

The SBOM test files in the `t/valid` directory were taken from [Giuseppe Di Terlizzi's SBOM::CycloneDX repoository](https://github.com/giterlizzi/perl-SBOM-CycloneDX/).

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

