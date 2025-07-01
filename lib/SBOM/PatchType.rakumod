use SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::PatchType:ver<0.0.1>:auth<zef:lizmat>
  does SBOM::NameDescription {
}

enum patchType (
  patchUnoffical => SBOM::PatchType.new(
    "unoffical",
    "A patch which is not developed by the creators or maintainers of the software being patched. Refer to https://en.wikipedia.org/wiki/Unofficial_patch."
  ),
  patchMonkey => SBOM::PatchType.new(
    "monkey",
    "A patch which dynamically modifies runtime behavior. Refer to https://en.wikipedia.org/wiki/Monkey_patch."
  ),
  patchBackport => SBOM::PatchType.new(
    "backport",
    "A patch which takes code from a newer version of the software and applies it to older versions of the same software. Refer to https://en.wikipedia.org/wiki/Backporting."
  ),
  patchCherry-pick => SBOM::PatchType.new(
    "cherry-pick",
    "A patch created by selectively applying commits from other versions or branches of the same software."
  )
);

# vim: expandtab shiftwidth=4
