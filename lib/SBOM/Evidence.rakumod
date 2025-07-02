use SBOM::Callstack:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Copyright:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Identity:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Occurrence:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Evidence:ver<0.0.1>:auth<zef:lizmat> {
    has                  $.identity;
    has SBOM::Occurrence @.occurrences;
    has SBOM::Callstack  $.callstack;
    has SBOM::AnyLicense @.licenses;
    has SBOM::Copyright  @.copyright;

    submethod TWEAK(:$identity) {
        die "improper identity specification"
          unless $identity ~~ SBOM::Identity
            || ($identity ~~ Positional && $identity.are(SBOM::Identity));

        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);
    }
}

# vim: expandtab shiftwidth=4
