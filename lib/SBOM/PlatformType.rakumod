use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::PlatformType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::PlatformType.setup(<
  generic
  x86_32
  x86_64
  armv7-a
  armv7-m
  armv8-a
  armv8-m
  armv9-a
  armv9-m
  s390x
  ppc64
  ppc64le
  other
  unknown
>.map({ $_,"" }));

# vim: expandtab shiftwidth=4
