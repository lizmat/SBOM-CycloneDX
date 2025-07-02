use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <externalReferenceURL>;

use SBOM::Hash:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ReferenceType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Reference:ver<0.0.1>:auth<zef:lizmat> {
    has externalReferenceURL  $.url  is required;
    has externalReferenceType $.type is required;
    has Str                   $.comment;
    has SBOM::Hash            @.hashes;
}

# vim: expandtab shiftwidth=4
