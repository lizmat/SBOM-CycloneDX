use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

#| An advisory of a vulnerability.
class SBOM::Advisory:ver<0.0.1>:auth<zef:lizmat> {

#| An optional name of the advisory.
    has Str $.title;

#| Location where the advisory can be obtained.
    has URL $.url is required;
}

# vim: expandtab shiftwidth=4
