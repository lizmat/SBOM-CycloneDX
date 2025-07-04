#| A representation of a functional parameter.
class SBOM::Parameter:ver<0.0.1>:auth<zef:lizmat> {
    #| The name of the parameter.
    has Str $.name;

    #| The value of the parameter.
    has Str $.value;

    #| The data type of the parameter.
    has Str $.dataType;
}

# vim: expandtab shiftwidth=4
