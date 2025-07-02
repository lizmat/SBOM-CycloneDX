use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;

# fetched from https://raw.githubusercontent.com/spdx/license-list-data/refs/heads/main/json/licenses.json
my enum licenseId (
  BEGIN from-json(
    %?RESOURCES<licenses.json>.open.slurp(:close)
  )<licenses>.map({ "license" ~ .<licenseId> }).List
);

my enum fieldType <group name version purl cpe omniborId swhid swid hash>;

my enum algorithmHash <
  MD5 SHA-1 SHA-256 SHA-384 SHA-512 SHA3-256 SHA3-384 SHA3-512
  BLAKE2b-256 BLAKE2b-384 BLAKE2b-512 BLAKE3
>;

my enum evidenceTechnique <
  source-code-analysis binary-analysis manifest-analysis ast-fingerprint
  hash-comparison instrumentation dynamic-analysis filename attestation
  other
>;

my enum releaseType <major minor patch pre-release internal>;

my enum formatType <string image time-series>;

#- EXPORT ----------------------------------------------------------------------
my sub EXPORT(*@names) {

    @names ||= <
      algorithmHash evidenceTechnique fieldType formatType licenseId
      releaseType
    >;
    Map.new: @names.map: {
        if UNIT::{$_}:exists {
            UNIT::{$_}:p
        }
        else {
            my ($in,$out) = .split(':', 2);
            if $out && UNIT::{"$in"} -> $enum {
                Pair.new: "$out", $enum
            }
        }
    }
}

# vim: expandtab shiftwidth=4
