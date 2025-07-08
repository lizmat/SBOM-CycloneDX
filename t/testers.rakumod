use Test;
use SBOM::enums;
use SBOM::subsets;
use SBOM::CycloneDX;

my sub test-map-json(
  $description, $class, %args, $json
) is test-assertion is export {
    subtest "$class.^name(): $description" => {
        plan 5;

        my $instance := $class.new(|%args);
        isa-ok $instance, $class;

        my %map := $instance.Map;
        is-deeply %map, %args, 'does .Map work';

        is-deeply $instance.raku.EVAL, $instance,
          'can we roundtrip on .raku';

        is-deeply $class.new(|%map), $instance,
          'can we roundtrip on the .Map';

        is $instance.JSON, $json.chomp, 'is the JSON correct';
    }
}

# vim: expandtab shiftwidth=4
