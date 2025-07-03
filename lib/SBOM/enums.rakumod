use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;

my role Enumify {
    has $.name;
    has $.WHY;

    my %enums is Map;

    multi method setup(Enumify:U: Str:D $key) {
        self.setup(%?RESOURCES{"enums/$key"}.open.lines(:close).Array)
    }

    multi method setup(Enumify:U: @setup) {
        my %hash;
        while @setup {
            my $name  = @setup.shift;
            my $WHY   = @setup.shift // "";
            if $WHY {
                while @setup && @setup.shift -> $next {
                    $WHY ~= "\n$next";
                }
            }
            %hash{$name} := self.new(:$name, :$WHY);
        }
        %enums := %hash.Map;
    }

    proto method name() {*}
    multi method name(Enumify:U:) { ""     }
    multi method name(Enumify:D:) { $!name }

    proto method WHY() {*}
    multi method WHY(Enumify:U:) {
        "No description available for '" ~ self.^name ~ "' enum"
    }
    multi method WHY(Enumify:D:) {
        $!WHY
    }

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

#-------------------------------------------------------------------------------
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

#- J ---------------------------------------------------------------------------
my class Justification:ver<0.0.1>:auth<zef:lizmat> does Enumify {
    multi method WHY(Justification:U:) {
        "The rationale of why the impact analysis state was asserted."
    }
}

#- L ---------------------------------------------------------------------------
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

#- R ---------------------------------------------------------------------------
my class Response:ver<0.0.1>:auth<zef:lizmat> does Enumify {
    multi method WHY(Response:U:) {
        "A response to the vulnerability by the manufacturer, supplier, or project responsible for the affected component or service. More than one response is allowed. Responses are strongly encouraged for vulnerabilities where the analysis state is exploitable."
    }
}

my class VulnerabilityState:ver<0.0.1>:auth<zef:lizmat> does Enumify {
    multi method WHY(VulnerabilityState:U:) {
        "Declares the current state of an occurrence of a vulnerability, after automated or manual analysis."
    }
}

#-O ----------------------------------------------------------------------------
my class OutputType:ver<0.0.1>:auth<zef:lizmat> does Enumify {
    multi method WHY(OutputType:U:) {
        "Describes the type of data output."
    }
}

#- T ---------------------------------------------------------------------------
my class TaskActivity:ver<0.0.1>:auth<zef:lizmat> does Enumify {
    multi method WHY(TaskActivity:U:) {
        "Indicates the types of activities performed by the set of workflow tasks"
    }
}
my class TriggerEvent:ver<0.0.1>:auth<zef:lizmat> does Enumify {
    multi method WHY(TriggerEvent:U:) {
        "The source type of event which caused the trigger to fire."
    }
}

#- process resources -----------------------------------------------------------
# Read the resources section of the META6.json to figure out which
# text files need to be processed into their associated classes
BEGIN ::($_).setup($_) for $?DISTRIBUTION.meta<resources>.map: {
    .substr(6) if .starts-with("enums/")
}

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
