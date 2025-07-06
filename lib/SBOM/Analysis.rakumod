use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Justification Response VulnerabilityState
>;

#| An assessment of the impact and exploitability of a vulnerability.
class SBOM::Analysis:ver<0.0.1>:auth<zef:lizmat> {

#| Declares the current state of an occurrence of a vulnerability, after
#| automated or manual analysis.
    has VulnerabilityState $.state;

#| The rationale of why the impact analysis state was asserted.
    has Justification $.justification;

#| A response to the vulnerability by the manufacturer, supplier, or
#| project responsible for the affected component or service. More than
#| one response is allowed. Responses are strongly encouraged for
#| vulnerabilities where the analysis state is exploitable.
    has Response  $.response;

#| Detailed description of the impact including methods used during
#| assessment. If a vulnerability is not exploitable, this field should
#| include specific details on why the component or service is not
#| impacted by this vulnerability.
    has Str $.detail;

#| The date and time (timestamp) when the analysis was first issued.
    has DateTime $.firstIssued;

#| The date and time (timestamp) when the analysis was last updated.
    has DateTime $.lastUpdated;
}

# vim: expandtab shiftwidth=4
