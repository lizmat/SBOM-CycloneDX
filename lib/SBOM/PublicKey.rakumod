use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  CryptoKey ECCurve EdDSA
>;

#| EC curve name or EdDSA curve name
subtype CryptoCurve where ECCurve | EdDSA;

class SBOM::PublicKey:ver<0.0.1>:auth<zef:lizmat> {

#| Key type indicator.
    has CryptoKey $.kty is required;

#| EC curve name or EdDSA curve name
    has CryptoCurve $.crv;

#| Curve point X. The length of this field must be the full size
#| of a coordinate for the curve specified in the "crv" parameter.
#| For example, if the value of "crv" is "P-521", the decoded argument
#| must be 66 bytes.
    has Str $.x;

#| Curve point Y. The length of this field must be the full size
#| of a coordinate for the curve specified in the "crv" parameter.
#| For example, if the value of "crv" is "P-256", the decoded argument
#| must be 32 bytes.
    has Str $.y;

#| RSA modulus.
    has Str $.n;

#| RSA exponent.
    has Str $.e;

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
