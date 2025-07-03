use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Diff:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Text $.text;
    has URL        $.url;
}

# vim: expandtab shiftwidth=4
