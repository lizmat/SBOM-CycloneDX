use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::LicenseType:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum licenseType (
  licenseAcademic => SBOM::LicenseType.new(
    "academic",
    "A license that grants use of software solely for the purpose of education or research."
  ),
  licenseAppliance => SBOM::LicenseType.new(
    "appliance",
    "A license covering use of software embedded in a specific piece of hardware."
  ),
  licenseClient-access => SBOM::LicenseType.new(
    "client-access",
    "A Client Access License (CAL) allows client computers to access services provided by server software."
  ),
  licenseConcurrent-user => SBOM::LicenseType.new(
    "concurrent-user",
    "A Concurrent User license (aka floating license) limits the number of licenses for a software application and licenses are shared among a larger number of users."
  ),
  licenseCore-points => SBOM::LicenseType.new(
    "core-points",
    "A license where the core of a computer's processor is assigned a specific number of points."
  ),
  licenseCustom-metric => SBOM::LicenseType.new(
    "custom-metric",
    "A license for which consumption is measured by non-standard metrics."
  ),
  licenseDevice => SBOM::LicenseType.new(
    "device",
    "A license that covers a defined number of installations on computers and other types of devices."
  ),
  licenseEvaluation => SBOM::LicenseType.new(
    "evaluation",
    "A license that grants permission to install and use software for trial purposes."
  ),
  licenseNamed-user => SBOM::LicenseType.new(
    "named-user",
    "A license that grants access to the software to one or more pre-defined users."
  ),
  licenseNode-locked => SBOM::LicenseType.new(
    "node-locked",
    "A license that grants access to the software on one or more pre-defined computers or devices."
  ),
  licenseOEM => SBOM::LicenseType.new(
    "oem",
    "An Original Equipment Manufacturer license that is delivered with hardware, cannot be transferred to other hardware, and is valid for the life of the hardware."
  ),
  licensePerpetual => SBOM::LicenseType.new(
    "perpetual",
    "A license where the software is sold on a one-time basis and the licensee can use a copy of the software indefinitely."
  ),
  licenseProcessor-points => SBOM::LicenseType.new(
    "processor-points",
    "A license where each installation consumes points per processor."
  ),
  licenseSubscription => SBOM::LicenseType.new(
    "Subscription",
    "A license where the licensee pays a fee to use the software or service."
  ),
  licenseUser => SBOM::LicenseType.new(
    "user",
    "A license that grants access to the software or service by a specified number of users."
  ),
  licenseOther => SBOM::LicenseType.new(
    "other",
    "Another license type."
  )
);

# vim: expandtab shiftwidth=4
