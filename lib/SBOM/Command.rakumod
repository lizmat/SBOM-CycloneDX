use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

#| Command or directive for a step
class SBOM::Command:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.executed;
    has SBOM::NameValue @.properties;
}

# vim: expandtab shiftwidth=4
