use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref
>;

#| Provides the ability to document dependency relationships including provided & implemented components.  All items must be unique
class SBOM::Dependency:ver<0.0.1>:auth<zef:lizmat> {
    has bom-ref $.ref;
    has bom-ref @.dependsOn;
    has bom-ref @.provides;
}

# vim: expandtab shiftwidth=4
