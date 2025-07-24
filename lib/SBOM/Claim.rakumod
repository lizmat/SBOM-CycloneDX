use SBOM::subsets:ver<0.0.7>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Signature:ver<0.0.7>:auth<zef:lizmat>;

#- Claim -----------------------------------------------------------------------
#| A claim.
class SBOM::Claim:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The bom-ref to a target representing a specific system, application,
#| API, module, team, person, process, business unit, company, etc...
#| that this claim is being applied to.
    has bom-ref $.target;

#| The specific statement or assertion about the target.
    has Str $.predicate;

#| The list of bom-ref to the evidence provided describing the
#| mitigation strategies. Each mitigation strategy should include
#| an explanation of how any weaknesses in the evidence will be
#| mitigated.
    has bom-ref @.mitigationStrategies;

#| The written explanation of why the evidence provided substantiates
#| the claim.
    has Str $.reasoning;

#| The list of bom-ref to evidence that supports this claim.
    has bom-ref @.evidence;

#| The list of bom-ref to counter evidence that supports this claim.
    has bom-ref @.counterEvidence;

#| External references provide a way to document systems, sites, and
#| information that may be relevant but are not included with the BOM.
#| They may also establish specific relationships within or external
#| to the BOM.
    has SBOM::Reference @.externalReferences;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;

    # These should probably be auto-generated in RakUAST at some point
    method mitigationStrategies(SBOM::Claim:D:) { @!mitigationStrategies.List }
    method evidence(            SBOM::Claim:D:) { @!evidence.List             }
    method counterEvidence(     SBOM::Claim:D:) { @!counterEvidence.List      }
    method externalReferences(  SBOM::Claim:D:) { @!externalReferences.List   }
}

# vim: expandtab shiftwidth=4
