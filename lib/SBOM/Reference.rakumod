use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <referenceURL>;

use SBOM::Hash:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ReferenceType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Reference:ver<0.0.1>:auth<zef:lizmat> {
    has referenceURL        $.url  is required;
    has Str                 $.comment;
    has SBOM::ReferenceType $.type is required;
    has SBOM::Hash          @.hashes;
}

# vim: expandtab shiftwidth=4
