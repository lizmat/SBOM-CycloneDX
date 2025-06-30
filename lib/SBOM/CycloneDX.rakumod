use SBOM::CycloneDX::Phase:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CycloneDX::ReferenceType:ver<0.0.1>:auth<zef:lizmat>;

#- subsets ---------------------------------------------------------------------
# Serial number conforming to RFC 4122
my token hexnum { <[0..9 a..f]> }
subset serialNumber of Str where *.contains:
  /^ 'urn:uuid:' <.hexnum> ** 8
     '-'         <.hexnum> ** 4
     '-'         <.hexnum> ** 4
     '-'         <.hexnum> ** 4
     '-'         <.hexnum> ** 12
  $/;

# Identifier which can be used to reference a component in the BOM.
# Every bom-ref must be unique within the BOM.
subset bom-ref of Str where { .chars && !.starts-with('urn:cdx') }

enum algorithmHash <
  MD5 SHA-1 SHA-256 SHA-384 SHA-512 SHA3-256 SHA3-384 SHA3-512
  BLAKE2b-256 BLAKE2b-384 BLAKE2b-512 BLAKE3
>;
subset contentHash of Str where {
  .contains(/^ <[0..9 a..f A..F]>+ $/)
    && .chars == 32 | 40 | 64 | 128
}
subset referenceURL of Str;  # XXX fetch URL rules
subset bomLinkDocument of Str where *.contains:
  /^ 'urn:cdx:' <.hexnum> ** 8
     '-'        <.hexnum> ** 4
     '-'        <.hexnum> ** 4
     '-'        <.hexnum> ** 4
     '-'        <.hexnum> ** 12
     '/'        <[ 1..9 ]> <[ 0..9 ]>*
  $/;
subset bomLinkElement of Str where *.contains:
  /^ 'urn:cdx:' <.hexnum> ** 8
     '-'        <.hexnum> ** 4
     '-'        <.hexnum> ** 4
     '-'        <.hexnum> ** 4
     '-'        <.hexnum> ** 12
     '/'        <[ 1..9 ]> <[ 0..9 ]>* '#' .+
  /;

subset externalReferenceURL of Str
  where referenceURL | bomLinkDocument | bomLinkElement;

class SBOM::CycloneDX::Hash:ver<0.0.1>:auth<zef:lizmat> {
    has algorithmHash $.alg     is required;
    has contentHash   $.content is required;
}

class SBOM::CycloneDX::Reference:ver<0.0.1>:auth<zef:lizmat> {
    has externalReferenceURL  $.url  is required;
    has externalReferenceType $.type is required;
    has Str                   $.comment;
    has SBOM::CycloneDX::Hash @.hashes;
}

class SBOM::CycloneDX::Component:ver<0.0.1>:auth<zef:lizmat> {
}

class SBOM::CycloneDX::Tool:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::CycloneDX::Component @.components;
}

class SBOM::CycloneDX::LegacyTool:ver<0.0.1>:auth<zef:lizmat> {
    has Str                        $.vendor;
    has Str                        $.name;
    has Str                        $.version;
    has SBOM::CycloneDX::Hash      @.hashes;
    has SBOM::CycloneDX::Reference @.externalReferences
}

#-------------------------------------------------------------------------------
class SBOM::CycloneDX::Metadata:ver<0.0.1>:auth<zef:lizmat> {
    has DateTime               $.timestamp = DateTime.now;
    has SBOM::CycloneDX::Phase @.lifecycles;
    has                        $.tools;

    method TWEAK(:$tools) {
        die "improper tool"
          unless $tools ~~ SBOM::CycloneDX::LegacyTool
            || ($tools ~~ Positional && $tools.are(SBOM::CycloneDX::Tool))
    }
}

#-------------------------------------------------------------------------------
class SBOM::CycloneDX:ver<0.0.1>:auth<zef:lizmat> {
    has serialNumber $.serialNumber;
    has Int          $.version = 1;
    has Metadata     $.metadata;

    method bomFormat()   { "CycloneDX" }
    method specVersion() { v1.6        }

    method updated() { ++$!version }
}

# vim: expandtab shiftwidth=4
