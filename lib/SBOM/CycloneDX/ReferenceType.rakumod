use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::CycloneDX::ReferenceType:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum externalReferenceType (
  referenceVCS => SBOM::CycloneDX::ReferenceType.new(
    "vcs",
    "Version Control System"
  ),
  referenceIssue-tracker => SBOM::CycloneDX::ReferenceType.new(
    "issue-tracker",
    "Issue or defect tracking system, or an Application Lifecycle Management (ALM) system"
  ),
  referenceWebsite => SBOM::CycloneDX::ReferenceType.new(
    "website",
    "Website"
  ),
  referenceAdvisaries => SBOM::CycloneDX::ReferenceType.new(
    "advisaries",
    "Security advisories"
  ),
  referenceBOM => SBOM::CycloneDX::ReferenceType.new(
    "bom",
    "Bill of Materials (SBOM, OBOM, HBOM, SaaSBOM, etc)"
  ),
  referenceMailing-list => SBOM::CycloneDX::ReferenceType.new(
    "mailing-list",
    "Mailing list or discussion group"
  ),
  referenceSocial => SBOM::CycloneDX::ReferenceType.new(
    "social",
    "Social Media Account"
  ),
  referenceChat => SBOM::CycloneDX::ReferenceType.new(
    "chat",
    "Real-time chat platform",
  ),
  referenceDocumentation => SBOM::CycloneDX::ReferenceType.new(
    "documentation",
    "Documentation, guides, or how-to instructions"
  ),
  referenceSupport => SBOM::CycloneDX::ReferenceType.new(
    "support",
    "Community or commercial support"
  ),
  referenceSource-distribution => SBOM::CycloneDX::ReferenceType.new(
    "source-distribution",
    "The location where the source code distributable can be obtained. This is often an archive format such as zip or tgz. The source-distribution type complements use of the version control (vcs) type."
  ),
  referenceDistribution => SBOM::CycloneDX::ReferenceType.new(
    "distribution",
    "Direct or repository download location"
  ),
  referenceDistribution-intake => SBOM::CycloneDX::ReferenceType.new(
    "distribution-intake",
    'The location where a component was published to. This is often the same as "distribution" but may also include specialized publishing processes that act as an intermediary.'
  ),
  referenceLicense => SBOM::CycloneDX::ReferenceType.new(
    "license",
    "The reference to the license file. If a license URL has been defined in the license node, it should also be defined as an external reference for completeness."
  ),
  referenceBuild-meta => SBOM::CycloneDX::ReferenceType.new(
    "build-meta",
    "Build-system specific meta file (i.e. pom.xml, package.json, .nuspec, etc)"
  ),
  referenceBuild-system => SBOM::CycloneDX::ReferenceType.new(
    "build-system",
    "Reference to an automated build system"
  ),
  referenceRelease-notes => SBOM::CycloneDX::ReferenceType.new(
    "release-notes",
    "Reference to release notes"
  ),
  referenceSecurity-contact => SBOM::CycloneDX::ReferenceType.new(
    "security-contact",
    "Specifies a way to contact the maintainer, supplier, or provider in the event of a security incident. Common URIs include links to a disclosure procedure, a mailto (RFC-2368) that specifies an email address, a tel (RFC-3966) that specifies a phone number, or dns (RFC-4501) that specifies the records containing DNS Security TXT."
  ),
  referenceModel-card => SBOM::CycloneDX::ReferenceType.new(
    "model-card",
    "A model card describes the intended uses of a machine learning model, potential limitations, biases, ethical considerations, training parameters, datasets used to train the model, performance metrics, and other relevant data useful for ML transparency."
  ),
  referenceLog => SBOM::CycloneDX::ReferenceType.new(
    "log",
    "A record of events that occurred in a computer system or application, such as problems, errors, or information on current operations."
  ),
  referenceConfiguration => SBOM::CycloneDX::ReferenceType.new(
    "configuration",
    "Parameters or settings that may be used by other components or services."
  ),
  referenceEvidence => SBOM::CycloneDX::ReferenceType.new(
    "evidence",
    "Information used to substantiate a claim."
  ),
  referenceFormulation => SBOM::CycloneDX::ReferenceType.new(
    "formulation",
    "Describes how a component or service was manufactured or deployed."
  ),
  referenceAttestation => SBOM::CycloneDX::ReferenceType.new(
    "attestation",
    "Human or machine-readable statements containing facts, evidence, or testimony."
  ),
  referenceThreat-model => SBOM::CycloneDX::ReferenceType.new(
    "threat-model",
    "An enumeration of identified weaknesses, threats, and countermeasures, dataflow diagram (DFD), attack tree, and other supporting documentation in human-readable or machine-readable format."
  ),
  referenceAdversary-model => SBOM::CycloneDX::ReferenceType.new(
    "adversary-model",
    "The defined assumptions, goals, and capabilities of an adversary."
  ),
  referenceRisk-assessment => SBOM::CycloneDX::ReferenceType.new(
    "risk-assessment",
    "Identifies and analyzes the potential of future events that may negatively impact individuals, assets, and/or the environment. Risk assessments may also include judgments on the tolerability of each risk."
  ),
  referenceVulnerability-assertion => SBOM::CycloneDX::ReferenceType.new(
    "vulnerability-assertion",
    "A Vulnerability Disclosure Report (VDR) which asserts the known and previously unknown vulnerabilities that affect a component, service, or product including the analysis and findings describing the impact (or lack of impact) that the reported vulnerability has on a component, service, or product."
  ),
  referenceExploitability-statement => SBOM::CycloneDX::ReferenceType.new(
    "exploitability-statement",
    "A Vulnerability Disclosure Report (VDR) which asserts the known and previously unknown vulnerabilities that affect a component, service, or product including the analysis and findings describing the impact (or lack of impact) that the reported vulnerability has on a component, service, or product."
  ),
  referencePentest-report => SBOM::CycloneDX::ReferenceType.new(
    "pentest-report",
    "Results from an authorized simulated cyberattack on a component or service, otherwise known as a penetration test."
  ),
  referenceStatic-analysis-report => SBOM::CycloneDX::ReferenceType.new(
    "static-analysis-report",
    "SARIF or proprietary machine or human-readable report for which static analysis has identified code quality, security, and other potential issues with the source code."
  ),
  referenceDynamic-analysis-report => SBOM::CycloneDX::ReferenceType.new(
    "dynamic-analysis-report",
    "Dynamic analysis report that has identified issues such as vulnerabilities and misconfigurations."
  ),
  referenceRuntime-analysis-report => SBOM::CycloneDX::ReferenceType.new(
    "runtime-analysis-report",
    "Report generated by analyzing the call stack of a running application."
  ),
  referenceComponent-analysis-report => SBOM::CycloneDX::ReferenceType.new(
    "component-analysis-report",
    "Report generated by Software Composition Analysis (SCA), container analysis, or other forms of component analysis."
  ),
  referenceMaturity-report => SBOM::CycloneDX::ReferenceType.new(
    "maturity-report",
    "Report containing a formal assessment of an organization, business unit, or team against a maturity model."
  ),
  referenceCertification-report => SBOM::CycloneDX::ReferenceType.new(
    "certification-report",
    "Industry, regulatory, or other certification from an accredited (if applicable) certification body."
  ),
  referenceCodified-infrastructure => SBOM::CycloneDX::ReferenceType.new(
    "codified-infrastructure",
    "Code or configuration that defines and provisions virtualized infrastructure, commonly referred to as Infrastructure as Code (IaC)."
  ),
  referenceQuality-metrics => SBOM::CycloneDX::ReferenceType.new(
    "quality-metrics",
    "Report or system in which quality metrics can be obtained."
  ),
  referencePoam => SBOM::CycloneDX::ReferenceType.new(
    "poam",
    'Plans of Action and Milestones (POA&M) complement an "attestation" external reference. POA&M is defined by NIST as a "document that identifies tasks needing to be accomplished. It details resources required to accomplish the elements of the plan, any milestones in meeting the tasks and scheduled completion dates for the milestones".'
  ),
  referenceElectronic-signature => SBOM::CycloneDX::ReferenceType.new(
    "electronic-signature",
    "An e-signature is commonly a scanned representation of a written signature or a stylized script of the person's name."
  ),
  referenceDigital-signature => SBOM::CycloneDX::ReferenceType.new(
    "digital-signature",
    "A signature that leverages cryptography, typically public/private key pairs, which provides strong authenticity verification."
  ),
  "referenceRFC-9116" => SBOM::CycloneDX::ReferenceType.new(
    "rfc-9116",
    "Document that complies with RFC 9116 (A File Format to Aid in Security Vulnerability Disclosure)"
  ),
  referenceOther => SBOM::CycloneDX::ReferenceType.new(
    "other",
    "Use this if no other types accurately describe the purpose of the external reference."
  )
);

# vim: expandtab shiftwidth=4
