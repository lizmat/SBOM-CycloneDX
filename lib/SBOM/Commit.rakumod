use SBOM::subsets:ver<0.0.5>:auth<zef:lizmat> <
  email URL
>;

use SBOM:ver<0.0.5>:auth<zef:lizmat>;

#- Development -----------------------------------------------------------------
#| An action during development, such as a commit.
class SBOM::Development:ver<0.0.5>:auth<zef:lizmat> does SBOM {

#| The timestamp in which the action occurred.
    has DateTime $.timestamp;

#| The name of the individual who performed the action.
    has Str $.name;

#| The email address of the individual who performed the action.
    has email $.email;
}

#- Commit ----------------------------------------------------------------------
#| Specifies an individual commit.
class SBOM::Commit:ver<0.0.5>:auth<zef:lizmat> does SBOM {

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
