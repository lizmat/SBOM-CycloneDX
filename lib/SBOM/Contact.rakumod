use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  bom-ref email
>;

use SBOM:ver<0.0.1>:auth<zef:lizmat>;

#| A person.
class SBOM::Contact:ver<0.0.1>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the person
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The name of a contact.
    has Str $.name;

#| The email address of the contact.
    has email $.email;

#| The phone number of the contact.
    has Str $.phone;
}

# vim: expandtab shiftwidth=4
