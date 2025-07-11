use SBOM:ver<0.0.3>:auth<zef:lizmat>;

#- StrOrProperty ---------------------------------------------------------------
class SBOM::Property { ... }

#| Allow for a Property or a string
role SBOM::StrOrProperty:ver<0.0.3>:auth<zef:lizmat> {
    multi method new(SBOM::StrOrProperty:U: Str:D $string) {
        $string but SBOM::StrOrProperty
    }
    multi method new(SBOM::StrOrProperty:U: :$raw-error) is default {
        SBOM::Property.new(:$raw-error, |%_)
    }
}

#- Property --------------------------------------------------------------------
#| Provides the ability to document properties in a name-value store.
#| This provides flexibility to include data not officially supported
#| in the standard without having to use additional namespaces or
#| create extensions. Unlike key-value stores, properties support
#| duplicate names, each potentially having different values.
#| Property names of interest to the general public are encouraged to
#| be registered in the CycloneDX Property Taxonomy. Formal registration
#| is optional.
class SBOM::Property:ver<0.0.3>:auth<zef:lizmat>
  does SBOM::StrOrProperty does SBOM {

#| The name of the property. Duplicate names are allowed.
    has Str $.name is required;

#| The value of the property.
    has Str $.value;

    multi method Str(SBOM::Property:D:) { $.name }
}

# vim: expandtab shiftwidth=4
