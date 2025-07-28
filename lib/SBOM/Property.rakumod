use SBOM:ver<0.0.10>:auth<zef:lizmat>;

#- Property --------------------------------------------------------------------
#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values.
#| Property names of interest to the general public are encouraged to
#| be registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
class SBOM::Property:ver<0.0.10>:auth<zef:lizmat> does SBOM {

#| The name of the property. Duplicate names are allowed.
    has Str $.name is required;

#| The value of the property.
    has Str $.value;

    multi method Str(SBOM::Property:D:) { $.name }
}

# vim: expandtab shiftwidth=4
