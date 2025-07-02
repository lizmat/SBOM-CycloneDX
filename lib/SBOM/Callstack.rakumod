use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <PositiveInt>;

class SBOM::Frame:ver<0.0.1>:auth<zef:lizmat> {
    has Str         $.package;
    has Str         $.module is required;
    has Str         $.function;
    has Str         @.parameters;
    has PositiveInt $.line;
    has PositiveInt $.column;
    has Str         $.fullFilename;
}

class SBOM::Callstack:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Frame @.frames;
}

# vim: expandtab shiftwidth=4
