use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::AlgorithmPrimitiveType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::AlgorithmPrimitiveType.setup(
  "drbg",
  "Deterministic Random Bit Generator (DRBG) is a type of pseudorandom number generator designed to produce a sequence of bits from an initial seed value. DRBGs are commonly used in cryptographic applications where reproducibility of random values is important.",

  "mac",
  "In cryptography, a Message Authentication Code (MAC) is information used for authenticating and integrity-checking a message.",

  "block-cipher",
  "A block cipher is a symmetric key algorithm that operates on fixed-size blocks of data. It encrypts or decrypts the data in block units, providing confidentiality. Block ciphers are widely used in various cryptographic modes and protocols for secure data transmission.",

  "stream-cipher",
  "A stream cipher is a symmetric key cipher where plaintext digits are combined with a pseudorandom cipher digit stream (keystream).",

  "signature",
  "In cryptography, a signature is a digital representation of a message or data that proves its origin, identity, and integrity. Digital signatures are generated using cryptographic algorithms and are widely used for authentication and verification in secure communication.",

  "hash",
  "A hash function is a mathematical algorithm that takes an input (or 'message') and produces a fixed-size string of characters, which is typically a hash value. Hash functions are commonly used in various cryptographic applications, including data integrity verification and password hashing.",

  "pke",
  "Public Key Encryption (PKE) is a type of encryption that uses a pair of public and private keys for secure communication. The public key is used for encryption, while the private key is used for decryption. PKE is a fundamental component of public-key cryptography.",

  "xof",
  "An XOF is an extendable output function that can take arbitrary input and creates a stream of output, up to a limit determined by the size of the internal state of the hash function that underlies the XOF.",

  "kdf",
  "A Key Derivation Function (KDF) derives key material from another source of entropy while preserving the entropy of the input.",

  "key-agree",
  "In cryptography, a key-agreement is a protocol whereby two or more parties agree on a cryptographic key in such a way that both influence the outcome.",

  "kem",
  "A Key Encapsulation Mechanism (KEM) algorithm is a mechanism for transporting random keying material to a recipient using the recipient's public key.",

  "ae",
  "Authenticated Encryption (AE) is a cryptographic process that provides both confidentiality and data integrity. It ensures that the encrypted data has not been tampered with and comes from a legitimate source. AE is commonly used in secure communication protocols.",

  "combiner",
  "A combiner aggregates many candidates for a cryptographic primitive and generates a new candidate for the same primitive.",

  "other",
  "Another primitive type.",

  "unknown",
  "The primitive is not known.",
);

# vim: expandtab shiftwidth=4
