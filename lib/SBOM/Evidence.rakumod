use SBOM::Callstack:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Copyright:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Identity:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Occurrence:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Evidence:ver<0.0.1>:auth<zef:lizmat> {
    has                  $.identity;
    has SBOM::Occurrence @.occurrences;
    has SBOM::Callstack  $.callstack;
    has SBOM::License    @.licenses;
    has SBOM::Copyright  @.copyright;

    method TWEAK(:$identity) {
        die "improper identity specification"
          unless $identity ~~ SBOM::Identity
            || ($identity ~~ Positional && $identity.are(SBOM::Identity))
    }
}

# vim: expandtab shiftwidth=4
