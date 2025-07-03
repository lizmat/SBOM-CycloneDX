use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Text:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Event:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.uid;
    has Str             $.description;
    has DateTime        $.timeReceived;
    has SBOM::Text      $.data;
    has resourceRef     $.source;
    has resourceRef     $.target;
    has SBOM::NameValue @.properties;

    method WHY() {
        "The event data that caused the associated trigger to activate."
    }
}

# vim: expandtab shiftwidth=4
