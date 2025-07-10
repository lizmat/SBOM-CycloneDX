use Test;
use SBOM::enums;    # for .EVAL
use SBOM::subsets;  # for .EVAL
use SBOM::CycloneDX;

my sub test-map-json(
  $class, \args, $json, $description = 'complete'
) is test-assertion is export {

    subtest "$class.^name(): $description" => {
        plan 6;

        my $instance := $class.new(:raw-error, |args);
        isa-ok $instance, $class;

        nok $instance.build-errors, 'should be without errors';

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

# vim: expandtab shiftwidth=4
