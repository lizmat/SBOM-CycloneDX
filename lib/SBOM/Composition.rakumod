use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Aggregate
>;

use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref bomLinkElement
>;

use SBOM::Signature:ver<0.0.1>:auth<zef:lizmat>;

#| Compositions describe constituent parts (including components,
#| services, and dependency relationships) and their completeness.
#| The completeness of vulnerabilities expressed in a BOM may also
#| be described.
class SBOM::Composition:ver<0.0.1>:auth<zef:lizmat> {

#| An optional identifier which can be used to reference the
#| composition elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| Specifies an aggregate type that describes how complete a
#| relationship is.
    has Aggregate $.aggregate = Aggregate("not_specified");

#| The bom-ref identifiers of the components or services being
#| described. Assemblies refer to nested relationships whereby a
#| constituent part may include other constituent parts. References
#| do not cascade to child parts. References are explicit for the
#| specified constituent part only.
    has bomLinkElement @.assemblies;

#| The bom-ref identifiers of the components or services being
#| described. Dependencies refer to a relationship whereby an
#| independent constituent part requires another independent
#| constituent part. References do not cascade to transitive
#| dependencies. References are explicit for the specified
#| dependency only.
    has bom-ref @.dependencies;;

#| The bom-ref identifiers of the vulnerabilities being described.
    has bom-ref @.vulnerabilities;;

#| Enveloped signature in JSON Signature Format (JSF).
    has SBOM::ValidSignature $.signature;
}

# vim: expandtab shiftwidth=4
