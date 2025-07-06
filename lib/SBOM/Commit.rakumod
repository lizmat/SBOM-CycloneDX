use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Development:ver<0.0.1>:auth<zef:lizmat>;

#| Specifies an individual commit.
class SBOM::Commit:ver<0.0.1>:auth<zef:lizmat> {

#| A unique identifier of the commit. This may be version control
#| specific. For example, Subversion uses revision numbers whereas
#| git uses commit hashes.
    has Str $.uid;

#| The URL to the commit. This URL will typically point to a commit
#| in a version control system.
    has URL $.url;

#| The author who created the changes in the commit.
    has SBOM::Development $.author;

#| The person who committed or pushed the commit.
    has SBOM::Development $.committer;

#| The text description of the contents of the commit.
    has Str $.message;
}

# vim: expandtab shiftwidth=4
