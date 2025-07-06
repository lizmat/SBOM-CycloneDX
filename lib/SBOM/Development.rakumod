use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  email
>;

#| An action during development, such as a commit.
class SBOM::Development:ver<0.0.1>:auth<zef:lizmat> {

#| The timestamp in which the action occurred.
    has DateTime $.timestamp;

#| The name of the individual who performed the action.
    has Str $.name;

#| The email address of the individual who performed the action.
    has email $.email;
}

# vim: expandtab shiftwidth=4
