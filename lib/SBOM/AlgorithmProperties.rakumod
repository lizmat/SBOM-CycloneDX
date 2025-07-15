use SBOM::enums:ver<0.0.5>:auth<zef:lizmat> <
  AlgorithmPrimitive Certification CertificationMode CertificationPadding
  CryptoFunction ExecutionEnvironment Platform
>;

use SBOM::subsets:ver<0.0.5>:auth<zef:lizmat> <
  nistQuantumSecurityLevel
>;

use SBOM:ver<0.0.5>:auth<zef:lizmat>;

#- AlgorithmProperties ---------------------------------------------------------
#| Properties specific to a cryptographic algorithm.
class SBOM::AlgorithmProperties:ver<0.0.5>:auth<zef:lizmat> does SBOM {

#| Cryptographic building blocks used in higher-level cryptographic
#| systems and protocols.
    has AlgorithmPrimitive $.primitive;

#| An identifier for the parameter set of the cryptographic algorithm.
#| Examples: in AES128, '128' identifies the key length in bits, in
#| SHA256, '256' identifies the digest length, '128' in SHAKE128
#| identifies its maximum security level in bits, and 'SHA2-128s'
#| identifies a parameter set used in SLH-DSA (FIPS205).
    has Str $.parameterSetIdentifier;

#| The specific underlying Elliptic Curve (EC) definition employed
#| which is an indicator of the level of security strength, performance
#| and complexity. Absent an authoritative source of curve names,
#| CycloneDX recommends using curve names as defined at
#| https://neuromancer.sk/std/, the source of which can be found at
#| https://github.com/J08nY/std-curves.
    has Str $.curve;

#| The target and execution environment in which the algorithm is
#| implemented in.
    has ExecutionEnvironment $.executionEnvironment;

#| The target platform for which the algorithm is implemented. The
#| implementation can be 'generic', running on any platform or for
#| a specific platform.
    has Platform $.implementationPlatform;

#| The certification that the implementation of the cryptographic
#| algorithm has received, if any. Certifications include revisions
#| and levels of FIPS 140 or Common Criteria of different Extended
#| Assurance Levels (CC-EAL).
    has Certification @.certificationLevel;

#| The mode of operation in which the cryptographic algorithm
#| (block cipher) is used.
    has CertificationMode $.mode;

#| The padding scheme that is used for the cryptographic algorithm.
    has CertificationPadding $.padding;

#| The cryptographic functions implemented by the cryptographic
#| algorithm.
    has CryptoFunction @.cryptoFunctions;

#| The classical security level that a cryptographic algorithm
#| provides (in bits).
    has UInt $.classicalSecurityLevel;

#| The NIST security strength category as defined in
#| https://csrc.nist.gov/projects/post-quantum-cryptography/post-quantum-cryptography-standardization/evaluation-criteria/security-(evaluation-criteria). A value of 0 indicates that none of the categories are met.
    has nistQuantumSecurityLevel $.nistQuantumSecurityLevel;
}

# vim: expandtab shiftwidth=4
