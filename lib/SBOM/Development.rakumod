use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  email
>;

class SBOM::Development:ver<0.0.1>:auth<zef:lizmat> {
    has DateTime $.timestamp;
    has Str      $.name;
    has email    $.email;
}

# vim: expandtab shiftwidth=4
