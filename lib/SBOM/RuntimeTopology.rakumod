use SBOM:ver<0.0.13>:auth<zef:lizmat>;

#- RuntimeTopology -------------------------------------------------------------
#| Defines the direct dependencies of a component, service, or the
#| components provided/implemented by a given component. Components
#| or services that do not have their own dependencies must be declared
#| as empty elements within the graph. Components or services that are
#| not represented in the dependency graph may have unknown dependencies.
#| It is recommended that implementations assume this to be opaque and
#| not an indicator of an object being dependency-free. It is recommended
#| to leverage compositions to indicate unknown dependency graphs.
class SBOM::RuntimeTopology:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| References a component or service by its bom-ref attribute
    has Str $.ref is required;

#| The bom-ref identifiers of the components or services that are
#| dependencies of this dependency object.
    has Str @.dependsOn;

#| The bom-ref identifiers of the components or services that define a
#| given specification or standard, which are provided or implemented by
#| this dependency object.  For example, a cryptographic library which
#| implements a cryptographic algorithm. A component which implements
#| another component does not imply that the implementation is in use.
    has Str @.provides;

    # These should probably be auto-generated in RakUAST at some point
    method dependsOn(SBOM::RuntimeTopology:D:) { @!dependsOn.List }
    method provides( SBOM::RuntimeTopology:D:) { @!provides.List  }
}

# vim: expandtab shiftwidth=4
