use SBOM::subsets:ver<0.0.11>:auth<zef:lizmat> <
  confidenceValue
>;

use SBOM:ver<0.0.11>:auth<zef:lizmat>;

#| The confidence of the claim meeting the requirement.
class SBOM::Confidence:ver<0.0.11>:auth<zef:lizmat> does SBOM {

#| The confidence of the claim between and inclusive of 0 and 1,
#| where 1 is 100% confidence.
    has confidenceValue $.score;

#| The rationale for the confidence score.
    has Str $.rationale;
}

# vim: expandtab shiftwidth=4
