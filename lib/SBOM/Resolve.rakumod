use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <URL>;

use SBOM::ResolveType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Source:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Resolve:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::ResolveType $.type is required;
    has Str               $.id;
    has Str               $.name;
    has Str               $.description;
    has SBOM::Source      $.source;
    has URL               @.references;
}

# vim: expandtab shiftwidth=4
