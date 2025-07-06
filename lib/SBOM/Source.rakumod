use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

#| Defines a source of documentation, e.g. about vulnerabilities.
class SBOM::Source:ver<0.0.1>:auth<zef:lizmat> {

#| The url of documentation as provided by the source.
    has URL $.url;

#| The name of the source.
    has Str $.name;
}

# vim: expandtab shiftwidth=4
