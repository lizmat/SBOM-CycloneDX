class SBOM::CertificateProperties:ver<0.0.1>:auth<zef:lizmat> {
    has Str      $.subjectName;
    has Str      $.issuerName;
    has DateTime $.notValidBefore;
    has DateTime $.notValidAfter;
    has Str      $.signatureAlgorithmRef;
    has Str      $.subjectPublicKeyRef;
    has Str      $.certificateFormat;
    has Str      $.certificateExtension;
}

# vim: expandtab shiftwidth=4
