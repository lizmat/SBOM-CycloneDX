use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::Phase:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum lifecylePhase (
  phaseDesign => SBOM::Phase.new(
    "design",
    "BOM produced early in the development lifecycle containing an inventory of components and services that are proposed or planned to be used. The inventory may need to be procured, retrieved, or resourced prior to use."
  ),
  phasePre-build => SBOM::Phase.new(
    "pre-build",
    "BOM consisting of information obtained prior to a build process and may contain source files and development artifacts and manifests. The inventory may need to be resolved and retrieved prior to use."
  ),
  phaseBuild => SBOM::Phase.new(
    "build",
    "BOM consisting of information obtained during a build process where component inventory is available for use. The precise versions of resolved components are usually available at this time as well as the provenance of where the components were retrieved from."
  ),
  phasePost-build => SBOM::Phase.new(
    "post-build",
    "BOM consisting of information obtained after a build process has completed and the resulting components(s) are available for further analysis. Built components may exist as the result of a CI/CD process, may have been installed or deployed to a system or device, and may need to be retrieved or extracted from the system or device."
  ),
  phaseOperations => SBOM::Phase.new(
    "operations",
    "BOM produced that represents inventory that is running and operational. This may include staging or production environments and will generally encompass multiple SBOMs describing the applications and operating system, along with HBOMs describing the hardware that makes up the system. Operations Bill of Materials (OBOM) can provide full-stack inventory of runtime environments, configurations, and additional dependencies."
  ),
  phaseDiscovery => SBOM::Phase.new(
    "discovery",
    "BOM consisting of information observed through network discovery providing point-in-time enumeration of embedded, on-premise, and cloud-native services such as server applications, connected devices, microservices, and serverless functions."
  ),
  phaseDecommision => SBOM::Phase.new(
    "decommision",
    "BOM containing inventory that will be, or has been retired from operations."
  )
);

# vim: expandtab shiftwidth=4
