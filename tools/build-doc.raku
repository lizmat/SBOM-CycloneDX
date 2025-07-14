#!/usr/bin/env raku 

use lib $*PROGRAM.parent(2);
use SBOM::enums;
use SBOM::CycloneDX;

my %seen;
my %classes;
my %subsets;

sub introspect(Mu $class) {
    for $class.^attributes -> $attribute {
        my $type := $attribute.type;
        $type := $type.of if $type ~~ Positional;
        my $name := $type.^name;
        next if %seen{$name}:exists;

        %seen{$name} := True;
        if $type ~~ Enumify {
            # no action needed
        }
        elsif $type.HOW ~~ Metamodel::SubsetHOW {
            %subsets{$name} := $type;
        }
        elsif $type ~~ SBOM {
            %classes{$name} := $type;
            introspect($type)
        }
    }
}

introspect(SBOM::CycloneDX);

#- production ------------------------------------------------------------------
sub produce-pod(Mu $class) {
    say "";
    with $class.WHY -> $rakudoc {
        say "$rakudoc.Str()  Accepts these named arguments:".naive-word-wrapper;
        say "";
    }

    for $class.^attributes.grep(*.name ne '@!build-errors') -> $attribute {
        my $type := $attribute.type;
        $type := $type.of if $type ~~ Positional;
        my str $name = "$type.^name() C<:$attribute.name.subst("!")>";
        $name ~= " (required)" if $attribute.required;

        say "=item $name";
        say "";
        with $attribute.WHY -> $rakudoc {
            say $rakudoc.Str.naive-word-wrapper;
            say "";
        }
    }
}

my $io := $*PROGRAM.parent.sibling("doc/SBOM-CycloneDX.rakudoc");
my @lines = $io.lines(:!chomp);
my $*OUT = $io.open(:w);

while @lines && @lines.shift -> $line {
    print $line;

    if $line eq "=head1 ENUMS PROVIDED\n" {
        until @lines.head eq "=head1 ENUMS API\n" {
            @lines.shift;
        }
        say "";

        for Enumify.keys -> $name {
            my $enum := Enumify.AT-KEY($name);

            say "=head2 $name";
            say "";
            say $enum.WHY.Str.naive-word-wrapper;
            say "";

            my @enums = $enum.keys;
            if @enums > 100 {
                say "@enums.elems() strings supported.";
            }
            else {
                say "Supported strings:";
                say "=item $_" for @enums;
            }
            say "";

        }
    }
    elsif $line eq "=head1 SUBSETS PROVIDED\n" {
        until @lines.head eq "=head1 SUBSETS API\n" {
            @lines.shift;
        }
        say "";

        for %subsets.sort(*.key.fc) {
            my $name   := .key;
            my $subset := .value;

            say "=head2 $name";
            say "";
            if $subset.WHY -> $rakudoc {
                say $rakudoc.Str.naive-word-wrapper;
            }
            elsif $name eq 'UInt' {  # provided by core without WHY
                say "An unsigned integer value (>= 0)";
            }
            say "";
        }
    }
    elsif $line eq "=head2 SBOM::CycloneDX\n" {
        until @lines.head eq "=head1 SUBSETS PROVIDED\n" {
            @lines.shift;
        }

        produce-pod(SBOM::CycloneDX);

        %classes<SBOM::CycloneDX>:delete;
        for %classes.sort(*.key.fc) {
            say "=head2 $_.key()";
            produce-pod(.value);
        }
    }
}

$*OUT.close;

# vim: expandtab shiftwidth=4
