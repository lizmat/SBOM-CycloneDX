use SBOM::enums:ver<0.0.13>:auth<zef:lizmat> <
  ReleaseLevel
>;

use SBOM::subsets:ver<0.0.13>:auth<zef:lizmat> <
  locale URL
>;

use SBOM:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.13>:auth<zef:lizmat>;
use SBOM::Resolve:ver<0.0.13>:auth<zef:lizmat>;

#- Note ------------------------------------------------------------------------
#| A release note containing the locale and content.
class SBOM::Note:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The ISO-639 (or higher) language code and optional ISO-3166 (or
#| higher) country code.
    has locale $.locale;

#| Specifies the full content of the release note.
    has SBOM::Attachment $.text is required;
}

#- ReleaseNotes ----------------------------------------------------------------
class SBOM::ReleaseNotes:ver<0.0.13>:auth<zef:lizmat> does SBOM {

#| The software versioning type the release note describes.
    has ReleaseLevel $.type is required;

#| The title of the release.
    has Str $.title;

#| The URL to an image that may be prominently displayed with the
#| release note.
    has URL $.featuredImage;

#| The URL to an image that may be used in messaging on social media
#| platforms.
    has URL $.socialImage;

#| A short description of the release.
    has Str $.description;

#| The date and time (timestamp) when the release note was created.
    has DateTime $.timestamp;

#| One or more alternate names the release may be referred to. This
#| may include unofficial terms used by development and marketing
#| teams (e.g. code names).
    has Str @.aliases;

#| Textual strings that aid in discovery, search, and retrieval of
#| the associated object. Tags often serve as a way to group or
#| categorize similar or related objects by various attributes.
    has Str @.tags;

#| A collection of issues that have been resolved.
    has SBOM::Resolve @.resolves;

#| Zero or more release notes containing the locale and content.
#| Multiple note objects may be specified to support release notes
#| in a wide variety of languages.
    has SBOM::Note @.notes;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    # These should probably be auto-generated in RakUAST at some point
    method aliases(   SBOM::ReleaseNotes:D:) { @!aliases.List    }
    method tags(      SBOM::ReleaseNotes:D:) { @!tags.List       }
    method resolves(  SBOM::ReleaseNotes:D:) { @!resolves.List   }
    method notes(     SBOM::ReleaseNotes:D:) { @!notes.List      }
    method properties(SBOM::ReleaseNotes:D:) { @!properties.List }
}

# vim: expandtab shiftwidth=4
