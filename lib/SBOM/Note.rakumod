use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  locale
>;

use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Note:ver<0.0.1>:auth<zef:lizmat> {
    has locale     $.locale;
    has SBOM::Attachment $.text is required;
}

# vim: expandtab shiftwidth=4
