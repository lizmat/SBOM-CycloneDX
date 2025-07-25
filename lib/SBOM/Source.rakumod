use SBOM::subsets:ver<0.0.9>:auth<zef:lizmat> <
  URL
>;

use SBOM:ver<0.0.9>:auth<zef:lizmat>;

#- Source ----------------------------------------------------------------------
#| Defines a source of documentation, e.g. about vulnerabilities.
class SBOM::Source:ver<0.0.9>:auth<zef:lizmat> does SBOM {

#| The url of documentation as provided by the source.
    has URL $.url;

#| The name of the source.
    has Str $.name;
}

# vim: expandtab shiftwidth=4
