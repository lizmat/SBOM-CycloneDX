use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  ResolveType
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Source:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Resolve:ver<0.0.1>:auth<zef:lizmat> {
    has ResolveType  $.type is required;
    has Str          $.id;
    has Str          $.name;
    has Str          $.description;
    has SBOM::Source $.source;
    has URL          @.references;
}

# vim: expandtab shiftwidth=4
