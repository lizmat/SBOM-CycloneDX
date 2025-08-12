use SBOM::enums:ver<0.0.15>:auth<zef:lizmat> <
  HashAlgorithm
>;

use SBOM::subsets:ver<0.0.15>:auth<zef:lizmat> <
  contentHash
>;

use SBOM:ver<0.0.15>:auth<zef:lizmat>;

#- HashedString ----------------------------------------------------------------
#| A hashed representation of data
class SBOM::HashedString:ver<0.0.15>:auth<zef:lizmat> does SBOM {

#| The algorithm that generated the hash value.
    has HashAlgorithm $.alg is required;

#| The value of the hash.
    has contentHash $.content is required;
}

# vim: expandtab shiftwidth=4
