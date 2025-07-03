use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  CryptoKey ECCurve
>;

class SBOM::PublicKey:ver<0.0.1>:auth<zef:lizmat> {
    has CryptoKey $.kty is required;
    has ECCurve   $.crv;
    has Str       $.x;
    has Str       $.y;
    has Str       $.n;
    has Str       $.e;

    submethod TWEAK() {
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
