use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;
use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::LicenseType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
# fetched from https://raw.githubusercontent.com/spdx/license-list-data/refs/heads/main/json/licenses.json
BEGIN SBOM::LicenseType.setup(
  from-json(
    %?RESOURCES<licenses.json>.open.slurp(:close)
  )<licenses>.map(*.<licenseId name>)
);

# vim: expandtab shiftwidth=4
