use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;

my role Enumify {
    has $.name;
    has $.description;

    my %enums is Map;

    multi method setup(Enumify:U: Str:D $key) {
        self.setup(%?RESOURCES{"enums/$key"}.open.lines(:close).Array)
    }

    multi method setup(Enumify:U: @setup) {
        my %hash;
        while @setup {
            my $name        = @setup.shift;
            my $description = @setup.shift // "";
            if $description {
                while @setup && @setup.shift -> $next {
                    $description ~= "\n$next";
                }
            }
            %hash{$name} := self.new(:$name, :$description);
        }
        %enums := %hash.Map;
    }

    proto method name() {*}
    multi method name(Enumify:U:) { ""     }
    multi method name(Enumify:D:) { $!name }

    method WHICH(Enumify:D:) {
        ValueObjAt.new(self.^name ~ '|' ~ $!name)
    }

    multi method Str(Enumify:D:) { $.name }

    method AT-KEY(Enumify:U: Str:D $name) {
        %enums{$name} // Nil
    }
    method CALL-ME(Enumify:U: Str:D $name) {
        %enums{$name} // Nil
    }
}

my class Acknowledgement:ver<0.0.1>:auth<zef:lizmat>      does Enumify { }
my class Activity:ver<0.0.1>:auth<zef:lizmat>             does Enumify { }
my class Aggregate:ver<0.0.1>:auth<zef:lizmat>            does Enumify { }
my class AlgorithmPrimitive:ver<0.0.1>:auth<zef:lizmat>   does Enumify { }
my class CO2Cost:ver<0.0.1>:auth<zef:lizmat>              does Enumify { }
my class Certification:ver<0.0.1>:auth<zef:lizmat>        does Enumify { }
my class CertificationMode:ver<0.0.1>:auth<zef:lizmat>    does Enumify { }
my class CertificationPadding:ver<0.0.1>:auth<zef:lizmat> does Enumify { }
my class Component:ver<0.0.1>:auth<zef:lizmat>            does Enumify { }
my class Crypto:ver<0.0.1>:auth<zef:lizmat>               does Enumify { }
my class CryptoAsset:ver<0.0.1>:auth<zef:lizmat>          does Enumify { }
my class CryptoFunction:ver<0.0.1>:auth<zef:lizmat>       does Enumify { }
my class CryptoKey:ver<0.0.1>:auth<zef:lizmat>            does Enumify { }
my class CryptoProtocol:ver<0.0.1>:auth<zef:lizmat>       does Enumify { }
my class CryptoState:ver<0.0.1>:auth<zef:lizmat>          does Enumify { }
my class DataSource:ver<0.0.1>:auth<zef:lizmat>           does Enumify { }
my class ECCurve:ver<0.0.1>:auth<zef:lizmat>              does Enumify { }
my class Encoding:ver<0.0.1>:auth<zef:lizmat>             does Enumify { }
my class Energy:ver<0.0.1>:auth<zef:lizmat>               does Enumify { }
my class EnergyUnit:ver<0.0.1>:auth<zef:lizmat>           does Enumify { }
my class Evidence:ver<0.0.1>:auth<zef:lizmat>             does Enumify { }
my class ExecutionEnvironment:ver<0.0.1>:auth<zef:lizmat> does Enumify { }
my class Field:ver<0.0.1>:auth<zef:lizmat>                does Enumify { }
my class Format:ver<0.0.1>:auth<zef:lizmat>               does Enumify { }
my class HashAlgorithm:ver<0.0.1>:auth<zef:lizmat>        does Enumify { }
my class Learning:ver<0.0.1>:auth<zef:lizmat>             does Enumify { }
my class LicenseGranted:ver<0.0.1>:auth<zef:lizmat>       does Enumify { }
my class Patch:ver<0.0.1>:auth<zef:lizmat>                does Enumify { }
my class Phase:ver<0.0.1>:auth<zef:lizmat>                does Enumify { }
my class Platform:ver<0.0.1>:auth<zef:lizmat>             does Enumify { }
my class ReferenceSource:ver<0.0.1>:auth<zef:lizmat>      does Enumify { }
my class ReleaseLevel:ver<0.0.1>:auth<zef:lizmat>         does Enumify { }
my class ResolveType:ver<0.0.1>:auth<zef:lizmat>          does Enumify { }
my class RiskMethodology:ver<0.0.1>:auth<zef:lizmat>      does Enumify { }
my class Scope:ver<0.0.1>:auth<zef:lizmat>                does Enumify { }
my class Severity:ver<0.0.1>:auth<zef:lizmat>             does Enumify { }
my class SignatureAlgorithm:ver<0.0.1>:auth<zef:lizmat>   does Enumify { }
my class VulnerabilityState:ver<0.0.1>:auth<zef:lizmat>   does Enumify { }

# Sadly, UNIT::.keys is not set yet at this point at compile time, so
# we need to repeat ourselves
BEGIN ::($_).setup($_) for <
  Acknowledgement Activity Aggregate AlgorithmPrimitive CO2Cost
  Certification CertificationMode CertificationPadding Component
  Crypto CryptoAsset CryptoFunction CryptoKey CryptoProtocol
  CryptoState DataSource ECCurve Encoding Energy EnergyUnit Evidence
  ExecutionEnvironment Field Format HashAlgorithm Learning
  LicenseGranted Patch Phase Platform ReferenceSource ReleaseLevel
  ResolveType RiskMethodology Scope Severity SignatureAlgorithm
  VulnerabilityState
>;

# fetched from https://raw.githubusercontent.com/spdx/license-list-data/refs/heads/main/json/licenses.json
my class LicenseId:ver<0.0.1>:auth<zef:lizmat> does Enumify { }
BEGIN LicenseId.setup(
  from-json(
    %?RESOURCES<licenses.json>.open.slurp(:close)
  )<licenses>.map({ (.<licenseId>, .<name>, "").Slip }).Array
);

my class LicenseName:ver<0.0.1>:auth<zef:lizmat> does Enumify { }
BEGIN LicenseName.setup(
  from-json(
    %?RESOURCES<licenses.json>.open.slurp(:close)
  )<licenses>.map({ (.<name>, .<licenseId>, "").Slip }).Array
);

# vim: expandtab shiftwidth=4

#- EXPORT ----------------------------------------------------------------------
my sub EXPORT(*@names) {
    @names ||= UNIT::.map({ .key if .value ~~ Enumify });
    Map.new: @names.map: {
        if UNIT::{$_}:exists {
            UNIT::{$_}:p
        }
        else {
            my ($in,$out) = .split(':', 2);
            if $out && UNIT::{"$in"} -> $enum {
                Pair.new: "$out", $enum
            }
        }
    }
}


# vim: expandtab shiftwidth=4
