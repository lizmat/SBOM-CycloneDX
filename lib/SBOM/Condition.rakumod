use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

#| A condition that was used to determine a trigger should be activated.
class SBOM::Condition:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.description;
    has Str             $.expression;;
    has SBOM::NameValue @.properties;
}

# vim: expandtab shiftwidth=4
