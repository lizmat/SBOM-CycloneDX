use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  OutputType
>;

use SBOM::Property:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Reference:ver<0.0.1>:auth<zef:lizmat>;
use SBOM::Attachment:ver<0.0.1>:auth<zef:lizmat>;

#- Output ----------------------------------------------------------------------
#| Represents resources and data output from a task at runtime by
#| executor or task commands.
class SBOM::Output:ver<0.0.1>:auth<zef:lizmat> {
    has OutputType           $.type;
    has SBOM::resourceRef    $.source;
    has SBOM::resourceRef    $.target;
    has SBOM::resourceRef    $.resource;
    has SBOM::Attachment           $.data;
    has SBOM::StrOrProperty @.environmentVars;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    submethod TWEAK() {
        die "Must have at least 'resource', 'environmentVars' or 'data'"
          unless $!resource  || @!environmentVars || $!data;
    }
}

# vim: expandtab shiftwidth=4
