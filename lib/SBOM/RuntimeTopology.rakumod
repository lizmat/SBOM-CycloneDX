#| Defines the direct dependencies of a component, service, or the components provided/implemented by a given component. Components or services that do not have their own dependencies must be declared as empty elements within the graph. Components or services that are not represented in the dependency graph may have unknown dependencies. It is recommended that implementations assume this to be opaque and not an indicator of an object being dependency-free. It is recommended to leverage compositions to indicate unknown dependency graphs.
class SBOM::RuntimeTopology:ver<0.0.1>:auth<zef:lizmat> {
    has Str $.ref is required;;
    has Str @.dependsOn;
    has Str @.provides;
}

# vim: expandtab shiftwidth=4
