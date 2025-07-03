use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  AlgorithmPrimitive Certification CertificationMode CertificationPadding
  CryptoFunction ExecutionEnvironment Platform
>;
   
use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  nistQuantumSecurityLevel
>;

class SBOM::AlgorithmProperties:ver<0.0.1>:auth<zef:lizmat> {
    has AlgorithmPrimitive       $.primitive;
    has Str                      $.parameterSetIdentifier;
    has Str                      $.curve;
    has ExecutionEnvironment     $.executionEnvironmment;
    has Platform                 $.implementationPlatform;
    has Certification            $.certficationLevel;
    has CertificationMode        $.mode;
    has CertificationPadding     $.padding;
    has CryptoFunction           @.cryptoFunctions;
    has UInt                     $.classicalSecurityLevel;
    has nistQuantumSecurityLevel $.nistQuantumSecurityLevel;
}

# vim: expandtab shiftwidth=4
