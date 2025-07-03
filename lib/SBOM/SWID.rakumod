use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::SWID:ver<0.0.1>:auth<zef:lizmat> {
    has Str:D      $.tagID is required;
    has Str:D      $.name  is required;
    has Str:D      $.version    = "0.0";
    has Int:D      @.tagVersion = 1;
    has Bool:D     $.patch      = False;
    has SBOM::Text $.text;
    has URL        $.url;
}

# vim: expandtab shiftwidth=4
