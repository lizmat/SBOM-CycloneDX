#| Properties for cryptographic assets of asset type 'certificate'
class SBOM::CertificateProperties:ver<0.0.1>:auth<zef:lizmat> {

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

# vim: expandtab shiftwidth=4
