use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Aggregate
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref bomLinkElement
>;

use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Composition:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref              $.bom-ref;
    has Aggregate            $.aggregate = Aggregate("not_specified");
    has bomLinkElement       @.assemblies;
    has bom-ref              @.dependencies;;
    has bom-ref              @.vulnerabilities;;
    has SBOM::ValidSignature $.signature;

    method description() {
        "Compositions describe constituent parts (including components, services, and dependency relationships) and their completeness. The completeness of vulnerabilities expressed in a BOM may also be described."
    }
}

# vim: expandtab shiftwidth=4
