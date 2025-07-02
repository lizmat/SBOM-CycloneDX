use SBOM::enums:ver<0.0.1>:auth<zef:lizmat>
  <releaseType>;
use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <URL>;

use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Note:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Resolve:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ReleaseNotes:ver<0.0.1>:auth<zef:lizmat> {
    has releaseType     $.type is required;
    has Str             $.title;
    has URL             $.featuredImage;
    has URL             $.socialImage;
    has Str             $.descrption;
    has DateTime        $.timestamp;
    has Str             @.aliases;
    has Str             @.tags;
    has SBOM::Resolve   @.resolves;
    has SBOM::Note      @.notes;
    has SBOM::NameValue @.properties;
}

# vim: expandtab shiftwidth=4
