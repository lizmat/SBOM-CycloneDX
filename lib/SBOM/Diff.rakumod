use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Diff:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Attachment $.text;
    has URL        $.url;
}

# vim: expandtab shiftwidth=4
