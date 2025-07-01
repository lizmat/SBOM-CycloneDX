use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;

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
subset OmniborID of Str;  # XXX fetch from https://www.iana.org/assignments/uri-schemes/prov/gitoid
subset SWHID     of Str;  # XXX fetch from https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html

# A MIME-type
my token mime-part { <[-+ a..z 0..9 ]>+ }
subset mime-type of Str where *.contains: /^ <mime-part> '/' <mime-part> $/;

# fetched from https://raw.githubusercontent.com/spdx/license-list-data/refs/heads/main/json/licenses.json
enum licenseId (
  BEGIN from-json(
    %?RESOURCES<licenses.json>.open.slurp(:close)
  )<licenses>.map({ "license" ~ .<licenseId> }).List
);

enum algorithmHash <
  MD5 SHA-1 SHA-256 SHA-384 SHA-512 SHA3-256 SHA3-384 SHA3-512
  BLAKE2b-256 BLAKE2b-384 BLAKE2b-512 BLAKE3
>;
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

subset externalReferenceURL of Str
  where URL | bomLinkDocument | bomLinkElement;

# vim: expandtab shiftwidth=4
