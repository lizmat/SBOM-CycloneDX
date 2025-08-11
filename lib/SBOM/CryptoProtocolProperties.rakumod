use SBOM::enums:ver<0.0.14>:auth<zef:lizmat> <
  CryptoProtocol
>;

use SBOM::subsets:ver<0.0.14>:auth<zef:lizmat> <
  IDnotbomLink versionString
>;

use SBOM:ver<0.0.14>:auth<zef:lizmat>;

#- CipherSuite -----------------------------------------------------------------
#| A cipher suite related to a protocol.
class SBOM::CipherSuite:ver<0.0.14>:auth<zef:lizmat> does SBOM {

#| A common name for the cipher suite.
    has Str $.name;

#| A list of algorithms related to the cipher suite.
    has Str @.algorithms;

#| A list of common identifiers for the cipher suite.
    has Str @.identifiers;

    # These should probably be auto-generated in RakUAST at some point
    method algorithms( SBOM::CipherSuite:D:) { @!algorithms.List  }
    method identifiers(SBOM::CipherSuite:D:) { @!identifiers.List }
}

#- IKEv2TransformTypes ---------------------------------------------------------
#| The IKEv2 transform types supported (types 1-4), defined in RFC 7296
#| section 3.3.2, and additional properties.
class SBOM::IKEv2TransformTypes:ver<0.0.14>:auth<zef:lizmat> does SBOM {

#| Transform Type 1: encryption algorithms.
    has Str @.encr;

#| Transform Type 2: pseudorandom functions.
    has Str @.prf;

#| Transform Type 3: integrity algorithms.
    has Str @.integ;

#| Transform Type 4: Key Exchange Method (KE) per RFC 9370, formerly
#| called Diffie-Hellman Group (D-H).
    has Str @.ke;

#| Specifies if an Extended Sequence Number (ESN) is used.
    has Bool $.esn;

#| IKEv2 Authentication methods: identifier for referable and therefore
#| interlinkable elements.
    has IDnotbomLink @.auth;

    # These should probably be auto-generated in RakUAST at some point
    method encr( SBOM::IKEv2TransformTypes:D:) { @!encr.List  }
    method prf(  SBOM::IKEv2TransformTypes:D:) { @!prf.List   }
    method integ(SBOM::IKEv2TransformTypes:D:) { @!integ.List }
    method ke(   SBOM::IKEv2TransformTypes:D:) { @!ke.List    }
    method auth( SBOM::IKEv2TransformTypes:D:) { @!auth.List  }
}

#- CryptoProtocolProperties ----------------------------------------------------
#| Properties specific to cryptographic assets of type: protocol.
class SBOM::CryptoProtocolProperties:ver<0.0.14>:auth<zef:lizmat> does SBOM {

#| The concrete protocol type.
    has CryptoProtocol $.type;

#| The version of the protocol.
    has versionString $.version;

#| A list of cipher suites related to the protocol.
    has SBOM::CipherSuite @.cipherSuites;

#| The IKEv2 transform types supported (types 1-4), defined in RFC 7296
#| section 3.3.2, and additional properties.
    has SBOM::IKEv2TransformTypes $.ikev2TransformTypes;

#| A list of protocol-related cryptographic assets, Identifier for
#| referable and therefore interlinkable elements.
    has IDnotbomLink @.cryptoRefArray;

    # These should probably be auto-generated in RakUAST at some point
    method cipherSuites(SBOM::CryptoProtocolProperties:D:) {
        @!cipherSuites.List
    }
    method cryptoRefArray(SBOM::CryptoProtocolProperties:D:) {
        @!cryptoRefArray.List
    }
}

# vim: expandtab shiftwidth=4
