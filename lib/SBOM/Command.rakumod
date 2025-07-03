class SBOM::Command:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.executed;
    has SBOM::NameValue @.properties;

    method WHY() {
        "Command or directive for a step"
    }
}

# vim: expandtab shiftwidth=4
