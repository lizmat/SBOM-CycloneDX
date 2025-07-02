use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CryptoType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CryptoType.setup(
  "private-key",
  "The confidential key of a key pair used in asymmetric cryptography.",

  "public-key",
  "The non-confidential key of a key pair used in asymmetric cryptography.",

  "secret-key",
  "A key used to encrypt and decrypt messages in symmetric cryptography.",

  "key",
  "A piece of information, usually an octet string, which, when processed through a cryptographic algorithm, processes cryptographic data.",

  "ciphertext",
  "The result of encryption performed on plaintext using an algorithm (or cipher).",

  "signature",
  "A cryptographic value that is calculated from the data and a key known only by the signer.",

  "digest",
  "The output of the hash function.",

  "initialization-vector",
  "A fixed-size random or pseudo-random value used as an input parameter for cryptographic algorithms.",

  "nonce",
  "A random or pseudo-random number that can only be used once in a cryptographic communication.",

  "seed",
  "The input to a pseudo-random number generator. Different seeds generate different pseudo-random sequences.",

  "salt",
  "A value used in a cryptographic process, usually to ensure that the results of computations for one instance cannot be reused by an attacker.",

  "shared-secret",
  "A piece of data known only to the parties involved, in a secure communication.",

  "tag",
  "A message authentication code (MAC), sometimes known as an authentication tag, is a short piece of information used for authenticating and integrity-checking a message.",

  "additional-data",
  "An unspecified collection of data with relevance to cryptographic activity.",

  "password",
  "A secret word, phrase, or sequence of characters used during authentication or authorization.",

  "credential",
  "Establishes the identity of a party to communication, usually in the form of cryptographic keys or passwords.",

  "token",
  "An object encapsulating a security identity.",

  "other",
  "Another type of cryptographic asset.",

  "unknown",
  "The type of cryptographic asset is not known.",
);

# vim: expandtab shiftwidth=4
