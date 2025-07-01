use SBOM::Subsets:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Hash:ver<0.0.1>:auth<zef:lizmat> {
    has algorithmHash $.alg     is required;
    has contentHash   $.content is required;
}

# vim: expandtab shiftwidth=4
