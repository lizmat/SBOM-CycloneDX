[![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions) [![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions) [![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions)

NAME
====

SBOM::CycloneDX - Software Bill Of Materials, CycloneDX style

SYNOPSIS
========

```raku
use SBOM::CycloneDX;
```

DESCRIPTION
===========

`SBOM::CycloneDX` provides a distribution for the implementation of the Software Bill Of Materials standard provided by CycloneDX using the [JSON Reference version 1.6](https://cyclonedx.org/docs/1.6/json/).

This is still alpha state, but all necessary classes are currently implemented. But no way to ingest any JSON generated data yet.

PRELIMINARY STRUCTURE DEFINITION
================================

    CycloneDX
    - serialNumber $serialNumber ----------------------------------
      Every BOM generated SHOULD have a unique serial number,
      even if the contents of the BOM have not changed over
      time. If specified, the serial number must conform to RFC
      4122. Use of serial numbers is recommended.

    - Int $version ------------------------------------------------
      Whenever an existing BOM is modified, either manually or
      through automated processes, the version of the BOM SHOULD
      be incremented by 1. When a system is presented with
      multiple BOMs with identical serial numbers, the system
      SHOULD use the most recent version of the BOM. The default
      version is '1'.

    - Metadata $metadata ------------------------------------------
      Provides additional information about a BOM.

        DateTime $timestamp
        The date and time (timestamp) when the BOM was created.

        Phase @lifecycles
        Lifecycles communicate the stage(s) in which data in
        the BOM was captured. Different types of data may be
        available at various phases of a lifecycle, such as the
        Software Development Lifecycle (SDLC), IT Asset
        Management (ITAM), and Software Asset Management (SAM).
        Thus, a BOM may include data specific to or only
        obtainable in a given lifecycle.

        AnyTool $tools
        The tool(s) used in the creation, enrichment, and
        validation of the BOM.

        Organization $manufacturer
        The organization that created the BOM. Manufacturer is
        common in BOMs created through automated processes. BOMs
        created through manual means may have @.authors instead.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the object elsewhere in the BOM.

          Str $name
          The name of the organization.

          Address $address
          The physical address (location) of the organization.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the address elsewhere in the BOM.

            Str $country
            The country name or the two-letter ISO 3166-1
            country code.

            Str $region
            The region or state in the country.

            Str $locality
            The locality or city within the country.

            Str $postOfficeBoxNumber
            The post office box number.

            Str $postalCode
            The postal code.

            Str $streetAddress
            The street address.

          URL @url
          The URL of the organization. Multiple URLs are
          allowed.

          Contact @contact
          A contact at the organization. Multiple contacts are
          allowed.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the person elsewhere in the BOM.

            Str $name
            The name of a contact.

            email $email
            The email address of the contact.

            Str $phone
            The phone number of the contact.

        Contact @authors
        The person(s) who created the BOM. Authors are common
        in BOMs created through manual processes. BOMs created
        through automated means may have @.manufacturer instead.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the person elsewhere in the BOM.

          Str $name
          The name of a contact.

          email $email
          The email address of the contact.

          Str $phone
          The phone number of the contact.

        Component $component
        The component that the BOM describes.

          ComponentType $type (required)
          Specifies the type of the component. For software
          components, classify as application if no more
          specific appropriate classification is available or
          cannot be determined for the component.

          mime-type $mime-type
          The optional mime-type of the component. When used on
          file components, the mime-type can provide additional
          context about the kind of file being represented, such
          as an image, font, or executable. Some library or
          framework components may also have an associated
          mime-type.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the component elsewhere in the BOM. Every bom-ref must
          be unique within the BOM. Value SHOULD not start with
          the BOM-Link intro 'urn:cdx:' to avoid conflicts with
          BOM-Links.

          Organization $supplier
          The organization that supplied the component. The
          supplier may often be the manufacturer, but may also
          be a distributor or repackager.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the object elsewhere in the BOM.

            Str $name
            The name of the organization.

            Address $address
            The physical address (location) of the
            organization.

            URL @url
            The URL of the organization. Multiple URLs are
            allowed.

            Contact @contact
            A contact at the organization. Multiple contacts
            are allowed.

          Organization $manufacturer
          The organization that created the component.
          Manufacturer is common in components created through
          automated processes. Components created through manual
          means may have @.authors instead.

          Contact @authors
          The person(s) who created the component. Authors are
          common in components created through manual processes.
          Components created through automated means may have
          @.manufacturer instead.

          Str $publisher
          The person(s) or organization(s) that published the
          component.

          Str $group
          The grouping name or identifier. This will often be a
          shortened, single name of the company or project that
          produced the component, or the source package or
          domain name. Whitespace and special characters should
          be avoided. Examples include: apache,
          org.apache.commons, and apache.org.

          Str $name (required)
          The name of the component. This will often be a
          shortened, single name of the component. Examples:
          commons-lang3 and jquery.

          versionString $version
          The component version. The version should ideally
          comply with semantic versioning but is not enforced.

          Str $description
          Specifies a description for the component

          Scope $scope
          Specifies the scope of the component. If scope is not
          specified, 'required' scope SHOULD be assumed by the
          consumer of the BOM.

          HashedString @hashes
          The hashes of the component.

            HashAlgorithm $alg (required)
            The algorithm that generated the hash value.

            contentHash $content (required)
            The value of the hash.

          AnyLicense @licenses
          EITHER (list of SPDX licenses and/or named licenses)
          OR (tuple of one SPDX License Expression)

          Str $copyright
          A copyright notice informing users of the underlying
          claims to copyright ownership in a published work.

          CPE $cpe
          Asserts the identity of the component using CPE. The
          CPE must conform to the CPE 2.2 or 2.3 specification.
          See https://nvd.nist.gov/products/cpe. Refer to
          @.evidence.identity to optionally provide evidence
          that substantiates the assertion of the component's
          identity.

          PURL $purl
          Asserts the identity of the component using
          package-url (purl). The purl, if specified, must be
          valid and conform to the specification defined at:
          https://github.com/package-url/purl-spec. Refer to
          @.evidence.identity to optionally provide evidence
          that substantiates the assertion of the component's
          identity.

          omniborId @omniborId
          Asserts the identity of the component using the
          OmniBOR Artifact ID. The OmniBOR, if specified, must
          be valid and conform to the specification defined at:
          https://www.iana.org/assignments/uri-schemes/prov/gitoid.
          Refer to @.evidence.identity to optionally provide
          evidence that substantiates the assertion of the
          component's identity.

          SWHID @swhid
          Asserts the identity of the component using the
          Software Heritage persistent identifier (SWHID). The
          SWHID, if specified, must be valid and conform to the
          specification defined at:
          https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
          Refer to @.evidence.identity to optionally provide
          evidence that substantiates the assertion of the
          component's identity.

          SWID $swid
          Asserts the identity of the component using ISO-IEC
          19770-2 Software Identification (SWID) Tags. Refer to
          @.evidence.identity to optionally provide evidence
          that substantiates the assertion of the component's
          identity.

            Str:D $tagID (required)
            Maps to the tagId of a SoftwareIdentity.

            Str:D $name (required)
            Maps to the name of a SoftwareIdentity.

            Str:D $version
            Maps to the version of a SoftwareIdentity.

            Int:D @tagVersion
            Maps to the tagVersion of a SoftwareIdentity.

            Bool:D $patch
            Maps to the patch of a SoftwareIdentity.

            Attachment $text
            Specifies the metadata and content of the SWID tag.

              mime-type $contentType
              Specifies the format and nature of the data being
              attached, helping systems correctly interpret and
              process the content. Common content type examples
              include application/json for JSON data and
              text/plain for plan text documents.

              Encoding $encoding
              Specifies the optional encoding the text is
              represented in.

              Str $content (required)
              The attachment data. Proactive controls such as
              input validation and sanitization should be
              employed to prevent misuse of attachment text.

            URL $url
            The URL to the SWID file.

          Bool $modified
          [Deprecated] This will be removed in a future
          version. Use the pedigree element instead to supply
          information on exactly how the component was modified.
          A boolean value indicating if the component has been
          modified from the original. A value of true indicates
          the component is a derivative of the original. A value
          of false indicates the component has not been modified
          from the original.

          Pedigree $pedigree
          Component pedigree is a way to document complex
          supply chain scenarios where components are created,
          distributed, modified, redistributed, combined with
          other components, etc. Pedigree supports viewing this
          complex chain from the beginning, the end, or anywhere
          in the middle. It also provides a way to document
          variants where the exact relation may not be known.

            Component @ancestors
            Describes zero or more components in which a
            component is derived from. This is commonly used to
            describe forks from existing projects where the
            forked version contains a ancestor node containing
            the original component it was forked from. For
            example, Component A is the original component.
            Component B is the component being used and
            documented in the BOM. However, Component B contains
            a pedigree node with a single ancestor documenting
            Component A - the original component from which
            Component B is derived from.

              ComponentType $type (required)
              Specifies the type of the component. For software
              components, classify as application if no more
              specific appropriate classification is available
              or cannot be determined for the component.

              mime-type $mime-type
              The optional mime-type of the component. When
              used on file components, the mime-type can provide
              additional context about the kind of file being
              represented, such as an image, font, or
              executable. Some library or framework components
              may also have an associated mime-type.

              bom-ref $bom-ref
              An optional identifier which can be used to
              reference the component elsewhere in the BOM.
              Every bom-ref must be unique within the BOM. Value
              SHOULD not start with the BOM-Link intro
              'urn:cdx:' to avoid conflicts with BOM-Links.

              Organization $supplier
              The organization that supplied the component. The
              supplier may often be the manufacturer, but may
              also be a distributor or repackager.

              Organization $manufacturer
              The organization that created the component.
              Manufacturer is common in components created
              through automated processes. Components created
              through manual means may have @.authors instead.

              Contact @authors
              The person(s) who created the component. Authors
              are common in components created through manual
              processes. Components created through automated
              means may have @.manufacturer instead.

              Str $publisher
              The person(s) or organization(s) that published
              the component.

              Str $group
              The grouping name or identifier. This will often
              be a shortened, single name of the company or
              project that produced the component, or the source
              package or domain name. Whitespace and special
              characters should be avoided. Examples include:
              apache, org.apache.commons, and apache.org.

              Str $name (required)
              The name of the component. This will often be a
              shortened, single name of the component. Examples:
              commons-lang3 and jquery.

              versionString $version
              The component version. The version should ideally
              comply with semantic versioning but is not
              enforced.

              Str $description
              Specifies a description for the component

              Scope $scope
              Specifies the scope of the component. If scope is
              not specified, 'required' scope SHOULD be assumed
              by the consumer of the BOM.

              HashedString @hashes
              The hashes of the component.

              AnyLicense @licenses
              EITHER (list of SPDX licenses and/or named
              licenses) OR (tuple of one SPDX License
              Expression)

              Str $copyright
              A copyright notice informing users of the
              underlying claims to copyright ownership in a
              published work.

              CPE $cpe
              Asserts the identity of the component using CPE.
              The CPE must conform to the CPE 2.2 or 2.3
              specification. See
              https://nvd.nist.gov/products/cpe. Refer to
              @.evidence.identity to optionally provide evidence
              that substantiates the assertion of the
              component's identity.

              PURL $purl
              Asserts the identity of the component using
              package-url (purl). The purl, if specified, must
              be valid and conform to the specification defined
              at: https://github.com/package-url/purl-spec.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              omniborId @omniborId
              Asserts the identity of the component using the
              OmniBOR Artifact ID. The OmniBOR, if specified,
              must be valid and conform to the specification
              defined at:
              https://www.iana.org/assignments/uri-schemes/prov/gitoid.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              SWHID @swhid
              Asserts the identity of the component using the
              Software Heritage persistent identifier (SWHID).
              The SWHID, if specified, must be valid and conform
              to the specification defined at:
              https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              SWID $swid
              Asserts the identity of the component using
              ISO-IEC 19770-2 Software Identification (SWID)
              Tags. Refer to @.evidence.identity to optionally
              provide evidence that substantiates the assertion
              of the component's identity.

              Bool $modified
              [Deprecated] This will be removed in a future
              version. Use the pedigree element instead to
              supply information on exactly how the component
              was modified. A boolean value indicating if the
              component has been modified from the original. A
              value of true indicates the component is a
              derivative of the original. A value of false
              indicates the component has not been modified from
              the original.

              Pedigree $pedigree
              Component pedigree is a way to document complex
              supply chain scenarios where components are
              created, distributed, modified, redistributed,
              combined with other components, etc. Pedigree
              supports viewing this complex chain from the
              beginning, the end, or anywhere in the middle. It
              also provides a way to document variants where the
              exact relation may not be known.

              Reference @externalReferences
              External references provide a way to document
              systems, sites, and information that may be
              relevant but are not included with the BOM. They
              may also establish specific relationships within
              or external to the BOM.

                referenceURL $url (required)
                The URI (URL or URN) to the external reference.
                External references are URIs and therefore can
                accept any URL scheme including https
                (RFC-7230), mailto (RFC-2368), tel (RFC-3966),
                and dns (RFC-4501). External references may also
                include formally registered URNs such as
                CycloneDX BOM-Link to reference CycloneDX BOMs
                or any object within a BOM. BOM-Link transforms
                applicable external references into
                relationships that can be expressed in a BOM or
                across BOMs.

                Str $comment
                An optional comment describing the external
                reference.

                ReferenceSource $type (required)
                Specifies the type of external reference.

                HashedString @hashes
                The hashes of the external reference (if
                applicable).

              Component @components
              A list of software and hardware components
              included in the parent component. This is not a
              dependency tree. It provides a way to specify a
              hierarchical representation of component
              assemblies, similar to system → subsystem → parts
              assembly in physical supply chains.

                ComponentType $type (required)
                Specifies the type of the component. For
                software components, classify as application if
                no more specific appropriate classification is
                available or cannot be determined for the
                component.

                mime-type $mime-type
                The optional mime-type of the component. When
                used on file components, the mime-type can
                provide additional context about the kind of
                file being represented, such as an image, font,
                or executable. Some library or framework
                components may also have an associated
                mime-type.

                bom-ref $bom-ref
                An optional identifier which can be used to
                reference the component elsewhere in the BOM.
                Every bom-ref must be unique within the BOM.
                Value SHOULD not start with the BOM-Link intro
                'urn:cdx:' to avoid conflicts with BOM-Links.

                Organization $supplier
                The organization that supplied the component.
                The supplier may often be the manufacturer, but
                may also be a distributor or repackager.

                Organization $manufacturer
                The organization that created the component.
                Manufacturer is common in components created
                through automated processes. Components created
                through manual means may have @.authors instead.

                Contact @authors
                The person(s) who created the component.
                Authors are common in components created through
                manual processes. Components created through
                automated means may have @.manufacturer instead.

                Str $publisher
                The person(s) or organization(s) that published
                the component.

                Str $group
                The grouping name or identifier. This will
                often be a shortened, single name of the company
                or project that produced the component, or the
                source package or domain name. Whitespace and
                special characters should be avoided. Examples
                include: apache, org.apache.commons, and
                apache.org.

                Str $name (required)
                The name of the component. This will often be a
                shortened, single name of the component.
                Examples: commons-lang3 and jquery.

                versionString $version
                The component version. The version should
                ideally comply with semantic versioning but is
                not enforced.

                Str $description
                Specifies a description for the component

                Scope $scope
                Specifies the scope of the component. If scope
                is not specified, 'required' scope SHOULD be
                assumed by the consumer of the BOM.

                HashedString @hashes
                The hashes of the component.

                AnyLicense @licenses
                EITHER (list of SPDX licenses and/or named
                licenses) OR (tuple of one SPDX License
                Expression)

                Str $copyright
                A copyright notice informing users of the
                underlying claims to copyright ownership in a
                published work.

                CPE $cpe
                Asserts the identity of the component using
                CPE. The CPE must conform to the CPE 2.2 or 2.3
                specification. See
                https://nvd.nist.gov/products/cpe. Refer to
                @.evidence.identity to optionally provide
                evidence that substantiates the assertion of the
                component's identity.

                PURL $purl
                Asserts the identity of the component using
                package-url (purl). The purl, if specified, must
                be valid and conform to the specification
                defined at:
                https://github.com/package-url/purl-spec. Refer
                to @.evidence.identity to optionally provide
                evidence that substantiates the assertion of the
                component's identity.

                omniborId @omniborId
                Asserts the identity of the component using the
                OmniBOR Artifact ID. The OmniBOR, if specified,
                must be valid and conform to the specification
                defined at:
                https://www.iana.org/assignments/uri-schemes/prov/gitoid.
                Refer to @.evidence.identity to optionally
                provide evidence that substantiates the
                assertion of the component's identity.

                SWHID @swhid
                Asserts the identity of the component using the
                Software Heritage persistent identifier (SWHID).
                The SWHID, if specified, must be valid and
                conform to the specification defined at:
                https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
                Refer to @.evidence.identity to optionally
                provide evidence that substantiates the
                assertion of the component's identity.

                SWID $swid
                Asserts the identity of the component using
                ISO-IEC 19770-2 Software Identification (SWID)
                Tags. Refer to @.evidence.identity to optionally
                provide evidence that substantiates the
                assertion of the component's identity.

                Bool $modified
                [Deprecated] This will be removed in a future
                version. Use the pedigree element instead to
                supply information on exactly how the component
                was modified. A boolean value indicating if the
                component has been modified from the original. A
                value of true indicates the component is a
                derivative of the original. A value of false
                indicates the component has not been modified
                from the original.

                Pedigree $pedigree
                Component pedigree is a way to document complex
                supply chain scenarios where components are
                created, distributed, modified, redistributed,
                combined with other components, etc. Pedigree
                supports viewing this complex chain from the
                beginning, the end, or anywhere in the middle.
                It also provides a way to document variants
                where the exact relation may not be known.

                Reference @externalReferences
                External references provide a way to document
                systems, sites, and information that may be
                relevant but are not included with the BOM. They
                may also establish specific relationships within
                or external to the BOM.

                Component @components
                A list of software and hardware components
                included in the parent component. This is not a
                dependency tree. It provides a way to specify a
                hierarchical representation of component
                assemblies, similar to system → subsystem →
                parts assembly in physical supply chains.

                ComponentEvidence $evidence
                Provides the ability to document evidence
                collected through various forms of extraction or
                analysis.

                  Identity $identity
                  Evidence that substantiates the identity of a
                  component.

                  Occurrence @occurrences
                  Evidence of individual instances of a
                  component spread across multiple locations.

                    bom-ref $bom-ref
                    An optional identifier which can be used to
                    reference the occurrence elsewhere in the
                    BOM

                    Str $location (required)
                    The location or path to where the component
                    was found.

                    PositiveInt $line
                    The line number where the component was
                    found.

                    PositiveInt $offset
                    The offset where the component was found.

                    Str $symbol
                    The symbol name that was found associated
                    with the component.

                    Str $additionalContext
                    Any additional context of the detected
                    component (e.g. a code snippet).

                  Callstack $callstack
                  Evidence of the components use through the
                  callstack.

                    Frame @frames
                    The frames seen in the callstack.

                      Str $package
                      A package organizes modules into
                      namespaces, providing a unique namespace
                      for each type it contains.

                      Str $module (required)
                      A module or class that encloses
                      functions/methods and other code.

                      Str $function
                      A block of code designed to perform a
                      particular task.

                      Str @parameters
                      Optional arguments that are passed to the
                      module or function.

                      PositiveInt $line
                      The line number the code that is called
                      resides on.

                      PositiveInt $column
                      The column the code that is called
                      resides.

                      Str $fullFilename
                      The full path and filename of the module.

                  AnyLicense @licenses
                  EITHER (list of SPDX licenses and/or named
                  licenses) OR (tuple of one SPDX License
                  Expression).

                  Copyright @copyright
                  A copyright notice informing users of the
                  underlying claims to copyright ownership in a
                  published work.

                    Str $text (required)
                    The textual content of the copyright.

                ReleaseNotes $releaseNotes
                Specifies optional release notes.

                  ReleaseLevel $type (required)
                  The software versioning type the release note
                  describes.

                  Str $title
                  The title of the release.

                  URL $featuredImage
                  The URL to an image that may be prominently
                  displayed with the release note.

                  URL $socialImage
                  The URL to an image that may be used in
                  messaging on social media platforms.

                  Str $description
                  A short description of the release.

                  DateTime $timestamp
                  The date and time (timestamp) when the
                  release note was created.

                  Str @aliases
                  One or more alternate names the release may
                  be referred to. This may include unofficial
                  terms used by development and marketing teams
                  (e.g. code names).

                  Str @tags
                  Textual strings that aid in discovery,
                  search, and retrieval of the associated
                  object. Tags often serve as a way to group or
                  categorize similar or related objects by
                  various attributes.

                  Resolve @resolves
                  A collection of issues that have been
                  resolved.

                    ResolveType $type (required)
                    Specifies the type of issue.

                    Str $id
                    The identifier of the issue assigned by the
                    source of the issue.

                    Str $name
                    The name of the issue.

                    Str $description
                    A description of the issue.

                    Source $source
                    The source of the issue where it is
                    documented.

                      URL $url
                      The url of documentation as provided by
                      the source.

                      Str $name
                      The name of the source.

                    URL @references
                    A collection of URL's for reference.
                    Multiple URLs are allowed.

                  Note @notes
                  A release note containing the locale and
                  content.

                    locale $locale
                    The ISO-639 (or higher) language code and
                    optional ISO-3166 (or higher) country code.

                    Attachment $text (required)
                    Specifies the full content of the release
                    note.

                      mime-type $contentType
                      Specifies the format and nature of the
                      data being attached, helping systems
                      correctly interpret and process the
                      content. Common content type examples
                      include application/json for JSON data and
                      text/plain for plan text documents.

                      Encoding $encoding
                      Specifies the optional encoding the text
                      is represented in.

                      Str $content (required)
                      The attachment data. Proactive controls
                      such as input validation and sanitization
                      should be employed to prevent misuse of
                      attachment text.

                  Property @properties
                  Any additional properties as name-value
                  pairs.

                    Str $name (required)
                    The name of the property. Duplicate names
                    are allowed.

                    Str $value
                    The value of the property.

                ModelCard $modelCard
                A model card describes the intended uses of a
                machine learning model and potential
                limitations, including biases and ethical
                considerations. Model cards typically contain
                the training parameters, which datasets were
                used to train the model, performance metrics,
                and other relevant data useful for ML
                transparency. This object SHOULD be specified
                for any component of type machine-learning-model
                and must not be specified for other component
                types.

                  bom-ref $bom-ref
                  An optional identifier which can be used to
                  reference the model card elsewhere in the BOM.

                  ModelParameters $modelParameters
                  Hyper-parameters for construction of the
                  model.

                    Approach $approach
                    The overall approach to learning used by
                    the model for problem solving.

                      Learning $type
                      Learning types describing the learning
                      problem or hybrid learning problem.

                    Str $task
                    Directly influences the input and/or
                    output. Examples include classification,
                    regression, clustering, etc.

                    Str $architectureFamily
                    The model architecture family such as
                    transformer network, convolutional neural
                    network, residual neural network, LSTM
                    neural network, etc.

                    Str $modelArchitecture
                    The specific architecture of the model such
                    as GPT-1, ResNet-50, YOLOv3, etc.

                    ModelDataset @datasets
                    The datasets used to train and evaluate the
                    model.

                      bom-ref $bom-ref
                      An optional identifier which can be used
                      to reference the dataset elsewhere in the
                      BOM.

                      DataSource $type (required)
                      The general theme or subject matter of
                      the data being specified.

                      Str $name
                      The name of the dataset.

                      DataContents $contents
                      The contents or references to the
                      contents of the data being described.

                        Attachment $attachment
                        An optional way to include textual or
                        encoded data.

                          mime-type $contentType
                          Specifies the format and nature of
                          the data being attached, helping
                          systems correctly interpret and
                          process the content. Common content
                          type examples include application/json
                          for JSON data and text/plain for plan
                          text documents.

                          Encoding $encoding
                          Specifies the optional encoding the
                          text is represented in.

                          Str $content (required)
                          The attachment data. Proactive
                          controls such as input validation and
                          sanitization should be employed to
                          prevent misuse of attachment text.

                        URL $url
                        The URL to where the data can be
                        retrieved.

                        Property @properties
                        Any additional properties as name-value
                        pairs.

                      Str $classification
                      Data classification tags data according
                      to its type, sensitivity, and value if
                      altered, stolen, or destroyed.

                      Str @sensitiveData
                      A description of any sensitive data in a
                      dataset.

                      Graphics $graphics
                      A collection of graphics that represent
                      various measurements.

                        Str $description
                        A description of this collection of
                        graphics.

                        Graphic @collection
                        A collection of graphics.

                          Str $name
                          The name of the graphic.

                          Attachment $image
                          The graphic (vector or raster).

                            mime-type $contentType
                            Specifies the format and nature of
                            the data being attached, helping
                            systems correctly interpret and
                            process the content. Common content
                            type examples include
                            application/json for JSON data and
                            text/plain for plan text documents.

                            Encoding $encoding
                            Specifies the optional encoding the
                            text is represented in.

                            Str $content (required)
                            The attachment data. Proactive
                            controls such as input validation
                            and sanitization should be employed
                            to prevent misuse of attachment
                            text.

                      Str $description
                      A description of the dataset. Can
                      describe size of dataset, whether it's
                      used for source code, training, testing,
                      or validation, etc.

                      Governance $governance
                      Data governance captures information
                      regarding data ownership, stewardship, and
                      custodianship, providing insights into the
                      individuals or entities responsible for
                      managing, overseeing, and safeguarding the
                      data throughout its lifecycle.

                        Governor @custdians
                        Data custodians are responsible for the
                        safe custody, transport, and storage of
                        data.

                        Governor @stewards
                        Data stewards are responsible for data
                        content, context, and associated
                        business rules.

                        Governor @owners
                        Data owners are concerned with risk and
                        appropriate access to data.

                    ModelFormat @inputs
                    The input format(s) of the model.

                      Str $format
                      The data format for input/output to the
                      model, e.g. "string", "image",
                      "time-series".

                    ModelFormat @outputs
                    The output format(s) of the model.

                      Str $format
                      The data format for input/output to the
                      model, e.g. "string", "image",
                      "time-series".

                  QuantitativeAnalysis $quantitativeAnalysis
                  A quantitative analysis of the model

                    PerformanceMetric @performanceMetrics
                    The model performance metrics being
                    reported.

                      Str $type
                      The type of performance metric.

                      Str $value
                      The value of the performance metric.

                      Str $slice
                      The name of the slice this metric was
                      computed on. By default, assume this
                      metric is not sliced.

                      ConfidenceInterval $confidenceInterval
                      The confidence interval of the metric.

                        Str $lowerBound
                        The lower bound of the confidence
                        interval.

                        Str $UpperBound
                        The upper bound of the confidence
                        interval.

                    Graphics $graphics
                    A collection of graphics that represent
                    various measurements.

                  Considerations $considerations
                  What considerations should be taken into
                  account regarding a model's construction,
                  training, and application?

                    Str @users
                    Who are the intended users of the model?

                    Str @useCases
                    What are the intended use cases of the
                    model?

                    Str @technicalLimitations
                    What are the known technical limitations of
                    the model? E.g. What kind(s) of data should
                    the model be expected not to perform well
                    on? What are the factors that might degrade
                    model performance?

                    Str @performanceTradeoffs
                    What are the known tradeoffs in
                    accuracy/performance of the model?

                    EthicalConsideration @ethicalConsiderations
                    What are the ethical risks involved in the
                    application of this model?

                      Str $name
                      The name of the risk.

                      Str $mitigationStragegy
                      Strategy used to address this risk.

                    EnvironmentalConsiderations $environmentalConsiderations
                    What are the various environmental impacts
                    a machine learning model has exhibited
                    across its lifecycle?

                      EnergyConsumption @energyConsumptions
                      Describes energy consumption information
                      incurred for one or more component
                      lifecycle activities.

                        Activity $activity (required)
                        The type of activity that is part of a
                        machine learning model development or
                        operational lifecycle.

                        EnergyProvider @energyProviders (required)
                        The provider(s) of the energy consumed
                        by the associated model development
                        lifecycle activity.

                          bom-ref $bom-ref
                          An optional identifier which can be
                          used to reference the energy provider
                          elsewhere in the BOM.

                          Str $description
                          A description of the energy provider.

                          Organization $organization (required)
                          The organization that provides
                          energy.

                            bom-ref $bom-ref
                            An optional identifier which can be
                            used to reference the object
                            elsewhere in the BOM.

                            Str $name
                            The name of the organization.

                            Address $address
                            The physical address (location) of
                            the organization.

                            URL @url
                            The URL of the organization.
                            Multiple URLs are allowed.

                            Contact @contact
                            A contact at the organization.
                            Multiple contacts are allowed.

                          Energy $energySource (required)
                          The energy source for the energy
                          provider.

                          EnergyCost $energyProvided (required)
                          The energy provided by the energy
                          source for an associated activity.

                            Rat $value (required)
                            Quantity of energy.

                            EnergyUnit $unit (required)
                            Unit of energy.

                          Reference @externalReferences
                          External references provide a way to
                          document systems, sites, and
                          information that may be relevant but
                          are not included with the BOM. They
                          may also establish specific
                          relationships within or external to
                          the BOM.

                        EnergyCost $activityEnergyCost (required)
                        The total energy cost associated with
                        the model lifecycle activity.

                          Rat $value (required)
                          Quantity of energy.

                          EnergyUnit $unit (required)
                          Unit of energy.

                        CO2Cost $co2CostEquivalent
                        The CO2 cost (debit) equivalent to the
                        total energy cost.

                          Rat $value (required)
                          Quantity of carbon dioxide (CO2).

                          CO2Cost $unit (required)
                          Unit of carbon dioxide (CO2).

                        CO2Cost $co2CostOffset
                        The CO2 offset (credit) for the CO2
                        equivalent cost.

                          Rat $value (required)
                          Quantity of carbon dioxide (CO2).

                          CO2Cost $unit (required)
                          Unit of carbon dioxide (CO2).

                        Property @properties
                        Any additional properties as name-value
                        pairs.

                      Property @properties
                      Any additional properties as name-value
                      pairs.

                    FairnessAssessment @fairnessAssessments
                    How does the model affect groups at risk of
                    being systematically disadvantaged? What are
                    the harms and benefits to the various
                    affected groups?

                      Str $groupAtRisk
                      The groups or individuals at risk of
                      being systematically disadvantaged by the
                      model.

                      Str $benefits
                      Expected benefits to the identified
                      groups.

                      Str $harms
                      Expected harms to the identified groups.

                      Str $mitigationStrategy
                      With respect to the benefits and harms
                      outlined, please describe any mitigation
                      strategy implemented.

                  Property @properties
                  Any additional properties as name-value
                  pairs.

                ComponentDataset @data
                Data associated with a data component.

                  bom-ref $bom-ref
                  An optional identifier which can be used to
                  reference the dataset elsewhere in the BOM.

                  DataSource $type (required)
                  The general theme or subject matter of the
                  data being specified.

                  Str $name
                  The name of the dataset.

                  DataContents $contents
                  The contents or references to the contents of
                  the data being described.

                  Str $classification
                  Data classification tags data according to
                  its type, sensitivity, and value if altered,
                  stolen, or destroyed.

                  Str @sensitiveData
                  A description of any sensitive data in a
                  dataset.

                  Graphics $graphics
                  A collection of graphics that represent
                  various measurements.

                  Str $description
                  A description of the dataset. Can describe
                  size of dataset, whether it's used for source
                  code, training, testing, or validation, etc.

                  Governance $governance
                  Data governance captures information
                  regarding data ownership, stewardship, and
                  custodianship, providing insights into the
                  individuals or entities responsible for
                  managing, overseeing, and safeguarding the
                  data throughout its lifecycle.

                CryptoProperties $cryptoProperties
                Cryptographic assets have properties that
                uniquely define them and that make them
                actionable for further reasoning. As an example,
                it makes a difference if one knows the algorithm
                family (e.g. AES) or the specific variant or
                instantiation (e.g. AES-128-GCM). This is
                because the security level and the algorithm
                primitive (authenticated encryption) are only
                defined by the definition of the algorithm
                variant. The presence of a weak cryptographic
                algorithm like SHA1 vs. HMAC-SHA1 also makes a
                difference.

                  CryptoAsset $assetType (required)
                  Type of crypto asset.

                  AlgorithmProperties $algorithmProperties
                  Additional properties specific to a
                  cryptographic algorithm.

                    AlgorithmPrimitive $primitive
                    Cryptographic building blocks used in
                    higher-level cryptographic systems and
                    protocols.

                    Str $parameterSetIdentifier
                    An identifier for the parameter set of the
                    cryptographic algorithm. Examples: in
                    AES128, '128' identifies the key length in
                    bits, in SHA256, '256' identifies the digest
                    length, '128' in SHAKE128 identifies its
                    maximum security level in bits, and
                    'SHA2-128s' identifies a parameter set used
                    in SLH-DSA (FIPS205).

                    Str $curve
                    The specific underlying Elliptic Curve (EC)
                    definition employed which is an indicator of
                    the level of security strength, performance
                    and complexity. Absent an authoritative
                    source of curve names, CycloneDX recommends
                    using curve names as defined at
                    https://neuromancer.sk/std/, the source of
                    which can be found at
                    https://github.com/J08nY/std-curves.

                    ExecutionEnvironment $executionEnvironmment
                    The target and execution environment in
                    which the algorithm is implemented in.

                    Platform $implementationPlatform
                    The target platform for which the algorithm
                    is implemented. The implementation can be
                    'generic', running on any platform or for a
                    specific platform.

                    Certification $certficationLevel
                    The certification that the implementation
                    of the cryptographic algorithm has received,
                    if any. Certifications include revisions and
                    levels of FIPS 140 or Common Criteria of
                    different Extended Assurance Levels
                    (CC-EAL).

                    CertificationMode $mode
                    The mode of operation in which the
                    cryptographic algorithm (block cipher) is
                    used.

                    CertificationPadding $padding
                    The padding scheme that is used for the
                    cryptographic algorithm.

                    CryptoFunction @cryptoFunctions
                    The cryptographic functions implemented by
                    the cryptographic algorithm.

                    UInt $classicalSecurityLevel
                    The classical security level that a
                    cryptographic algorithm provides (in bits).

                    nistQuantumSecurityLevel $nistQuantumSecurityLevel
                    The NIST security strength category as
                    defined in
                    https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria).
                    A value of 0 indicates that none of the
                    categories are met.

                  CertificateProperties $certificateProperties
                  Properties for cryptographic assets of asset
                  type 'certificate'.

                    Str $subjectName
                    The subject name for the certificate.

                    Str $issuerName
                    The issuer name for the certificate.

                    DateTime $notValidBefore
                    The date and time according to ISO-8601
                    standard from which the certificate is
                    valid.

                    DateTime $notValidAfter
                    The date and time according to ISO-8601
                    standard from which the certificate is not
                    valid anymore.

                    Str $signatureAlgorithmRef
                    The bom-ref to signature algorithm used by
                    the certificate.

                    Str $subjectPublicKeyRef
                    The bom-ref to the public key of the
                    subject.

                    Str $certificateFormat
                    The format of the certificate.

                    Str $certificateExtension
                    The file extension of the certificate.

                  CryptoMaterialProperties $relatedCryptoMaterialProperties
                  Properties for cryptographic assets of asset
                  type 'related-crypto-material'.

                    Crypto $type
                    The type for the related cryptographic
                    material

                    Str $id
                    The optional unique identifier for the
                    related cryptographic material.

                    CryptoState $state
                    The key state as defined by NIST SP 800-57.

                    Str $algorithmRef
                    The bom-ref to the algorithm used to
                    generate the related cryptographic material.

                    DateTime $creationDate
                    The date and time (timestamp) when the
                    related cryptographic material was created.

                    DateTime $activationDate
                    The date and time (timestamp) when the
                    related cryptographic material was
                    activated.

                    DateTime $updateDate
                    The date and time (timestamp) when the
                    related cryptographic material was updated.

                    DateTime $expirationDate
                    The date and time (timestamp) when the
                    related cryptographic material expires.

                    Str $value
                    The associated value of the cryptographic
                    material.

                    UInt $size
                    The size of the cryptographic asset (in
                    bits).

                    Str $format
                    The format of the related cryptographic
                    material (e.g. P8, PEM, DER).

                    CryptoSecurity $securedBy
                    The mechanism by which the cryptographic
                    asset is secured by.

                      Str $mechanism
                      Specifies the mechanism by which the
                      cryptographic asset is secured by.

                      Str $algorithmRef
                      The bom-ref to the algorithm.

                  CryptoProtocolProperties $protocolProperties
                  Properties specific to cryptographic assets
                  of type: protocol.

                    CryptoProtocol $type
                    The concrete protocol type.

                    versionString $version
                    The version of the protocol.

                    CipherSuite @cipherSuites
                    A list of cipher suites related to the
                    protocol.

                      Str $name
                      A common name for the cipher suite.

                      Str @algorithms
                      A list of algorithms related to the
                      cipher suite.

                      Str @identifiers
                      A list of common identifiers for the
                      cipher suite.

                    IKEv2TransformTypes $ikev2TransformTypes
                    The IKEv2 transform types supported (types
                    1-4), defined in RFC 7296 section 3.3.2, and
                    additional properties.

                      Str @encr
                      Transform Type 1: encryption algorithms.

                      Str @prf
                      Transform Type 2: pseudorandom functions.

                      Str @integ
                      Transform Type 3: integrity algorithms.

                      Str @ke
                      Transform Type 4: Key Exchange Method
                      (KE) per RFC 9370, formerly called
                      Diffie-Hellman Group (D-H).

                      Bool $esn
                      Specifies if an Extended Sequence Number
                      (ESN) is used.

                      IDnotbomLink @auth
                      IKEv2 Authentication methods: identifier
                      for referable and therefore interlinkable
                      elements.

                    IDnotbomLink @cryptoRefArray
                    A list of protocol-related cryptographic
                    assets, Identifier for referable and
                    therefore interlinkable elements.

                  Str $oid
                  The object identifier (OID) of the
                  cryptographic asset.

                Property @properties
                Any additional properties as name-value pairs.

                Str @tags
                Textual strings that aid in discovery, search,
                and retrieval of the associated object. Tags
                often serve as a way to group or categorize
                similar or related objects by various
                attributes.

                ValidSignature $signature
                Enveloped signature in JSON Signature Format
                (JSF).

              ComponentEvidence $evidence
              Provides the ability to document evidence
              collected through various forms of extraction or
              analysis.

              ReleaseNotes $releaseNotes
              Specifies optional release notes.

              ModelCard $modelCard
              A model card describes the intended uses of a
              machine learning model and potential limitations,
              including biases and ethical considerations. Model
              cards typically contain the training parameters,
              which datasets were used to train the model,
              performance metrics, and other relevant data
              useful for ML transparency. This object SHOULD be
              specified for any component of type
              machine-learning-model and must not be specified
              for other component types.

              ComponentDataset @data
              Data associated with a data component.

              CryptoProperties $cryptoProperties
              Cryptographic assets have properties that
              uniquely define them and that make them actionable
              for further reasoning. As an example, it makes a
              difference if one knows the algorithm family (e.g.
              AES) or the specific variant or instantiation
              (e.g. AES-128-GCM). This is because the security
              level and the algorithm primitive (authenticated
              encryption) are only defined by the definition of
              the algorithm variant. The presence of a weak
              cryptographic algorithm like SHA1 vs. HMAC-SHA1
              also makes a difference.

              Property @properties
              Any additional properties as name-value pairs.

              Str @tags
              Textual strings that aid in discovery, search,
              and retrieval of the associated object. Tags often
              serve as a way to group or categorize similar or
              related objects by various attributes.

              ValidSignature $signature
              Enveloped signature in JSON Signature Format
              (JSF).

            Component @descendants
            Descendants are the exact opposite of ancestors.
            This provides a way to document all forks (and their
            forks) of an original or root component.

              ComponentType $type (required)
              Specifies the type of the component. For software
              components, classify as application if no more
              specific appropriate classification is available
              or cannot be determined for the component.

              mime-type $mime-type
              The optional mime-type of the component. When
              used on file components, the mime-type can provide
              additional context about the kind of file being
              represented, such as an image, font, or
              executable. Some library or framework components
              may also have an associated mime-type.

              bom-ref $bom-ref
              An optional identifier which can be used to
              reference the component elsewhere in the BOM.
              Every bom-ref must be unique within the BOM. Value
              SHOULD not start with the BOM-Link intro
              'urn:cdx:' to avoid conflicts with BOM-Links.

              Organization $supplier
              The organization that supplied the component. The
              supplier may often be the manufacturer, but may
              also be a distributor or repackager.

              Organization $manufacturer
              The organization that created the component.
              Manufacturer is common in components created
              through automated processes. Components created
              through manual means may have @.authors instead.

              Contact @authors
              The person(s) who created the component. Authors
              are common in components created through manual
              processes. Components created through automated
              means may have @.manufacturer instead.

              Str $publisher
              The person(s) or organization(s) that published
              the component.

              Str $group
              The grouping name or identifier. This will often
              be a shortened, single name of the company or
              project that produced the component, or the source
              package or domain name. Whitespace and special
              characters should be avoided. Examples include:
              apache, org.apache.commons, and apache.org.

              Str $name (required)
              The name of the component. This will often be a
              shortened, single name of the component. Examples:
              commons-lang3 and jquery.

              versionString $version
              The component version. The version should ideally
              comply with semantic versioning but is not
              enforced.

              Str $description
              Specifies a description for the component

              Scope $scope
              Specifies the scope of the component. If scope is
              not specified, 'required' scope SHOULD be assumed
              by the consumer of the BOM.

              HashedString @hashes
              The hashes of the component.

              AnyLicense @licenses
              EITHER (list of SPDX licenses and/or named
              licenses) OR (tuple of one SPDX License
              Expression)

              Str $copyright
              A copyright notice informing users of the
              underlying claims to copyright ownership in a
              published work.

              CPE $cpe
              Asserts the identity of the component using CPE.
              The CPE must conform to the CPE 2.2 or 2.3
              specification. See
              https://nvd.nist.gov/products/cpe. Refer to
              @.evidence.identity to optionally provide evidence
              that substantiates the assertion of the
              component's identity.

              PURL $purl
              Asserts the identity of the component using
              package-url (purl). The purl, if specified, must
              be valid and conform to the specification defined
              at: https://github.com/package-url/purl-spec.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              omniborId @omniborId
              Asserts the identity of the component using the
              OmniBOR Artifact ID. The OmniBOR, if specified,
              must be valid and conform to the specification
              defined at:
              https://www.iana.org/assignments/uri-schemes/prov/gitoid.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              SWHID @swhid
              Asserts the identity of the component using the
              Software Heritage persistent identifier (SWHID).
              The SWHID, if specified, must be valid and conform
              to the specification defined at:
              https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              SWID $swid
              Asserts the identity of the component using
              ISO-IEC 19770-2 Software Identification (SWID)
              Tags. Refer to @.evidence.identity to optionally
              provide evidence that substantiates the assertion
              of the component's identity.

              Bool $modified
              [Deprecated] This will be removed in a future
              version. Use the pedigree element instead to
              supply information on exactly how the component
              was modified. A boolean value indicating if the
              component has been modified from the original. A
              value of true indicates the component is a
              derivative of the original. A value of false
              indicates the component has not been modified from
              the original.

              Pedigree $pedigree
              Component pedigree is a way to document complex
              supply chain scenarios where components are
              created, distributed, modified, redistributed,
              combined with other components, etc. Pedigree
              supports viewing this complex chain from the
              beginning, the end, or anywhere in the middle. It
              also provides a way to document variants where the
              exact relation may not be known.

              Reference @externalReferences
              External references provide a way to document
              systems, sites, and information that may be
              relevant but are not included with the BOM. They
              may also establish specific relationships within
              or external to the BOM.

              Component @components
              A list of software and hardware components
              included in the parent component. This is not a
              dependency tree. It provides a way to specify a
              hierarchical representation of component
              assemblies, similar to system → subsystem → parts
              assembly in physical supply chains.

              ComponentEvidence $evidence
              Provides the ability to document evidence
              collected through various forms of extraction or
              analysis.

              ReleaseNotes $releaseNotes
              Specifies optional release notes.

              ModelCard $modelCard
              A model card describes the intended uses of a
              machine learning model and potential limitations,
              including biases and ethical considerations. Model
              cards typically contain the training parameters,
              which datasets were used to train the model,
              performance metrics, and other relevant data
              useful for ML transparency. This object SHOULD be
              specified for any component of type
              machine-learning-model and must not be specified
              for other component types.

              ComponentDataset @data
              Data associated with a data component.

              CryptoProperties $cryptoProperties
              Cryptographic assets have properties that
              uniquely define them and that make them actionable
              for further reasoning. As an example, it makes a
              difference if one knows the algorithm family (e.g.
              AES) or the specific variant or instantiation
              (e.g. AES-128-GCM). This is because the security
              level and the algorithm primitive (authenticated
              encryption) are only defined by the definition of
              the algorithm variant. The presence of a weak
              cryptographic algorithm like SHA1 vs. HMAC-SHA1
              also makes a difference.

              Property @properties
              Any additional properties as name-value pairs.

              Str @tags
              Textual strings that aid in discovery, search,
              and retrieval of the associated object. Tags often
              serve as a way to group or categorize similar or
              related objects by various attributes.

              ValidSignature $signature
              Enveloped signature in JSON Signature Format
              (JSF).

            Component @variants
            Variants describe relations where the relationship
            between the components is not known. For example, if
            Component A contains nearly identical code to
            Component B. They are both related, but it is
            unclear if one is derived from the other, or if they
            share a common ancestor.

              ComponentType $type (required)
              Specifies the type of the component. For software
              components, classify as application if no more
              specific appropriate classification is available
              or cannot be determined for the component.

              mime-type $mime-type
              The optional mime-type of the component. When
              used on file components, the mime-type can provide
              additional context about the kind of file being
              represented, such as an image, font, or
              executable. Some library or framework components
              may also have an associated mime-type.

              bom-ref $bom-ref
              An optional identifier which can be used to
              reference the component elsewhere in the BOM.
              Every bom-ref must be unique within the BOM. Value
              SHOULD not start with the BOM-Link intro
              'urn:cdx:' to avoid conflicts with BOM-Links.

              Organization $supplier
              The organization that supplied the component. The
              supplier may often be the manufacturer, but may
              also be a distributor or repackager.

              Organization $manufacturer
              The organization that created the component.
              Manufacturer is common in components created
              through automated processes. Components created
              through manual means may have @.authors instead.

              Contact @authors
              The person(s) who created the component. Authors
              are common in components created through manual
              processes. Components created through automated
              means may have @.manufacturer instead.

              Str $publisher
              The person(s) or organization(s) that published
              the component.

              Str $group
              The grouping name or identifier. This will often
              be a shortened, single name of the company or
              project that produced the component, or the source
              package or domain name. Whitespace and special
              characters should be avoided. Examples include:
              apache, org.apache.commons, and apache.org.

              Str $name (required)
              The name of the component. This will often be a
              shortened, single name of the component. Examples:
              commons-lang3 and jquery.

              versionString $version
              The component version. The version should ideally
              comply with semantic versioning but is not
              enforced.

              Str $description
              Specifies a description for the component

              Scope $scope
              Specifies the scope of the component. If scope is
              not specified, 'required' scope SHOULD be assumed
              by the consumer of the BOM.

              HashedString @hashes
              The hashes of the component.

              AnyLicense @licenses
              EITHER (list of SPDX licenses and/or named
              licenses) OR (tuple of one SPDX License
              Expression)

              Str $copyright
              A copyright notice informing users of the
              underlying claims to copyright ownership in a
              published work.

              CPE $cpe
              Asserts the identity of the component using CPE.
              The CPE must conform to the CPE 2.2 or 2.3
              specification. See
              https://nvd.nist.gov/products/cpe. Refer to
              @.evidence.identity to optionally provide evidence
              that substantiates the assertion of the
              component's identity.

              PURL $purl
              Asserts the identity of the component using
              package-url (purl). The purl, if specified, must
              be valid and conform to the specification defined
              at: https://github.com/package-url/purl-spec.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              omniborId @omniborId
              Asserts the identity of the component using the
              OmniBOR Artifact ID. The OmniBOR, if specified,
              must be valid and conform to the specification
              defined at:
              https://www.iana.org/assignments/uri-schemes/prov/gitoid.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              SWHID @swhid
              Asserts the identity of the component using the
              Software Heritage persistent identifier (SWHID).
              The SWHID, if specified, must be valid and conform
              to the specification defined at:
              https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
              Refer to @.evidence.identity to optionally provide
              evidence that substantiates the assertion of the
              component's identity.

              SWID $swid
              Asserts the identity of the component using
              ISO-IEC 19770-2 Software Identification (SWID)
              Tags. Refer to @.evidence.identity to optionally
              provide evidence that substantiates the assertion
              of the component's identity.

              Bool $modified
              [Deprecated] This will be removed in a future
              version. Use the pedigree element instead to
              supply information on exactly how the component
              was modified. A boolean value indicating if the
              component has been modified from the original. A
              value of true indicates the component is a
              derivative of the original. A value of false
              indicates the component has not been modified from
              the original.

              Pedigree $pedigree
              Component pedigree is a way to document complex
              supply chain scenarios where components are
              created, distributed, modified, redistributed,
              combined with other components, etc. Pedigree
              supports viewing this complex chain from the
              beginning, the end, or anywhere in the middle. It
              also provides a way to document variants where the
              exact relation may not be known.

              Reference @externalReferences
              External references provide a way to document
              systems, sites, and information that may be
              relevant but are not included with the BOM. They
              may also establish specific relationships within
              or external to the BOM.

              Component @components
              A list of software and hardware components
              included in the parent component. This is not a
              dependency tree. It provides a way to specify a
              hierarchical representation of component
              assemblies, similar to system → subsystem → parts
              assembly in physical supply chains.

              ComponentEvidence $evidence
              Provides the ability to document evidence
              collected through various forms of extraction or
              analysis.

              ReleaseNotes $releaseNotes
              Specifies optional release notes.

              ModelCard $modelCard
              A model card describes the intended uses of a
              machine learning model and potential limitations,
              including biases and ethical considerations. Model
              cards typically contain the training parameters,
              which datasets were used to train the model,
              performance metrics, and other relevant data
              useful for ML transparency. This object SHOULD be
              specified for any component of type
              machine-learning-model and must not be specified
              for other component types.

              ComponentDataset @data
              Data associated with a data component.

              CryptoProperties $cryptoProperties
              Cryptographic assets have properties that
              uniquely define them and that make them actionable
              for further reasoning. As an example, it makes a
              difference if one knows the algorithm family (e.g.
              AES) or the specific variant or instantiation
              (e.g. AES-128-GCM). This is because the security
              level and the algorithm primitive (authenticated
              encryption) are only defined by the definition of
              the algorithm variant. The presence of a weak
              cryptographic algorithm like SHA1 vs. HMAC-SHA1
              also makes a difference.

              Property @properties
              Any additional properties as name-value pairs.

              Str @tags
              Textual strings that aid in discovery, search,
              and retrieval of the associated object. Tags often
              serve as a way to group or categorize similar or
              related objects by various attributes.

              ValidSignature $signature
              Enveloped signature in JSON Signature Format
              (JSF).

            Commit @commits
            A list of zero or more commits which provide a
            trail describing how the component deviates from an
            ancestor, descendant, or variant.

              Str $uid
              A unique identifier of the commit. This may be
              version control specific. For example, Subversion
              uses revision numbers whereas git uses commit
              hashes.

              URL $url
              The URL to the commit. This URL will typically
              point to a commit in a version control system.

              Development $author
              The author who created the changes in the commit.

                DateTime $timestamp
                The timestamp in which the action occurred.

                Str $name
                The name of the individual who performed the
                action.

                email $email
                The email address of the individual who
                performed the action.

              Development $committer
              The person who committed or pushed the commit.

                DateTime $timestamp
                The timestamp in which the action occurred.

                Str $name
                The name of the individual who performed the
                action.

                email $email
                The email address of the individual who
                performed the action.

              Str $message
              The text description of the contents of the
              commit.

            Patch @patches
            A list of zero or more patches describing how the
            component deviates from an ancestor, descendant, or
            variant. Patches may be complementary to commits or
            may be used in place of commits.

              Patch $type (required)
              Specifies the purpose for the patch including the
              resolution of defects, security issues, or new
              behavior or functionality.

              Diff $diff
              The patch file (or diff) that shows changes.
              Refer to https://en.wikipedia.org/wiki/Diff

                Attachment $text
                Specifies the optional text of the diff.

                URL $url
                Specifies the URL to the diff.

              Resolve @resolves
              A collection of issues the patch resolves.

            Str $notes
            Notes, observations, and other non-structured
            commentary describing the components pedigree.

          Reference @externalReferences
          External references provide a way to document
          systems, sites, and information that may be relevant
          but are not included with the BOM. They may also
          establish specific relationships within or external to
          the BOM.

          Component @components
          A list of software and hardware components included
          in the parent component. This is not a dependency
          tree. It provides a way to specify a hierarchical
          representation of component assemblies, similar to
          system → subsystem → parts assembly in physical supply
          chains.

          ComponentEvidence $evidence
          Provides the ability to document evidence collected
          through various forms of extraction or analysis.

          ReleaseNotes $releaseNotes
          Specifies optional release notes.

          ModelCard $modelCard
          A model card describes the intended uses of a machine
          learning model and potential limitations, including
          biases and ethical considerations. Model cards
          typically contain the training parameters, which
          datasets were used to train the model, performance
          metrics, and other relevant data useful for ML
          transparency. This object SHOULD be specified for any
          component of type machine-learning-model and must not
          be specified for other component types.

          ComponentDataset @data
          Data associated with a data component.

          CryptoProperties $cryptoProperties
          Cryptographic assets have properties that uniquely
          define them and that make them actionable for further
          reasoning. As an example, it makes a difference if one
          knows the algorithm family (e.g. AES) or the specific
          variant or instantiation (e.g. AES-128-GCM). This is
          because the security level and the algorithm primitive
          (authenticated encryption) are only defined by the
          definition of the algorithm variant. The presence of a
          weak cryptographic algorithm like SHA1 vs. HMAC-SHA1
          also makes a difference.

          Property @properties
          Any additional properties as name-value pairs.

          Str @tags
          Textual strings that aid in discovery, search, and
          retrieval of the associated object. Tags often serve
          as a way to group or categorize similar or related
          objects by various attributes.

          ValidSignature $signature
          Enveloped signature in JSON Signature Format (JSF).

        Organization $supplier
        The organization that supplied the component that the
        BOM describes. The supplier may often be the
        manufacturer, but may also be a distributor or
        repackager.

        AnyLicense @licenses
        The license information for the BOM document. This may
        be different from the license(s) of the component(s)
        that the BOM describes.

        Property @properties
        Any additional properties as name-value pairs.

    - Component @components ---------------------------------------
      A list of software and hardware components. All items
      must be unique.

    - Service @services -------------------------------------------
      A list of services. This may include microservices,
      function-as-a-service, and other types of network or
      intra-process services. All items must be unique.

        bom-ref $bom-ref
        An optional identifier which can be used to reference
        the service elsewhere in the BOM. Every bom-ref must be
        unique within the BOM.

        Organization $provider
        The organization that provides the service.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the object elsewhere in the BOM.

          Str $name
          The name of the organization.

          Address $address
          The physical address (location) of the organization.

          URL @url
          The URL of the organization. Multiple URLs are
          allowed.

          Contact @contact
          A contact at the organization. Multiple contacts are
          allowed.

        Str $group
        The grouping name, namespace, or identifier. This will
        often be a shortened, single name of the company or
        project that produced the service or domain name.
        Whitespace and special characters should be avoided.

        Str $name (required)
        The name of the service. This will often be a
        shortened, single name of the service.

        versionString $version
        The service version.

        Str $description
        Specifies a description for the service.

        URL @endpoints
        The endpoint URIs of the service.

        Bool $authenticated
        A boolean value indicating if the service requires
        authentication. A value of true indicates the service
        requires authentication prior to use. A value of false
        indicates the service does not require authentication.

        Bool $x-trust-boundary
        A boolean value indicating if use of the service
        crosses a trust zone or boundary. A value of true
        indicates that by using the service, a trust boundary is
        crossed. A value of false indicates that by using the
        service, a trust boundary is not crossed.

        Str $trustZone
        The name of the trust zone the service resides in.

        ServiceDataset @data
        Specifies information about the data including the
        directional flow of data and the data classification.

          DataFlow $flow (required)
          Specifies the flow direction of the data, relative to
          the service.

          Str $classification (required)
          Data classification tags data according to its type,
          sensitivity, and value if altered, stolen, or
          destroyed.

          Str $name
          Name for the defined data.

          Str $description
          Short description of the data content and usage.

          Governance $governance
          Data governance captures information regarding data
          ownership, stewardship, and custodianship, providing
          insights into the individuals or entities responsible
          for managing, overseeing, and safeguarding the data
          throughout its lifecycle.

          Endpoint $source
          The URI, URL, or BOM-Link of the components or
          services the data came in from.

          Endpoint $destination
          The URI, URL, or BOM-Link of the components or
          services the data is sent to.

        AnyLicense @licenses
        EITHER (list of SPDX licenses and/or named licenses) OR
        (tuple of one SPDX License Expression).

        Reference @externalReferences
        External references provide a way to document systems,
        sites, and information that may be relevant but are not
        included with the BOM. They may also establish specific
        relationships within or external to the BOM.

        Service @services
        A list of services included or deployed behind the
        parent service. This is not a dependency tree. It
        provides a way to specify ai hierarchical representation
        of service assemblies. All items must be unique.

        ReleaseNotes $releaseNotes
        Specifies optional release notes.

        Property @properties
        Any additional properties as name-value pairs.

        Str @tags
        Textual strings that aid in discovery, search, and
        retrieval of the associated object. Tags often serve as
        a way to group or categorize similar or related objects
        by various attributes.

        ValidSignature $signature
        Enveloped signature in JSON Signature Format (JSF).

    - Reference @externalReferences -------------------------------
      External references provide a way to document systems,
      sites, and information that may be relevant but are not
      included with the BOM. They may also establish specific
      relationships within or external to the BOM.

    - Dependency @dependencies ------------------------------------
      Provides the ability to document dependency relationships
      including provided & implemented components. All items
      must be unique.

        bom-ref $ref
        References a component or service by its bom-ref
        attribute.

        bom-ref @dependsOn
        The bom-ref identifiers of the components or services
        that are dependencies of this dependency object.

        bom-ref @provides
        The bom-ref identifiers of the components or services
        that define a given specification or standard, which are
        provided or implemented by this dependency object. For
        example, a cryptographic library which implements a
        cryptographic algorithm. A component which implements
        another component does not imply that the implementation
        is in use.

    - Composition @compositions -----------------------------------
      Compositions describe constituent parts (including
      components, services, and dependency relationships) and
      their completeness. The completeness of vulnerabilities
      expressed in a BOM may also be described.

        bom-ref $bom-ref
        An optional identifier which can be used to reference
        the composition elsewhere in the BOM.

        Aggregate $aggregate
        Specifies an aggregate type that describes how complete
        a relationship is.

        bomLinkElement @assemblies
        The bom-ref identifiers of the components or services
        being described. Assemblies refer to nested
        relationships whereby a constituent part may include
        other constituent parts. References do not cascade to
        child parts. References are explicit for the specified
        constituent part only.

        bom-ref @dependencies
        The bom-ref identifiers of the components or services
        being described. Dependencies refer to a relationship
        whereby an independent constituent part requires another
        independent constituent part. References do not cascade
        to transitive dependencies. References are explicit for
        the specified dependency only.

        bom-ref @vulnerabilities
        The bom-ref identifiers of the vulnerabilities being
        described.

        ValidSignature $signature
        Enveloped signature in JSON Signature Format (JSF).

    - Vulnerability @vulnerabilities ------------------------------
      Vulnerabilities identified in components or services. All
      items must be unique.

        bom-ref $bom-ref
        An optional identifier which can be used to reference
        the vulnerability elsewhere in the BOM.

        Str $id
        The identifier that uniquely identifies the
        vulnerability.

        Source $source
        The source that published the vulnerability.

        SourceReference @references
        Zero or more pointers to vulnerabilities that are the
        equivalent of the vulnerability specified. Often times,
        the same vulnerability may exist in multiple sources of
        vulnerability intelligence, but have different
        identifiers. References provide a way to correlate
        vulnerabilities across multiple sources of vulnerability
        intelligence.

          Str $id
          An identifier that uniquely identifies the
          vulnerability.

          Source $source
          The source that published the vulnerability.

        Rating @ratings
        List of vulnerability ratings.

          Source $source
          The source that calculated the severity or risk
          rating of the vulnerability.

          Rat $score
          The numerical score of the rating.

          Severity $severity
          Textual representation of the severity that
          corresponds to the numerical score of the rating.

          RiskMethodology $method
          Specifies the severity or risk scoring methodology or
          standard used.

          Str $vector
          Textual representation of the metric values used to
          score the vulnerability.

          Str $justification
          An optional reason for rating the vulnerability as it
          was.

        PositiveInt @cwes
        List of Common Weaknesses Enumerations (CWEs) codes
        that describes this vulnerability. For example 399 (of
        https://cwe.mitre.org/data/definitions/399.html).

        Str $description
        A description of the vulnerability as provided by the
        source.

        Str $detail
        If available, an in-depth description of the
        vulnerability as provided by the source organization.
        Details often include information useful in
        understanding root cause.

        Str $recommendation
        Recommendations of how the vulnerability can be
        remediated or mitigated.

        Str $workaround
        A bypass, usually temporary, of the vulnerability that
        reduces its likelihood and/or impact. Workarounds often
        involve changes to configuration or deployments.

        ProofOfConcept $proofOfConcept
        Evidence used to reproduce the vulnerability.

          Str $reproductionSteps
          Precise steps to reproduce the vulnerability.

          Str $environment
          A description of the environment in which
          reproduction was possible.

          Attachment @supportingMaterial
          Supporting material that helps in reproducing or
          understanding how reproduction is possible. This may
          include screenshots, payloads, and PoC exploit code.

            mime-type $contentType
            Specifies the format and nature of the data being
            attached, helping systems correctly interpret and
            process the content. Common content type examples
            include application/json for JSON data and
            text/plain for plan text documents.

            Encoding $encoding
            Specifies the optional encoding the text is
            represented in.

            Str $content (required)
            The attachment data. Proactive controls such as
            input validation and sanitization should be employed
            to prevent misuse of attachment text.

        Advisory @advisories
        Published advisories of the vulnerability if provided.

          Str $title
          An optional name of the advisory.

          URL $url (required)
          Location where the advisory can be obtained.

        DateTime $created
        The date and time (timestamp) when the vulnerability
        record was created in the vulnerability database.

        DateTime $published
        The date and time (timestamp) when the vulnerability
        record was first published.

        DateTime $updated
        The date and time (timestamp) when the vulnerability
        record was last updated.

        DateTime $rejected
        The date and time (timestamp) when the vulnerability
        record was rejected (if applicable).

        Credits $credits
        Individuals or organizations credited with the
        discovery of the vulnerability.

          Organization @organizations
          The organizations credited with vulnerability
          discovery.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the object elsewhere in the BOM.

            Str $name
            The name of the organization.

            Address $address
            The physical address (location) of the
            organization.

            URL @url
            The URL of the organization. Multiple URLs are
            allowed.

            Contact @contact
            A contact at the organization. Multiple contacts
            are allowed.

          Contact @individuals
          The individuals, not associated with organizations,
          that are credited with vulnerability discovery.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the person elsewhere in the BOM.

            Str $name
            The name of a contact.

            email $email
            The email address of the contact.

            Str $phone
            The phone number of the contact.

        AnyTool $tools
        The tool(s) used to identify, confirm, or score the
        vulnerability.

        Analysis $analysis
        An assessment of the impact and exploitability of the
        vulnerability.

          VulnerabilityState $state
          Declares the current state of an occurrence of a
          vulnerability, after automated or manual analysis.

          Justification $justification
          The rationale of why the impact analysis state was
          asserted.

          Response $response
          A response to the vulnerability by the manufacturer,
          supplier, or project responsible for the affected
          component or service. More than one response is
          allowed. Responses are strongly encouraged for
          vulnerabilities where the analysis state is
          exploitable.

          Str $detail
          Detailed description of the impact including methods
          used during assessment. If a vulnerability is not
          exploitable, this field should include specific
          details on why the component or service is not
          impacted by this vulnerability.

          DateTime $firstIssued
          The date and time (timestamp) when the analysis was
          first issued.

          DateTime $lastUpdated
          The date and time (timestamp) when the analysis was
          last updated.

        referenceURL @affects
        The components or services that are affected by the
        vulnerability.

        Property @properties
        Any additional properties as name-value pairs.

    - Annotation @annotations -------------------------------------
      Comments made by people, organizations, or tools about
      any object with a bom-ref, such as components, services,
      vulnerabilities, or the BOM itself. Unlike inventory
      information, annotations may contain opinions or
      commentary from various stakeholders. Annotations may be
      inline (with inventory) or externalized viai BOM-Link and
      may optionally be signed. All items must be unique.

        bom-ref $bom-ref
        An optional identifier which can be used to reference
        the annotation elsewhere in the BOM.

        referenceURL @subjects (required)
        The object in the BOM identified by its bom-ref. This
        is often a component or service, but may be any object
        type supporting bom-refs.

        Annotator $annotator (required)
        The organization, person, component, or service which
        created the textual content of the annotation.

        DateTime $timestamp (required)
        The date and time (timestamp) when the annotation was
        created.

        Str $text (required)
        The textual content of the annotation.

        ValidSignature $signature
        Enveloped signature in JSON Signature Format (JSF).

    - Formulation @formulations -----------------------------------
      Describes how a component or service was manufactured or
      deployed. This is achieved through the use of formulas,
      workflows, tasks, and steps, which declare the precise
      steps to reproduce along with the observed formulas
      describing the steps which transpired in the manufacturing
      process. All items must be unique.

        bom-ref $bom-ref
        An optional identifier which can be used to reference
        the formula elsewhere in the BOM.

        Component @components
        Transient components that are used in tasks that
        constitute one or more of this formula's workflows.

        Service @services
        Transient services that are used in tasks that
        constitute one or more of this formula's workflows.

        Workflow @workflows
        List of workflows that can be declared to accomplish
        specific orchestrated goals and independently triggered.

          bom-ref $bom-ref (required)
          An optional identifier which can be used to reference
          the workflow elsewhere in the BOM.

          Str $uid (required)
          The unique identifier for the resource instance
          within its deployment context.

          Str $name
          The name of the resource instance.

          Str $description
          A description of the resource instance.

          resourceRef @resourceReferences
          References to component or service resources that are
          used toi realize the resource instance.

          Task @tasks
          The tasks that comprise the workflow.

            bom-ref $bom-ref (required)
            An optional identifier which can be used to
            reference the task elsewhere in the BOM.

            Str $uid (required)
            The unique identifier for the resource instance
            within its deployment context.

            Str $name
            The name of the resource instance.

            Str $description
            A description of the resource instance.

            resourceRef @resourceReferences
            References to component or service resources that
            are used to realize the resource instance.

            TaskActivity @taskTypes (required)
            Indicates the types of activities performed by the
            set of workflow tasks.

            Trigger $trigger
            The trigger that initiated the task.

              bom-ref $bom-ref (required)
              An optional identifier which can be used to
              reference the trigger elsewhere in the BOM.

              Str $uid (required)
              The unique identifier for the resource instance
              within its deployment context.

              Str $name
              The name of the resource instance.

              Str $description
              A description of the resource instance.

              resourceRef @resourceReferences
              References to component or service resources that
              are used to realize the resource instance.

              TriggerEvent $type
              The source type of event which caused the trigger
              to fire.

              Event $event
              The event data that caused the associated trigger
              to activate.

                Str $uid
                The unique identifier of the event.

                Str $description
                A description of the event.

                DateTime $timeReceived
                The date and time (timestamp) when the event
                was received.

                Attachment $data
                Encoding of the raw event data.

                  mime-type $contentType
                  Specifies the format and nature of the data
                  being attached, helping systems correctly
                  interpret and process the content. Common
                  content type examples include application/json
                  for JSON data and text/plain for plan text
                  documents.

                  Encoding $encoding
                  Specifies the optional encoding the text is
                  represented in.

                  Str $content (required)
                  The attachment data. Proactive controls such
                  as input validation and sanitization should be
                  employed to prevent misuse of attachment text.

                resourceRef $source
                References the component or service that was
                the source of the event.

                resourceRef $target
                References the component or service that was
                the target of the event.

                Property @properties
                Any additional properties as name-value pairs.

              Condition @conditions
              A list of conditions used to determine if a
              trigger should be activated.

                Str $description
                Describes the set of conditions which cause the
                trigger to activate.

                Str $expression
                The logical expression that was evaluated that
                determined the trigger should be fired.

                Property @properties
                Any additional properties as name-value pairs.

              DateTime $timeActivated
              The date and time (timestamp) when the trigger
              was activated.

              Input @inputs
              Represents resources and data brought into a task
              at runtime by executor or task commands.

                resourceRef $source
                A reference to the component or service that
                provided the input to the task (e.g., reference
                to a service with data flow value of inbound)

                resourceRef $target
                A reference to the component or service that
                received or stored the input if not the task
                itself (e.g., a local, named storage workspace)

                resourceRef $resource
                A reference to an independent resource provided
                as an input to a task by the workflow runtime.

                Parameter @parameters
                Inputs that have the form of parameters with
                names and values.

                  Str $name
                  The name of the parameter.

                  Str $value
                  The value of the parameter.

                  Str $dataType
                  The data type of the parameter.

                StrOrProperty @environmentVars
                Inputs that have the form of parameters with
                names and values.

                Attachment $data
                Inputs that have the form of data.

                Property @properties
                Any additional properties as name-value pairs.

              Output @outputs
              Represents resources and data output from a task
              at runtime by executor or task commands.

                OutputType $type
                Describes the type of data output.

                resourceRef $source
                Either a referenceURL or a Reference are
                allowed.

                resourceRef $target
                Either a referenceURL or a Reference are
                allowed.

                resourceRef $resource
                Either a referenceURL or a Reference are
                allowed.

                Attachment $data
                Supporting material that helps in reproducing
                or understanding. This may include screenshots,
                payloads, and PoC exploit code.

                StrOrProperty @environmentVars
                Allow for a Property or a string

                Property @properties
                Any additional properties as name-value pairs.

              Property @properties
              Any additional properties as name-value pairs.

            ExecutionStep @steps
            The sequence of steps for the task.

              Str $name
              A name for the step.

              Str $description
              A description for the step.

              Command @commands
              Ordered list of commands or directives for the
              step.

                Str $executed
                A text representation of the executed command.

                Property @properties
                Any additional properties as name-value pairs.

              Property @properties
              Any additional properties as name-value pairs.

            Input @inputs
            Represents resources and data brought into a task
            at runtime by executor or task commands.

            Output @outputs
            Represents resources and data output from a task at
            runtime by executor or task commands

            DateTime $timeStart
            The date and time (timestamp) when the task
            started.

            DateTime $timeEnd
            The date and time (timestamp) when the task ended.

            Workspace @workspaces
            A set of named filesystem or data resource
            shareable by workflow tasks.

              bom-ref $bom-ref (required)
              An optional identifier which can be used to
              reference the workspace elsewhere in the BOM.

              Str $uid (required)
              The unique identifier for the resource instance
              within its deployment context.

              Str $name
              The name of the resource instance.

              Str @aliases
              The names for the workspace as referenced by
              other workflow tasks. Effectively, a name mapping
              so other tasks can use their own local name in
              their steps.

              Str $description
              A description of the resource instance.

              resourceRef @resourceReferences
              References to component or service resources that
              are used to realize the resource instance.

              AccessMode $accessMode
              Describes the read-write access Acontrol for the
              workspace relative to the owning resource
              instance.

              Str $mountPath
              A path to a location on disk where the workspace
              will be available to the associated task's steps.

              Str $managedDataType
              The name of a domain-specific data type the
              workspace represents.

              Str $volumeRequest
              Identifies the reference to the request for a
              specific volume type and parameters.

              Volume $volume
              Information about the actual volume instance
              allocated to the workspace.

                Str $uid
                The unique identifier for the volume instance
                within its deployment context.

                Str $name
                The name of the volume instance.

                VolumeMode $mode
                The mode for the volume instance.

                Str $path
                The underlying path created from the actual
                volume.

                Str $sizeAllocated
                The allocated size of the volume accessible to
                the associated workspace. This should include
                the scalar size as well as IEC standard unit in
                either decimal or binary form.

                Bool $persistent
                Indicates if the volume persists beyond the
                life of the resource it is associated with.

                Bool $remote
                Indicates if the volume is remotely (i.e.,
                network) attached.

                Property @properties
                Any additional properties as name-value pairs.

              Property @properties
              Any additional properties as name-value pairs.

            RuntimeTopology @runtimeTopology
            A graph of the component runtime topology for
            task's instance.

              Str $ref (required)
              References a component or service by its bom-ref
              attribute

              Str @dependsOn
              The bom-ref identifiers of the components or
              services that are dependencies of this dependency
              object.

              Str @provides
              The bom-ref identifiers of the components or
              services that define a given specification or
              standard, which are provided or implemented by
              this dependency object. For example, a
              cryptographic library which implements a
              cryptographic algorithm. A component which
              implements another component does not imply that
              the implementation is in use.

            Property @properties
            Any additional properties as name-value pairs.

          Dependency @taskDependencies
          The graph of dependencies between tasks within the
          workflow.

            bom-ref $ref
            References a component or service by its bom-ref
            attribute.

            bom-ref @dependsOn
            The bom-ref identifiers of the components or
            services that are dependencies of this dependency
            object.

            bom-ref @provides
            The bom-ref identifiers of the components or
            services that define a given specification or
            standard, which are provided or implemented by this
            dependency object. For example, a cryptographic
            library which implements a cryptographic algorithm.
            A component which implements another component does
            not imply that the implementation is in use.

          TaskActivity @taskTypes
          Indicates the types of activities performed by the
          set of workflow tasks.

          Trigger $trigger
          The trigger that initiated the task.

          ExecutionStep @steps
          The sequence of steps for the task.

          Input @inputs
          Represents resources and data brought into a task at
          runtime by executor or task commands.

          Input @outputs
          Represents resources and data output from a task at
          runtime by executor or task commands.

            resourceRef $source
            A reference to the component or service that
            provided the input to the task (e.g., reference to a
            service with data flow value of inbound)

            resourceRef $target
            A reference to the component or service that
            received or stored the input if not the task itself
            (e.g., a local, named storage workspace)

            resourceRef $resource
            A reference to an independent resource provided as
            an input to a task by the workflow runtime.

            Parameter @parameters
            Inputs that have the form of parameters with names
            and values.

            StrOrProperty @environmentVars
            Inputs that have the form of parameters with names
            and values.

            Attachment $data
            Inputs that have the form of data.

            Property @properties
            Any additional properties as name-value pairs.

          DateTime $timeStart
          The date and time (timestamp) when the task started.

          DateTime $timeEnd
          The date and time (timestamp) when the task ended.

          Workspace @worksSpaces
          A set of named filesystem or data resource shareable
          by workflow tasks.

            bom-ref $bom-ref (required)
            An optional identifier which can be used to
            reference the workspace elsewhere in the BOM.

            Str $uid (required)
            The unique identifier for the resource instance
            within its deployment context.

            Str $name
            The name of the resource instance.

            Str @aliases
            The names for the workspace as referenced by other
            workflow tasks. Effectively, a name mapping so other
            tasks can use their own local name in their steps.

            Str $description
            A description of the resource instance.

            resourceRef @resourceReferences
            References to component or service resources that
            are used to realize the resource instance.

            AccessMode $accessMode
            Describes the read-write access Acontrol for the
            workspace relative to the owning resource instance.

            Str $mountPath
            A path to a location on disk where the workspace
            will be available to the associated task's steps.

            Str $managedDataType
            The name of a domain-specific data type the
            workspace represents.

            Str $volumeRequest
            Identifies the reference to the request for a
            specific volume type and parameters.

            Volume $volume
            Information about the actual volume instance
            allocated to the workspace.

            Property @properties
            Any additional properties as name-value pairs.

          RuntimeTopology @runtimeTopology
          A graph of the component runtime topology for task's
          instance.

          Property @properties
          Any additional properties as name-value pairs.

        Property @properties
        Any additional properties as name-value pairs.

    - Declaration @declarations -----------------------------------
      The list of declarations which describe the conformance
      to standards. Each declaration may include attestations,
      claims, and evidence.

        Assessor @assessors
        The list of assessors evaluating claims and determining
        conformance to requirements and confidence in that
        assessment.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the object elsewhere in the BOM.

          Bool $thirdParty
          The boolean indicating if the assessor is outside the
          organization generating claims. A value of false
          indicates a self assessor.

          Organization $organization
          The entity issuing the assessment.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the object elsewhere in the BOM.

            Str $name
            The name of the organization.

            Address $address
            The physical address (location) of the
            organization.

            URL @url
            The URL of the organization. Multiple URLs are
            allowed.

            Contact @contact
            A contact at the organization. Multiple contacts
            are allowed.

        Attestation @attestations
        The list of attestations asserted by an assessor that
        maps requirements to claims.

          Str $summary
          The short description explaining the main points of
          the attestation.

          bom-ref $assessor
          The bom-ref to the assessor asserting the
          attestation.

          RequirementGrouping @map
          The grouping of requirements to claims and the
          attestors declared conformance and confidence thereof.

            bom-ref $requirement
            The bom-ref to the requirement being attested to.

            bom-ref @claims
            The list of bom-ref to the claims being attested
            to.

            bom-ref @counterClaims
            The list of bom-ref to the counter claims being
            attested to.

            Conformance $conformance
            The conformance of the claim meeting a requirement.

              conformanceValue $score
              The conformance of the claim between and
              inclusive of 0 and 1, where 1 is 100% conformance.

              Str $rationale
              The rationale for the conformance score.

              bom-ref @mitigationStrategies
              The list of bom-ref to the evidence provided
              describing the mitigation strategies.

            Confidence $confidence
            The confidence of the claim meeting a requirement.

              confidenceValue $score
              The confidence of the claim between and inclusive
              of 0 and 1, where 1 is 100% confidence.

              Str $rationale
              The rationale for the confidence score.

          ValidSignature $signature
          Enveloped signature in JSON Signature Format (JSF).

        Claim @claims
        The list of claims.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the object elsewhere in the BOM.

          bom-ref $target
          The bom-ref to a target representing a specific
          system, application, API, module, team, person,
          process, business unit, company, etc... that this
          claim is being applied to.

          Str $predicate
          The specific statement or assertion about the target.

          bom-ref @mitigatinStrategies
          The list of bom-ref to the evidence provided
          describing the mitigation strategies. Each mitigation
          strategy should include an explanation of how any
          weaknesses in the evidence will be mitigated.

          Str $reasoning
          The written explanation of why the evidence provided
          substantiates the claim.

          bom-ref @evidence
          The list of bom-ref to evidence that supports this
          claim.

          bom-ref @counterEvidence
          The list of bom-ref to counter evidence that supports
          this claim.

          Reference @externalReferences
          External references provide a way to document
          systems, sites, and information that may be relevant
          but are not included with the BOM. They may also
          establish specific relationships within or external to
          the BOM.

          ValidSignature $signature
          Enveloped signature in JSON Signature Format (JSF).

        DeclarationEvidence $evidence
        The list of evidence.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the object elsewhere in the BOM.

          propertyName $propertyName
          The reference to the property name as defined in the
          CycloneDX Property Taxonomy.

          Str $description
          The written description of what this evidence is and
          how it was created.

          EvidenceDataset @data
          The output or analysis that supports claims.

            Str $name
            The name of the data.

            DataContents $contents
            The contents or references to the contents of the
            data being described.

            Str $classification
            Data classification tags data according to its
            type, sensitivity, and value if altered, stolen, or
            destroyed.

            Str @sensitiveData
            A description of any sensitive data included.

            Governance $governance
            Data governance captures information regarding data
            ownership, stewardship, and custodianship, providing
            insights into the individuals or entities
            responsible for managing, overseeing, and
            safeguarding the data throughout its lifecycle.

          DateTime $created
          The date and time (timestamp) when the evidence was
          created.

          DateTime $expires
          The date and time (timestamp) when the evidence is no
          longer valid.

          Contact $author
          The author of the evidence.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the person elsewhere in the BOM.

            Str $name
            The name of a contact.

            email $email
            The email address of the contact.

            Str $phone
            The phone number of the contact.

          Contact $reviewer
          The reviewer of the evidence.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the person elsewhere in the BOM.

            Str $name
            The name of a contact.

            email $email
            The email address of the contact.

            Str $phone
            The phone number of the contact.

          ValidSignature $signature
          Enveloped signature in JSON Signature Format (JSF).

        Target @targets
        The list of targets which claims are made against.

          Organization @organizations
          The list of organizations which claims are made
          against.

          Component @components
          The list of components which claims are made against.

          Service @services
          The list of services which claims are made against.

        Affirmation $affirmation
        A concise statement affirmed by an individual regarding
        all declarations, often used for third-party auditor
        acceptance or recipient acknowledgment. It includes a
        list of authorized signatories who assert the validity
        of the document on behalf of the organization.

          Str $statement
          The brief statement affirmed by an individual
          regarding all declarations. This could be an
          affirmation of acceptance by a third-party auditor or
          receiving individual of a file.

          Signatory @signatories
          The list of signatories authorized on behalf of an
          organization to assert validity of this document.

            Str $name
            The signatory's name.

            Str $role
            The signatory's role within an organization.

            ValidSignature $signature
            Enveloped signature in JSON Signature Format (JSF).

            Organization $organization
            The signatory's organization.

            Reference $externalReference
            External references provide a way to document
            systems, sites, and information that may be relevant
            but are not included with the BOM. They may also
            establish specific relationships within or external
            to the BOM.

              referenceURL $url (required)
              The URI (URL or URN) to the external reference.
              External references are URIs and therefore can
              accept any URL scheme including https (RFC-7230),
              mailto (RFC-2368), tel (RFC-3966), and dns
              (RFC-4501). External references may also include
              formally registered URNs such as CycloneDX
              BOM-Link to reference CycloneDX BOMs or any object
              within a BOM. BOM-Link transforms applicable
              external references into relationships that can be
              expressed in a BOM or across BOMs.

              Str $comment
              An optional comment describing the external
              reference.

              ReferenceSource $type (required)
              Specifies the type of external reference.

              HashedString @hashes
              The hashes of the external reference (if
              applicable).

          ValidSignature $signature
          Enveloped signature in JSON Signature Format (JSF).

        ValidSignature $signature
        Enveloped signature in JSON Signature Format (JSF).

    - Definition @definitions -------------------------------------
      A collection of reusable objects that are defined and may
      be used elsewhere in the BOM.

        Standard @standards
        The list of standards which may consist of regulations,
        industry or organizational-specific standards, maturity
        models, best practices, or any other requirements which
        can be evaluated against or attested to.

          bom-ref $bom-ref
          An optional identifier which can be used to reference
          the object elsewhere in the BOM.

          Str $name
          The name of the standard. This will often be a
          shortened, single name of the standard.

          Str $version
          The version of the standard.

          Str $description
          The description of the standard.

          Str $owner
          The owner of the standard, often the entity
          responsible for its release.

          Requirement @requirements
          The list of requirements comprising the standard.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the object elsewhere in the BOM.

            Str $identifier
            The unique identifier used in the standard to
            identify a specific requirement. This should match
            what is in the standard and should not be the
            requirements bom-ref.

            Str $title
            The title of the requirement.

            Str $text
            The textual content of the requirement.

            Str @descriptions
            The supplemental text that provides additional
            guidance or context to the requirement, but is not
            directly part of the requirement.

            CRE @openCRE
            The Common Requirements Enumeration (CRE)
            identifier(s).

            bom-ref $parent
            The optional bom-ref to a parent requirement. This
            establishes a hierarchy of requirements. Top-level
            requirements must not define a parent. Only child
            requirements should define parents.

            Property @properties
            Any additional properties as name-value pairs.

            Reference @externalReferences
            External references provide a way to document
            systems, sites, and information that may be relevant
            but are not included with the BOM. They may also
            establish specific relationships within or external
            to the BOM.

          RequirementLevel @levels
          The list of levels associated with the standard. Some
          standards have different levels of compliance.

            bom-ref $bom-ref
            An optional identifier which can be used to
            reference the object elsewhere in the BOM.

            Str $identifier
            The identifier used in the standard to identify a
            specific level.

            Str $title
            The title of the requirement.

            Str $description
            The description of the requirement.

            bom-ref @requirements
            The list of requirement bom-refs that comprise the
            level.

          Reference @externalReferences
          External references provide a way to document
          systems, sites, and information that may be relevant
          but are not included with the BOM. They may also
          establish specific relationships within or external to
          the BOM.

          ValidSignature $signature
          Enveloped signature in JSON Signature Format (JSF).

    - Property @properties ----------------------------------------
      Any additional properties as name-value pairs.

    - ValidSignature $signature -----------------------------------
      Enveloped signature in JSON Signature Format (JSF).

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

