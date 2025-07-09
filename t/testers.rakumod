use Test;
use SBOM::enums;    # for .EVAL
use SBOM::subsets;  # for .EVAL
use SBOM::CycloneDX;

my sub test-map-json(
  $class, \args, $json, $description = 'complete'
) is test-assertion is export {

    subtest "$class.^name(): $description" => {
        plan 5;

        my $instance := $class.new(|args);
        isa-ok $instance, $class;

        my %map := $instance.Map;
        is-deeply %map, args, 'does .Map work';

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
