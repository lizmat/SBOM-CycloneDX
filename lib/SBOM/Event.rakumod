use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

#| The event data that caused the associated trigger to activate.
class SBOM::Event:ver<0.0.1>:auth<zef:lizmat> {
    has Str               $.uid;
    has Str               $.description;
    has DateTime          $.timeReceived;
    has SBOM::Text        $.data;
    has SBOM::resourceRef $.source;
    has SBOM::resourceRef $.target;
    has SBOM::NameValue   @.properties;
}

# vim: expandtab shiftwidth=4
