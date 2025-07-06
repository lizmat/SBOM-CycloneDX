use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Patch
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Resolve:ver<0.0.1>:auth<zef:lizmat>;

#- Diff ------------------------------------------------------------------------
#| The patch file (or diff) that shows changes. Refer to
#| https://en.wikipedia.org/wiki/Diff
class SBOM::Diff:ver<0.0.1>:auth<zef:lizmat> {

#| Specifies the optional text of the diff.
    has SBOM::Attachment $.text;

#| Specifies the URL to the diff.
    has URL $.url;
}

#- Patch -----------------------------------------------------------------------
#| Specifies an individual patch
class SBOM::Patch:ver<0.0.1>:auth<zef:lizmat> {

#| Specifies the purpose for the patch including the resolution of
#| defects, security issues, or new behavior or functionality.
    has Patch $.type is required;

#| The patch file (or diff) that shows changes. Refer to
#| https://en.wikipedia.org/wiki/Diff
    has SBOM::Diff $.diff;

#| A collection of issues the patch resolves.
    has SBOM::Resolve @.resolves;
}

# vim: expandtab shiftwidth=4
