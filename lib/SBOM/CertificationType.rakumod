use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CertificationType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::CertificationType.setup(
  "none",
  "No certification obtained",

  "fips140-1-l1",
  "FIPS 140-1 Level 1",

  "fips140-1-l2",
  "FIPS 140-1 Level 2",

  "fips140-1-l3",
  "FIPS 140-1 Level 3",

  "fips140-1-l4",
  "FIPS 140-1 Level 4",

  "fips140-2-l1",
  "FIPS 140-2 Level 1",

  "fips140-2-l2",
  "FIPS 140-2 Level 2",

  "fips140-2-l3",
  "FIPS 140-2 Level 3",

  "fips140-2-l4",
  "FIPS 140-2 Level 4",

  "fips140-3-l1",
  "FIPS 140-3 Level 1",

  "fips140-3-l2",
  "FIPS 140-3 Level 2",

  "fips140-3-l3",
  "FIPS 140-3 Level 3",

  "fips140-3-l4",
  "FIPS 140-3 Level 4",

  "cc-eal1",
  "Common Criteria - Evaluation Assurance Level 1",

  "cc-eal1+",
  "Common Criteria - Evaluation Assurance Level 1 (Augmented)",

  "cc-eal2",
  "Common Criteria - Evaluation Assurance Level 2",

  "cc-eal2+",
  "Common Criteria - Evaluation Assurance Level 2 (Augmented)",

  "cc-eal3",
  "Common Criteria - Evaluation Assurance Level 3",

  "cc-eal3+",
  "Common Criteria - Evaluation Assurance Level 3 (Augmented)",

  "cc-eal4",
  "Common Criteria - Evaluation Assurance Level 4",

  "cc-eal4+",
  "Common Criteria - Evaluation Assurance Level 4 (Augmented)",

  "cc-eal5",
  "Common Criteria - Evaluation Assurance Level 5",

  "cc-eal5+",
  "Common Criteria - Evaluation Assurance Level 5 (Augmented)",

  "cc-eal6",
  "Common Criteria - Evaluation Assurance Level 6",

  "cc-eal6+",
  "Common Criteria - Evaluation Assurance Level 6 (Augmented)",

  "cc-eal7",
  "Common Criteria - Evaluation Assurance Level 7",

  "cc-eal7+",
  "Common Criteria - Evaluation Assurance Level 7 (Augmented)",

  "other",
  "Another certification",

  "unknown",
  "The certification level is not known",
);

# vim: expandtab shiftwidth=4
