use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref PositiveInt
>;

class SBOM::Occurrence:ver<0.0.1>:auth<zef:lizmat> {
    has Str         $.location is required;
    has bom-ref     $.bom-ref;
    has PositiveInt $.line;
    has PositiveInt $.offset;
    has Str         $.symbol;
}

# vim: expandtab shiftwidth=4
