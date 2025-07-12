use SBOM::subsets:ver<0.0.3>:auth<zef:lizmat> <
  bom-ref email URL
>;

use SBOM:ver<0.0.3>:auth<zef:lizmat>;

#- Governor --------------------------------------------------------------------
class SBOM::Contact      { ... }
class SBOM::Organization { ... }

#| A person or organization governing data
class SBOM::Governor:ver<0.0.3>:auth<zef:lizmat> does SBOM {
    multi method new(SBOM::Governor:U: :$raw-error) {
        my $class := %_<contact> || %_<address> || %_<url>
          ?? SBOM::Organization
          !! SBOM::Contact;

        $class.new(:$raw-error, |%_)
    }
}

#- Address ---------------------------------------------------------------------
#| The physical address (location) of the organization.
class SBOM::Address:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the
#| address elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The country name or the two-letter ISO 3166-1 country code.
    has Str $.country;

#| The region or state in the country.
    has Str $.region;

#| The locality or city within the country.
    has Str $.locality;

#| The post office box number.
    has Str $.postOfficeBoxNumber;

#| The postal code.
    has Str $.postalCode;

#| The street address.
    has Str $.streetAddress;
}

#- Contact ---------------------------------------------------------------------
#| A person.
class SBOM::Contact:ver<0.0.3>:auth<zef:lizmat>
  is SBOM::Governor does SBOM {

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

#- Organization ----------------------------------------------------------------
#| An organization, as opposed to a person.
class SBOM::Organization:ver<0.0.3>:auth<zef:lizmat>
  is SBOM::Governor does SBOM {

#| An optional identifier which can be used to reference the object
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The name of the organization.
    has Str $.name;

#| The physical address (location) of the organization.
    has SBOM::Address $.address;

#| The URL of the organization. Multiple URLs are allowed.
    has URL @.url;

#| A contact at the organization. Multiple contacts are allowed.
    has SBOM::Contact @.contact;
}

#-------------------------------------------------------------------------------
#| An individual or an organizaton
class SBOM::IndividualOrOrganization:ver<0.0.3>:auth<zef:lizmat> does SBOM {

#| An individual
    has SBOM::Contact $.individual;

#| An organization
    has SBOM::Organization $.organization;

    submethod TWEAK() {
        die "Must either have 'individual' or 'organization' specified"
          unless one($!individual, $!organization);
    }
}

# vim: expandtab shiftwidth=4
