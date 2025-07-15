use SBOM::enums:ver<0.0.5>:auth<zef:lizmat> <
  CryptoAsset
>;

use SBOM:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::AlgorithmProperties:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::CryptoMaterialProperties:ver<0.0.5>:auth<zef:lizmat>;
use SBOM::CryptoProtocolProperties:ver<0.0.5>:auth<zef:lizmat>;

#- CertificateProperties -------------------------------------------------------
#| Properties for cryptographic assets of asset type 'certificate'
class SBOM::CertificateProperties:ver<0.0.5>:auth<zef:lizmat> does SBOM {

#| The subject name for the certificate.
    has Str $.subjectName;

#| The issuer name for the certificate.
    has Str $.issuerName;

#| The date and time according to ISO-8601 standard from which the
#| certificate is valid.
    has DateTime $.notValidBefore;

#| The date and time according to ISO-8601 standard from which the
#| certificate is not valid anymore.
    has DateTime $.notValidAfter;

#| The bom-ref to signature algorithm used by the certificate.
    has Str $.signatureAlgorithmRef;

#| The bom-ref to the public key of the subject.
    has Str $.subjectPublicKeyRef;

#| The format of the certificate.
    has Str $.certificateFormat;

#| The file extension of the certificate.
    has Str $.certificateExtension;
}

#- CryptoProperties ------------------------------------------------------------
#| Cryptographic assets have properties that uniquely define them and
#| that make them actionable for further reasoning. As an example, it
#| makes a difference if one knows the algorithm family (e.g. AES) or
#| the specific variant or instantiation (e.g. AES-128-GCM). This is
#| because the security level and the algorithm primitive (authenticated
#| encryption) are only defined by the definition of the algorithm
#| variant. The presence of a weak cryptographic algorithm like SHA1
#| vs. HMAC-SHA1 also makes a difference.
class SBOM::CryptoProperties:ver<0.0.5>:auth<zef:lizmat> does SBOM {

#| Type of crypto asset.
    has CryptoAsset $.assetType is required;

#| Additional properties specific to a cryptographic algorithm.
    has SBOM::AlgorithmProperties $.algorithmProperties;

#| Properties for cryptographic assets of asset type 'certificate'.
    has SBOM::CertificateProperties $.certificateProperties;

#| Properties for cryptographic assets of asset type 'related-crypto-material'.
    has SBOM::CryptoMaterialProperties $.relatedCryptoMaterialProperties;

#| Properties specific to cryptographic assets of type: protocol.
    has SBOM::CryptoProtocolProperties $.protocolProperties;

#| The object identifier (OID) of the cryptographic asset.
    has Str $.oid;

    submethod TWEAK() {
        die "Can only have certificateProperties for 'certificate' assets"
          if $!certificateProperties && $!assetType ne 'certificate';

        die "Can only have relatedCryptoMaterialsProperties for 'related-crypto-material' assets"
          if $!relatedCryptoMaterialProperties
          && $!assetType ne 'related-crypto-material';

        die "Can only have protocolProperties for 'protocol' assets"
          if $!protocolProperties && $!assetType ne 'protocol';
    }
}

# vim: expandtab shiftwidth=4
