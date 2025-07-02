use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat>
  <nistQuantumSecurityLevel>;

use SBOM::AlgorithmPrimitiveType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CertificationType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CertificationModeType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CertificationPaddingType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::CryptoFunctionType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::ExecutionEnvironmentType:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::PlatformType:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::AlgorithmProperties:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::AlgorithmPrimitiveType   $.primitive;
    has Str                            $.parameterSetIdentifier;
    has Str                            $.curve;
    has SBOM::ExecutionEnvironmentType $.executionEnvironmment;
    has SBOM::PlatformType             $.implementationPlatform;
    has SBOM::CertificationType        $.certficationLevel;
    has SBOM::CertificationModeType    $.mode;
    has SBOM::CertificationPaddingType $.padding;
    has SBOM::CryptoFunctionType       @.cryptoFunctions;
    has UInt                           $.classicalSecurityLevel;
    has nistQuantumSecurityLevel       $.nistQuantumSecurityLevel;
}

# vim: expandtab shiftwidth=4
