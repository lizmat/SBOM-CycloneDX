use SBOM:ver<0.0.4>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.4>:auth<zef:lizmat>;

#- Graphic ---------------------------------------------------------------------
#| A single graphic
class SBOM::Graphic:ver<0.0.4>:auth<zef:lizmat> does SBOM {

#| The name of the graphic.
    has Str $.name;

#| The graphic (vector or raster).
    has SBOM::Attachment $.image;
}

#- Graphics --------------------------------------------------------------------
#| A collection of graphics that represent various measurements.
class SBOM::Graphics:ver<0.0.4>:auth<zef:lizmat> does SBOM {

#| A description of this collection of graphics.
    has Str $.description;

#| A collection of graphics.
    has SBOM::Graphic @.collection;
}

# vim: expandtab shiftwidth=4
