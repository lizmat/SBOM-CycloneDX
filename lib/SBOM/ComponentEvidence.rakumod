use SBOM::Callstack:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Identity:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::License:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Occurrence:ver<0.0.1>:auth<zef:lizmat>;

#| Evidence that substantiates the identity of a component. The
#| identity may be an object or an array of identity objects.
#| Support for specifying identity as a single object was introduced
#| in CycloneDX v1.5. Arrays were introduced in v1.6. It is
#| recommended that all implementations use arrays, even if only one
#| identity object is specified.
subset Identity where {
   $_ ~~ SBOM::Identity || ($_ ~~ Positional && .are(SBOM::Identity))
}

#- Copyright -------------------------------------------------------------------
#| Copyright evidence captures intellectual property assertions,
#| providing evidence of possible ownership and legal protection.
class SBOM::Copyright:ver<0.0.1>:auth<zef:lizmat> {

#| The textual content of the copyright.
    has Str $.text is required;
}

#- ComponentEvidence -----------------------------------------------------------
#| The ability to document evidence about a component, collected
#| through various forms of extraction or analysis.
class SBOM::ComponentEvidence:ver<0.0.1>:auth<zef:lizmat> {

#| Evidence that substantiates the identity of a component.
    has Identity $.identity;

#| Evidence of individual instances of a component spread across
#| multiple locations.
    has SBOM::Occurrence @.occurrences;

#| Evidence of the components use through the callstack.
    has SBOM::Callstack  $.callstack;

#| EITHER (list of SPDX licenses and/or named licenses) OR (tuple
#| of one SPDX License Expression).
    has SBOM::AnyLicense @.licenses;

#| A copyright notice informing users of the underlying claims to
#| copyright ownership in a published work.
    has SBOM::Copyright @.copyright;

    submethod TWEAK() {

        # Make sure we always have a list of identities
        if $!identity -> $identity {
            $!identity = ($identity,) unless $identity ~~ Positional;
        }

        die "Can only have one SPDX license"
          if @!licenses > 1 && @!licenses.first(SBOM::SPDXLicense);
    }
}

# vim: expandtab shiftwidth=4
