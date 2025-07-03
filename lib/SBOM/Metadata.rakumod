use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Phase
>;

use SBOM::Component:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Tool:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Metadata:ver<0.0.1>:auth<zef:lizmat> {
    has DateTime           $.timestamp;
    has Phase              @.lifecycles;
    has SBOM::AnyTool      $.tools;
    has SBOM::Organization $.manufacturer;
    has SBOM::Contact      @.authors;
    has SBOM::Component    $.component;
    has SBOM::Organization $.supplier;
    has SBOM::AnyLicense   @.licenses;
    has SBOM::NameValue    @.properties;

    submethod TWEAK(:$tools, :$manufacture) {
        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);

        $!manufacturer //= $manufacture if $manufacture;
    }
}

# vim: expandtab shiftwidth=4
