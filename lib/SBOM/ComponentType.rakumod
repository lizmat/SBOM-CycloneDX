use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ComponentType:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum componentType (
  componentApplication => SBOM::ComponentType.new(
    "application",
    "A software application. Refer to https://en.wikipedia.org/wiki/Application_software for information about applications."
  ),
  componentFramework => SBOM::ComponentType.new(
    "framework",
    "A software framework. Refer to https://en.wikipedia.org/wiki/Software_framework for information on how frameworks vary slightly from libraries."
  ),
  componentLibrary => SBOM::ComponentType.new(
    "library",
    "A software library. Refer to https://en.wikipedia.org/wiki/Library_(computing) for information about libraries. All third-party and open source reusable components will likely be a library. If the library also has key features of a framework, then it should be classified as a framework. If not, or is unknown, then specifying library is recommended."
  ),
  componentContainer => SBOM::ComponentType.new(
    "container",
    "A packaging and/or runtime format, not specific to any particular technology, which isolates software inside the container from software outside of a container through virtualization technology. Refer to https://en.wikipedia.org/wiki/OS-level_virtualization."
  ),
  componentPlatform => SBOM::ComponentType.new(
    "platform",
    "A runtime environment which interprets or executes software. This may include runtimes such as those that execute bytecode or low-code/no-code application platforms."
  ),
  componentOperating-system => SBOM::ComponentType.new(
    "Operating-system",
    "A software operating system without regard to deployment model (i.e. installed on physical hardware, virtual machine, image, etc) Refer to https://en.wikipedia.org/wiki/Operating_system."
  ),
  componentDevice => SBOM::ComponentType.new(
    "device",
    "A hardware device such as a processor or chip-set. A hardware device containing firmware SHOULD include a component for the physical hardware itself and another component of type 'firmware' or 'operating-system' (whichever is relevant), describing information about the software running on the device. See also the list of known device properties."
  ),
  componentDevice-driver => SBOM::ComponentType.new(
    "device-driver",
    "A special type of software that operates or controls a particular type of device. Refer to https://en.wikipedia.org/wiki/Device_driver."
  ),
  componentFirmware => SBOM::ComponentType.new(
    "firmware",
    "A special type of software that provides low-level control over a device's hardware. Refer to https://en.wikipedia.org/wiki/Firmware."
  ),
  componentFile => SBOM::ComponentType.new(
    "file",
    "A computer file. Refer to https://en.wikipedia.org/wiki/Computer_file for information about files."
  ),
  componentMachine-learning-model => SBOM::ComponentType.new(
    "machine-learning-model",
    "A model based on training data that can make predictions or decisions without being explicitly programmed to do so."
  ),
  componentData => SBOM::ComponentType.new(
    "data",
    "A collection of discrete values that convey information."
  ),
  componentCryptographic-asset => SBOM::ComponentType.new(
    "cryptographic-asset",
    "A cryptographic asset including algorithms, protocols, certificates, keys, tokens, and secrets."
  )
);

# vim: expandtab shiftwidth=4
