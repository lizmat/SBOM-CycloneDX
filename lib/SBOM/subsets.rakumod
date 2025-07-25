use Email::Valid:ver<1.0.7+>:auth<zef:demayl>;
use PURL:ver<0.0.6+>:auth<zef:lizmat>;

my token hexnum { <[0..9 a..f]> }
#| Every BOM generated SHOULD have a unique serial number, even if the
#| contents of the BOM have not changed over time. If specified, the
#| serial number must conform to RFC 4122. Use of serial numbers is
#| recommended.  Must match regular expression:
#| ^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$
subset serialNumber of Str where *.contains:
  /^ 'urn:uuid:' <hexnum> ** 8
     '-'         <hexnum> ** 4
     '-'         <hexnum> ** 4
     '-'         <hexnum> ** 4
     '-'         <hexnum> ** 12
  $/;

#| Identifier which can be used to reference a component in the BOM.
#| Every bom-ref must be unique within the BOM. Must be at least 1
#| characters long.
subset bom-ref of Str where {
    if .chars && !.starts-with('urn:cdx') {
        with %*BOM-REFS -> %bom-refs {
            %bom-refs{$_} := Nil;
        }
        True
    }
}

#| A numeric value.
subset number of Cool where Int | Rat;

#| An email address.
subset email of Str where {
    state $email = Email::Valid.new(:simple);
    $email.validate($_)
}

#| A URL.
subset URL of Str;  # XXX fetch URL rules

#| A CPE must conform to the CPE 2.2 or 2.3 specification. See
#| https://nvd.nist.gov/products/cpe.
subset CPE of Str where *.starts-with('cpe:');
# XXX fetch from https://nvd.nist.gov/products/cpe

#| A Common Requirements Enumeration (CRE) identifier. CRE is a
#| structured and standardized framework for uniting security standards
#| and guidelines. CRE links each section of a resource to a shared
#| topic identifier (a Common Requirement). Through this shared topic
#| link, all resources map to each other. Use of CRE promotes clear and
#| unambiguous communication among stakeholders.
subset CRE of Str where *.contains: /^ 'CRE:' <[0..9]>+ '-' <[0..9]>+ $/;

#| A package-url (purl). The purl, if specified, must be valid and conform
#| to the specification defined at: https://github.com/package-url/purl-spec.
subset purl of Str where { PURL($_) }

#| An OmniBOR Artifact ID. The OmniBOR, if specified, must be valid and
#| conform to the specification defined at:
#| https://www.iana.org/assignments/uri-schemes/prov/gitoid.
subset omniborId of Str;  # XXX fetch from https://www.iana.org/assignments/uri-schemes/prov/gitoid

#| A Software Heritage persistent identifier (SWHID). The SWHID, if
#| specified, must be valid and conform to the specification defined at:
#| https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
subset SWHID of Str;  # XXX fetch from https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html

#| A reference to the property name as defined in the CycloneDX
#| Property Taxonomy.
subset propertyName of Str;  # XXX fetch from https://github.com/CycloneDX/cyclonedx-property-taxonomy/

my token mime-part { <[-+ a..z 0..9 ]>+ }
#| A MIME-type.  Must match regular expression: ^[-+a-z0-9.]+/[-+a-z0-9.]+$
subset mime-type of Str where *.contains: /^ <mime-part> '/' <mime-part> $/;

#| The value of a hash.  Must match regular expression:
#| ^([a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64}|[a-fA-F0-9]{96}|[a-fA-F0-9]{128})$.
subset contentHash of Str where {
  .contains(/^ <[0..9 a..f A..F]>+ $/)
    && .chars == 32 | 40 | 64 | 96 | 128
}

#| A bomlink to an external document.
subset bomLinkDocument of Str where *.contains:
  /^ 'urn:cdx:' <hexnum> ** 8
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 12
     '/'        <[ 1..9 ]> <[ 0..9 ]>*
  $/;

#| A bomlink to an element.
subset bomLinkElement of Str where *.contains:
  /^ 'urn:cdx:' <hexnum> ** 8
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 12
     '/'        <[ 1..9 ]> <[ 0..9 ]>* '#' .+
  /;

#| Identifier for referable and therefore interlinkable elements.  Value
#| SHOULD not start with the BOM-Link intro 'urn:cdx:' to avoid conflicts
#| |with BOM-Links.
subset IDnotbomLink of Str where !*.starts-with('urn:cdx:');

#| Reference that is either a bom-ref or a bomLinkElement
subset bom-refOrLink of Str where bom-ref | bomLinkElement;

#| Either a URL, a bomLinkDocument or a bomLinkElement.
subset referenceURL of Str where
  URL | bomLinkDocument | bomLinkElement;

#| The ISO-639 (or higher) language code and optional ISO-3166 (or
#| higher) country code. Examples include: "en", "en-US", "fr" and
#| "fr-CA".  Must match regular expression: ^([a-z]{2})(-[A-Z]{2})?$.
subset locale of Str where *.contains: /^ <[a..z]> ** 2 ['-' <[A..Z]> ** 2]? $/;

#| The confidence value between and inclusive of 0 and 1, where 1 is
#| 100% confidence.
subset confidenceValue of Cool where 0 <= * <= 1;

#| The conformance value between and inclusive of 0 and 1, where 1 is
#| 100% conformant.
subset conformanceValue of Numeric where 0 <= * <= 1;

#| A positive integer value (> 0).
subset PositiveInt of Int where * > 0;

#| The NIST security strength category as defined in
#| https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria).
#| A value of 0 indicates that none of the categories are met.
subset nistQuantumSecurityLevel of Int where 0 <= * <= 6;

#| A version range specified in Package URL Version Range syntax (vers)
#| which is defined at
#| https://github.com/package-url/purl-spec/blob/master/VERSION-RANGE-SPEC.rst
subset versionRange of Str where 0 < *.chars <= 4096;  # XXX needs refinement

#| A version should ideally comply with semantic versioning but is not
#| enforced. Must be at most 1024 characters long.
subset versionString of Str where 0 < *.chars <= 1024;

#- EXPORT ----------------------------------------------------------------------
my sub EXPORT(*@names) {
    @names ||= <
      bomLinkDocument bomLinkElement bom-ref bom-refOrLink
      confidenceValue conformanceValue contentHash CPE CRE email
      IDnotbomLink locale mime-type nistQuantumSecurityLevel number
      omniborId PositiveInt purl referenceURL serialNumber SWHID URL
      versionRange versionString
    >;
    Map.new: @names.map: {
        if UNIT::{$_}:exists {
            UNIT::{$_}:p
        }
        else {
            my ($in,$out) = .split(':', 2);
            if $out && UNIT::{"$in"} -> $enum {
                Pair.new: "$out", $enum
            }
        }
    }
}

# vim: expandtab shiftwidth=4
