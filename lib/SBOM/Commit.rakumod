use SBOM::Development:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Subsets:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Commit:ver<0.0.1>:auth<zef:lizmat> {
    has Str               $.uid;
    has URL               $.url;
    has SBOM::Development $.author;
    has SBOM::Development $.committer;
    has Str               $.message;
}

# vim: expandtab shiftwidth=4
