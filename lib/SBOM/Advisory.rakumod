use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

class SBOM::Advisory:ver<0.0.1>:auth<zef:lizmat> {
    has Str $.title;
    has URL $.url is required;
}

# vim: expandtab shiftwidth=4
