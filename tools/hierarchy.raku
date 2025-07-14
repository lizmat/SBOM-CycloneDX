#!/usr/bin/env raku 

use lib $*PROGRAM.parent(2);
use SBOM::enums;
use SBOM::CycloneDX;

my %recurse;

sub types(Mu $class, str $indent = "  ") {
    my %seen;

    for $class.^attributes -> $attribute {
        my $type := $attribute.type;
        $type := $type.of if $type ~~ Positional;
        my str $name = "$type.^name.subst("SBOM::") $attribute.name.subst("!")";
        $name ~= " (required)" if $attribute.required;

        # Don't ever recurse on enums, subsets and core types
        if $type ~~ Enumify
          || $type.HOW ~~ Metamodel::SubsetHOW
          || $type ~~ Cool | DateTime {
            %recurse{$name} := True;
        }

        unless %seen{$name} {
            %seen{$name} := True;

            say $indent eq "  "
              ?? ("- $name " ~ "-" x (60 - $name.chars))
              !! "$indent$name";

#            if $attribute.WHY // $type.WHY -> $WHY {
#                say $WHY.Str.naive-word-wrapper(:60max, :$indent);
#            }
            say "";

            if $name eq 'Component' && $indent ne "  " {
                # only recurse Component at "top" level
            }
            elsif !%recurse{$name} {
                %recurse{$name} := True;
                types($type, "$indent  ");
            }
        }
    }
}

say "CycloneDX";
types SBOM::CycloneDX;
