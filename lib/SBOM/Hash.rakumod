use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  HashAlgorithm
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  contentHash
>;

#| A hashed representation of data
class SBOM::Hash:ver<0.0.1>:auth<zef:lizmat> {

#| The algorithm that generated the hash value.
    has HashAlgorithm $.alg is required;

#| The value of the hash.
    has contentHash $.content is required;
}

# vim: expandtab shiftwidth=4
