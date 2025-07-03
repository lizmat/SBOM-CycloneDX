use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Condition:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.description;
    has Str             $.expression;;
    has SBOM::NameValue @.properties;

    method WHY() {
        "A condition that was used to determine a trigger should be activated."
    }
}

# vim: expandtab shiftwidth=4
