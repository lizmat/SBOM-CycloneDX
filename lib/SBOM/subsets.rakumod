# Serial number conforming to RFC 4122
my token hexnum { <[0..9 a..f]> }
#| Every BOM generated SHOULD have a unique serial number, even if the contents of the BOM have not changed over time. If specified, the serial number must conform to RFC 4122. Use of serial numbers is recommended.  Must match regular expression: ^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$
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
subset bom-ref of Str where { .chars && !.starts-with('urn:cdx') }

subset email     of Str;  # XXX to be done
subset URL       of Str;  # XXX fetch URL rules

#| A CPE must conform to the CPE 2.2 or 2.3 specification. See
#| https://nvd.nist.gov/products/cpe.
subset CPE       of Str;  # XXX fetch from https://nvd.nist.gov/products/cpe

#| A package-url (purl). The purl, if specified, must be valid and conform
#| to the specification defined at: https://github.com/package-url/purl-spec.
subset PURL      of Str;  # XXX fetch from https://github.com/package-url/purl-spec

#| An OmniBOR Artifact ID. The OmniBOR, if specified, must be valid and
#| conform to the specification defined at:
#| https://www.iana.org/assignments/uri-schemes/prov/gitoid.
subset omniborId of Str;  # XXX fetch from https://www.iana.org/assignments/uri-schemes/prov/gitoid

#| A Software Heritage persistent identifier (SWHID). The SWHID, if
#| specified, must be valid and conform to the specification defined at:
#| https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html.
subset SWHID     of Str;  # XXX fetch from https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html

#| A MIME-type.  Must match regular expression: ^[-+a-z0-9.]+/[-+a-z0-9.]+$
my token mime-part { <[-+ a..z 0..9 ]>+ }
subset mime-type of Str where *.contains: /^ <mime-part> '/' <mime-part> $/;

subset contentHash of Str where {
  .contains(/^ <[0..9 a..f A..F]>+ $/)
    && .chars == 32 | 40 | 64 | 128
}
subset bomLinkDocument of Str where *.contains:
  /^ 'urn:cdx:' <hexnum> ** 8
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 12
     '/'        <[ 1..9 ]> <[ 0..9 ]>*
  $/;
subset bomLinkElement of Str where *.contains:
  /^ 'urn:cdx:' <hexnum> ** 8
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 4
     '-'        <hexnum> ** 12
     '/'        <[ 1..9 ]> <[ 0..9 ]>* '#' .+
  /;

subset referenceURL of Str
  where URL | bomLinkDocument | bomLinkElement;

subset locale of Str where *.contains: /^ <[a..z]> ** 2 ['-' <[A..Z]> ** 2]? $/;

subset confidenceValue of Rat where 0 < * < 1;

subset PositiveInt of Int where * > 0;

subset nistQuantumSecurityLevel of Int where 0 <= * <= 6;

#| A version should ideally comply with semantic versioning but is noti
#| enforced. Must be at most 1024 characters long.
subset versionString of Str where 0 < *.chars <= 1024;

#- EXPORT ----------------------------------------------------------------------
my sub EXPORT(*@names) {
    @names ||= <
      bomLinkDocunment bomLinkElement bom-ref confidenceValue contentHash
      CPE email referenceURL locale mime-type nistQuantumSecurityLevel
      omniborId PositiveInt PURL serialNumber SWHID URL versionString
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
