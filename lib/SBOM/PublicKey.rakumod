use SBOM::ECCurveType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::KeyType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::PublicKey:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::KeyType     $.kty is required;
    has SBOM::ECCurveType $.crv;
    has Str               $.x;
    has Str               $.y;
    has Str               $.n;
    has Str               $.e;

    method TWEAK() {
        my $keytype := $!kty.Str;

        if $keytype eq "EC" {
            return if $!crv && $!x && $!y;
        }
        elsif $keytype eq "OKP" {
            return if $!crv && $!x;
        }
        elsif $keytype eq "RSA" {
            return if $!crv && $!n && $!e;
        }
        die "did not specify all required arguments for key '$keytype'";
    }
}

# Sim: expandtab shiftwidth=4
