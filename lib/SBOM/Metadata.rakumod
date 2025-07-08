use SBOM::enums:ver<0.0.2>:auth<zef:lizmat> <
   Phase
>;

use SBOM:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::Component:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::Contact:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.2>:auth<zef:lizmat>;
use SBOM::Tool:ver<0.0.2>:auth<zef:lizmat>;

#- Metadata --------------------------------------------------------------------
#| Provides additional information about a BOM.
class SBOM::Metadata:ver<0.0.2>:auth<zef:lizmat> does SBOM {

#| The date and time (timestamp) when the BOM was created.
    has DateTime $.timestamp;

#| Lifecycles communicate the stage(s) in which data in the BOM was
#| captured. Different types of data may be available at various phases
#| of a lifecycle, such as the Software Development Lifecycle (SDLC),
#| IT Asset Management (ITAM), and Software Asset Management (SAM).
#| Thus, a BOM may include data specific to or only obtainable in a
#| given lifecycle.
    has Phase @.lifecycles;

#| The tool(s) used in the creation, enrichment, and validation of
#| the BOM.
    has SBOM::AnyTool $.tools;

#| The organization that created the BOM. Manufacturer is common in
#| BOMs created through automated processes. BOMs created through
#| manual means may have @.authors instead.
    has SBOM::Organization $.manufacturer;

#| The person(s) who created the BOM. Authors are common in BOMs
#| created through manual processes. BOMs created through automated
#| means may have @.manufacturer instead.
    has SBOM::Contact @.authors;

#| The component that the BOM describes.
    has SBOM::Component $.component;

#| The organization that supplied the component that the BOM describes.
#| The supplier may often be the manufacturer, but may also be a
#| distributor or repackager.
    has SBOM::Organization $.supplier;

#| The license information for the BOM document. This may be different
#| from the license(s) of the component(s) that the BOM describes.
    has SBOM::AnyLicense @.licenses;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    submethod TWEAK(:$tools, :$manufacture) {
        die "Can only have one SPDX license"
        if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);

        $!manufacturer //= $manufacture if $manufacture;
    }
}

# vim: expandtab shiftwidth=4
