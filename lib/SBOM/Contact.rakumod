use SBOM::Subsets:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Contact:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref $.bom-ref;
    has Str     $.name;
    has email   $.email;
    has Str     $.phone;
}

# vim: expandtab shiftwidth=4
