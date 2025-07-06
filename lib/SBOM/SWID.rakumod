use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  URL
>;

use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

#| Asserts the identity of the component using ISO-IEC 19770-2 Software
#| Identification (SWID) Tags. Refer to @.evidence.identity to
#| optionally provide evidence that substantiates the assertion of
#| the component's identity.
class SBOM::SWID:ver<0.0.1>:auth<zef:lizmat> {

#| Maps to the tagId of a SoftwareIdentity.
    has Str:D $.tagID is required;

#| Maps to the name of a SoftwareIdentity.
    has Str:D $.name  is required;

#| Maps to the version of a SoftwareIdentity.
    has Str:D $.version = "0.0";

#| Maps to the tagVersion of a SoftwareIdentity.
    has Int:D @.tagVersion = 1;

#| Maps to the patch of a SoftwareIdentity.
    has Bool:D $.patch = False;

#| Specifies the metadata and content of the SWID tag.
    has SBOM::Attachment $.text;

#| The URL to the SWID file.
    has URL $.url;
}

# vim: expandtab shiftwidth=4
