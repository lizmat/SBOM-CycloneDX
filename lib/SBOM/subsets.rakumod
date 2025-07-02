# Serial number conforming to RFC 4122
my token hexnum { <[0..9 a..f]> }
subset serialNumber of Str where *.contains:
  /^ 'urn:uuid:' <hexnum> ** 8
     '-'         <hexnum> ** 4
     '-'         <hexnum> ** 4
     '-'         <hexnum> ** 4
     '-'         <hexnum> ** 12
  $/;

# Identifier which can be used to reference a component in the BOM.
# Every bom-ref must be unique within the BOM.
subset bom-ref of Str where { .chars && !.starts-with('urn:cdx') }

subset email     of Str;  # XXX to be done
subset URL       of Str;  # XXX fetch URL rules
subset CPE       of Str;  # XXX fetch from https://nvd.nist.gov/products/cpe
subset PURL      of Str;  # XXX fetch from https://github.com/package-url/purl-spec
subset omniborId of Str;  # XXX fetch from https://www.iana.org/assignments/uri-schemes/prov/gitoid
subset SWHID     of Str;  # XXX fetch from https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html

# A MIME-type
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

#- EXPORT ----------------------------------------------------------------------
my sub EXPORT(*@names) {
    @names ||= <
      bomLinkDocunment bomLinkElement bom-ref confidenceValue contentHash
      CPE email referenceURL locale mime-type omniborId PositiveInt PURL
      serialNumber SWHID URL
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
