use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Component Scope
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref CPE mime-type omniborId PURL SWHID
>;

use SBOM::Commit:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CryptoProperties:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Dataset:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Evidence:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Hash:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ModelCard:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Patch:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ReleaseNotes:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::SWID:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Pedigree { ... }

class SBOM::Component:ver<0.0.1>:auth<zef:lizmat> {
    has Str                    $.name is required;
    has Scope                  $.scope = SBOM::ScopeType("required");
    has Str                    $.version;
    has Str                    $.description;
    has Component              $.type;
    has mime-type              $.mime-type;
    has bom-ref                $.bom-ref;
    has SBOM::Organization     $.supplier;
    has SBOM::Organization     $.manufacturer;
    has SBOM::Contact          @.authors;
    has Str                    $.publisher;
    has SBOM::Hash             @.hashes;
    has SBOM::AnyLicense       @.licenses;
    has Str                    $.copyright;
    has CPE                    $.cpe;
    has PURL                   $.purl;
    has omniborId              @.omniborId;
    has SWHID                  @.swhid;
    has SBOM::SWID             $.swid;
    has Bool                   $.modified;
    has SBOM::Pedigree         $.pedigree;
    has SBOM::Reference        @.externalReferences;
    has SBOM::Component        @.components;
    has SBOM::Evidence         $.evidence;
    has SBOM::ReleaseNotes     $.releaseNotes;
    has SBOM::ModelCard        $.modelCard;
    has SBOM::Dataset          @.data;
    has SBOM::CryptoProperties $.cryptoProperties;
    has SBOM::NameValue        @.properties;
    has Str                    @.tags;
    has SBOM::ValidSignature   $.signature;

    submethod TWEAK(:$author) {
        die q/'data' can only be specified if the 'type' is "data"/
          if @!data && $!type.name ne 'data';

        @!authors.push($author) if $author;

        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);
    }
}

class SBOM::Pedigree:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Component   @.ancestors;
    has SBOM::Component   @.descendants;
    has SBOM::Component   @.variants;
    has SBOM::Commit      @.commits;
    has SBOM::Patch       @.patches;
    has Str               $.notes;
}

# vim: expandtab shiftwidth=4
