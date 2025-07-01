use SBOM::Subsets:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Address:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref       $.bom-ref;
    has Str           $.country;
    has Str           $.region;
    has Str           $.locality;
    has Str           $.postOfficeBoxNumber;
    has Str           $.postalCode;
    has Str           $.streetAddress;
}

# vim: expandtab shiftwidth=4
