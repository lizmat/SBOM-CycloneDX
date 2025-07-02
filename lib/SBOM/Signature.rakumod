use SBOM::PublicKey:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::SignatureAlgorithmType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Signature:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::SignatureAlgorithmType $.algorithm is required;
    has Str                          $.value     is required;
    has Str                          $.keyId;
    has SBOM::PublicKey              $.publicKey;
    has Str                          @.certificatePath;
    has Str                          @.excludes;;
}

class SBOM::SignatureChain:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Signature @.chain;
}

class SBOM::SignatureSigners:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::Signature @.signers;
}

subset SBOM::ValidSignature
  where SBOM::SignatureSigners | SBOM::SignatureChain | SBOM::Signature;

# vim: expandtab shiftwidth=4
