use Test;
use SBOM::enums;    # for .EVAL
use SBOM::subsets;  # for .EVAL
use SBOM::CycloneDX;

my sub test-map-json(
  $class, \args, $json, $description = 'complete',
  :@bom-refs, :$bom-ref
) is test-assertion is export {
    my @bom-refs-seen := $bom-ref ?? ($bom-ref,) !! @bom-refs;

    subtest "$class.^name(): $description" => {
        plan 6 + ?@bom-refs-seen;

        my $instance := $class.new(:raw-error, |args);
        isa-ok $instance, $class;

        nok $instance.build-errors, 'should be without errors';
        is-deeply $instance.bom-refs, @bom-refs-seen, "Are the bom-refs ok"
          if @bom-refs-seen;

        my %map := $instance.Map;
        # Cannot use is-deeply, as some objects may have a role
        # mixed in.  Even though the mixin has been made invisible
        # by using ^set_name, it is *still* a different type from
        # expected, so use the .raku representation to compare
        is %map.raku, args.raku, 'does .Map work';

        is-deeply
          $instance.raku.subst("new(","new(:raw-error, ").EVAL,
          $instance,
          'can we roundtrip on .raku';

        is-deeply $class.new(|%map), $instance,
          'can we roundtrip on the .Map';

        is $instance.JSON, $json.chomp, 'is the JSON correct';
    }
}

my sub test-hash-json(
  $class, \args, $json, $description = 'complete',
  :@bom-refs, :$bom-ref
) is test-assertion is export {
    my @bom-refs-seen := $bom-ref ?? ($bom-ref,) !! @bom-refs;

    subtest "$class.^name(): $description" => {
        plan 6 + ?@bom-refs-seen;

        my $instance := $class.new(:raw-error, |args);
        isa-ok $instance, $class;

        nok $instance.build-errors, 'should be without errors';
        is-deeply $instance.bom-refs, @bom-refs-seen, "Are the bom-refs ok"
          if @bom-refs-seen;

        my %hash := $instance.Hash;
        # Cannot use is-deeply, as some objects may have a role
        # mixed in.  Even though the mixin has been made invisible
        # by using ^set_name, it is *still* a different type from
        # expected, so use the .raku representation to compare
        is %hash.raku, args.raku, 'does .Hash work';

        is-deeply
          $instance.raku.subst("new(","new(:raw-error, ").EVAL,
          $instance,
          'can we roundtrip on .raku';

        is-deeply $class.new(|%hash), $instance,
          'can we roundtrip on the .Hash';

        is $instance.JSON, $json.chomp, 'is the JSON correct';
    }
}

# vim: expandtab shiftwidth=4
