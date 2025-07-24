use SBOM::enums:ver<0.0.8>:auth<zef:lizmat> <
  ResolveType
>;

use SBOM::subsets:ver<0.0.8>:auth<zef:lizmat> <
  URL
>;

use SBOM:ver<0.0.8>:auth<zef:lizmat>;
use SBOM::Source:ver<0.0.8>:auth<zef:lizmat>;

#- Resolve ---------------------------------------------------------------------
#| An issue that has been resolved.
class SBOM::Resolve:ver<0.0.8>:auth<zef:lizmat> does SBOM {

#| Specifies the type of issue.
    has ResolveType $.type is required;

#| The identifier of the issue assigned by the source of the issue.
    has Str $.id;

#| The name of the issue.
    has Str $.name;

#| A description of the issue.
    has Str $.description;

#| The source of the issue where it is documented.
    has SBOM::Source $.source;

#| A collection of URL's for reference. Multiple URLs are allowed.
    has URL @.references;

    # These should probably be auto-generated in RakUAST at some point
    method references(SBOM::Resolve:D:) { @!references.List }
}

# vim: expandtab shiftwidth=4
