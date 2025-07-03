use SBOM::Command:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::NameValue:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ExecutionStep:ver<0.0.1>:auth<zef:lizmat> {
    has Str             $.name;
    has Str             $.description;;
    has SBOM::Command   @.commands;
    has SBOM::NameValue @.properties;

    method WHY() {
        "Executes specific commands or tools in order to accomplish its owning task as part of a sequence."
    }
}

# vim: expandtab shiftwidth=4
