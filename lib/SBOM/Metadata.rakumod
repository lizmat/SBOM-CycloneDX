use SBOM::enums:ver<0.0.7>:auth<zef:lizmat> <
   Phase
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Component:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Organization:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Tool:ver<0.0.7>:auth<zef:lizmat>;

#- Lifecycle -------------------------------------------------------------------
#| Lifecycles communicate the stage(s) in which data in the BOM was
#| captured. Different types of data may be available at various phases
#| of a lifecycle, such as the Software Development Lifecycle (SDLC),
#| IT Asset Management (ITAM), and Software Asset Management (SAM).
#| Thus, a BOM may include data specific to or only obtainable in a
#| given lifecycle.
class SBOM::Lifecycle:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| A pre-defined phase in the product lifecycle.
    has Phase $.phase;

#| The name of the lifecycle phase.
    has Str $.name;

#| The description of the lifecycle phase.
    has Str $.description;

    submethod TWEAK() {
        die "Must have 'phase' or 'name' specified"
          if ($!phase && $!name) || (!$!phase && !$!name);
    }
}

#- Metadata --------------------------------------------------------------------
#| Provides additional information about a BOM.
class SBOM::Metadata:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| The date and time (timestamp) when the BOM was created.
    has DateTime $.timestamp;

#| The product lifecycle(s) that this BOM represents.
    has SBOM::Lifecycle @.lifecycles;

#| [Deprecated] This will be removed in a future version. Use the
#| "manufacturer" instead.  The organization that manufactured the
#| component that the BOM describes.
    has SBOM::Organization $.manufacture;

#| The organization that created the BOM. Manufacturer is common in
#| BOMs created through automated processes. BOMs created through
#| manual means may have @.authors instead.
    has SBOM::Organization $.manufacturer;

#| The person(s) who created the BOM. Authors are common in BOMs
#| created through manual processes. BOMs created through automated
#| means may have $.manufacturer instead.
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

#| The legacy tools used in the creation, enrichment, and validation
#| the BOM.
    has SBOM::LegacyTool @!tools;

#| The tool used in the creation, enrichment, and validation of
#| the BOM.
    has SBOM::Tool $!tools;

    method TWEAK-nameds(SBOM::Metadata:) { ("tools",) }

    submethod TWEAK(:$tools) {
        die "Can only have one SPDX license"
        if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);

        die "Can only have one of 'manufacture' and 'manufacturer'"
          if $!manufacture && $!manufacturer;

        if $tools ~~ Positional {
            @!tools = $tools<>.map: { 
                $_ ~~ SBOM ?? $_ !! SBOM::LegacyTool.new(|$_)
            }
        }
        elsif $tools.defined {
            $!tools := $tools ~~ SBOM ?? $tools<> !! SBOM::Tool.new(|$tools<>);
        }
    }

    method tools(SBOM::Metadata:D:) { $!tools // @!tools }
}

# vim: expandtab shiftwidth=4
