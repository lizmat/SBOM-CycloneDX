use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  CryptoKey ECCurve EdDSA SignatureAlgorithm
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

#| Signature algorithm. If proprietary signature algorithms are added,
#| they must be expressed as URIs.
subset URLorAlgorithm where URL | SignatureAlgorithm;

#| EC curve name or EdDSA curve name
subset CryptoCurve where ECCurve | EdDSA;

#- PublicKey -------------------------------------------------------------------
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

#- Signature -------------------------------------------------------------------
#| Unique top level property for simple signatures. (signaturecore)
class SBOM::Signature:ver<0.0.1>:auth<zef:lizmat> {
    has URLorAlgorithm $.algorithm is required;

#| Optional. Application specific string identifying the signature key.
    has Str $.keyId;

#| Optional. Public key object.
    has SBOM::PublicKey $.publicKey;

#| Sorted array of X.509 [RFC5280] certificates, where the first element
#| must contain the signature certificate. The certificate path must be
#| contiguous but is not required to be complete.
    has Str @.certificatePath;

#| Array holding the names of one or more application level properties
#| that must be excluded from the signature process. Note that the
#| "excludes" property itself, must also be excluded from the signature
#| process. Since both the "excludes" property and the associated data
#| it points to are unsigned, a conforming JSF implementation must
#| provide options for specifying which properties to accept.
    has Str @.excludes;;

#| The signature data. Note that the binary representation must follow
#| the JWA [RFC7518] specifications.
    has Str $.value is required;
}

#- SignatureChain --------------------------------------------------------------
#| Unique top level property for Signature Chains. (signaturechain)
class SBOM::SignatureChain:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Signature @.chain;
}

#- SignatureSigners ------------------------------------------------------------
#| Unique top level property for Multiple Signatures. (multisignature)
class SBOM::SignatureSigners:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Signature @.signers;
}

#| Enveloped signature in JSON Signature Format (JSF).
subset SBOM::ValidSignature
  where SBOM::SignatureSigners | SBOM::SignatureChain | SBOM::Signature;

# vim: expandtab shiftwidth=4
