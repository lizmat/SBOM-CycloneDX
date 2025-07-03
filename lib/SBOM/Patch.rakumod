use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Patch
>;

use SBOM::Diff:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Resolve:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Patch:ver<0.0.1>:auth<zef:lizmat> {
    has Patch         $.type is required;
    has SBOM::Diff    $.diff;
    has SBOM::Resolve @.resolves;
}

# vim: expandtab shiftwidth=4
