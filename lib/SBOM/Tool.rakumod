use SBOM::subsets:ver<0.0.3>:auth<zef:lizmat> <
  versionString
>;

use SBOM::Component:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::HashedString:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.3>:auth<zef:lizmat>;
use SBOM::Service:ver<0.0.3>:auth<zef:lizmat>;

#- Tool ------------------------------------------------------------------------
class SBOM::LegacyTool { ... }

#| Description of a tool used to identify, confirm, or score a
#| vulnerability.
class SBOM::Tool:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| A list of software and hardware components used as tools.
    has SBOM::Component @.components;

#| A list of services used as tools. This may include microservices,
#| function-as-a-service, and other types of network or intra-process
#| services.
    has SBOM::Service @.services;

    # Handle legacy tool here
    multi method new(SBOM::Tool:U: :$raw-error) {
        if %_<name>
          || %_<vendor>
          || %_<version>
          || %_<hashes>
          || %_<externalReferences> {
            SBOM::LegacyTool.new(:$raw-error, |%_)
        }
        else {
            self.ingest($raw-error, %_)
        }
    }
}

#- LegacyTool ------------------------------------------------------------------
#| Legacy format of the description of a tool used to identify,
#| confirm, or score a vulnerability.
class SBOM::LegacyTool:ver<0.0.3>:auth<zef:lizmat>
  is SBOM::Tool does SBOM {

#| The name of the vendor who created the tool.
    has Str $.vendor;

#| The name of the tool.
    has Str $.name;

#| The version of the tool.
    has versionString $.version;

#| The hashes of the tool (if applicable).
    has SBOM::HashedString @.hashes;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences
}

# vim: expandtab shiftwidth=4
