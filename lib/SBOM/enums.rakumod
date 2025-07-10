use JSON::Fast:ver<0.19+>:auth<cpan:TIMOTIMO>;

#| Role for creating SBOM "enums", which are in fact just classes
#| that consume this role
role Enumify {
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

    multi method WHY(Enumify:D:) { $!WHY }

    method WHICH(Enumify:D:) {
        ValueObjAt.new(self.^name ~ '|' ~ $!name)
    }

    multi method raku(Enumify:D:) { $?CLASS.^name ~ "($!name.raku())" }
    multi method Str(Enumify:D:) { $.name }

    method AT-KEY(Enumify:U: Str:D $name) {
        %enums{$name} // Nil
    }
    method CALL-ME(Enumify:U: Str:D $name) {
        %enums{$name} // Nil
    }
}

#- A ---------------------------------------------------------------------------
#| Describes the read-write access control for a workspace relative
#| to the owning resource instance.
my class AccessMode:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Declared licenses and concluded licenses represent two different
#| stages in the licensing process within software development. Declared
#| licenses refer to the initial intention of the software authors
#| regarding the licensing terms under which their code is released.
#| On the other hand, concluded licenses are the result of a
#| comprehensive analysis of the project's codebase to identify and
#| confirm the actual licenses of the components used, which may differ
#| from the initially declared licenses. While declared licenses
#| provide an upfront indication of the licensing intentions, concluded
#| licenses offer a more thorough understanding of the actual licensing
#| within a project, facilitating proper compliance and risk management.
#| Observed licenses are defined in @.evidence.licenses. Observed
#| licenses form the evidence necessary to substantiate a concluded
#| license.
my class Acknowledgement:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The type of activity that is part of a machine learning model
#| development or operational lifecycle.
my class Activity:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Specifies an aggregate type that describes how complete a
#| relationship is.
my class Aggregate:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Cryptographic building blocks used in higher-level cryptographic
#| systems and protocols. Primitives represent different cryptographic
#| routines: deterministic random bit generators (drbg, e.g. CTR_DRBG
#| from NIST SP800-90A-r1), message authentication codes (mac, e.g.
#| HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20),
#| signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key
#| encryption schemes (pke, e.g. RSA), extended output functions (xof,
#| e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement
#| algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM),
#| authenticated encryption (ae, e.g. AES-GCM) and the combination of
#| multiple algorithms (combiner, e.g. SP800-56Cr2).
my class AlgorithmPrimitive:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- B ---------------------------------------------------------------------------
#| Specifies the format of the BOM. This helps to identify the file as
#| CycloneDX since BOMs do not have a filename convention, nor does
#| JSON schema support namespaces.
my class BOMFormat:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- C ---------------------------------------------------------------------------
#| The certification that an implementation of a cryptographic algorithm
#| has received. Certifications include revisions and levels of FIPS 140
#| or Common Criteria of different Extended Assurance Levels (CC-EAL).
my class Certification:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The mode of operation in which a cryptographic algorithm (block
#| cipher) is used.
my class CertificationMode:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The padding scheme that is used for a cryptographic algorithm.
my class CertificationPadding:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Unit of CO2 cost.
my class CO2Cost:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Specifies the type of a component.
my class ComponentType:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The type for the related cryptographic material
my class Crypto:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Cryptographic assets occur in several forms. Algorithms and protocols
#| are most commonly implemented in specialized cryptographic libraries.
#| They may, however, also be 'hardcoded' in software components.
#| Certificates and related cryptographic material like keys, tokens,
#| secrets or passwords are other cryptographic assets to be modelled.
my class CryptoAsset:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| A cryptographic function implemented by a cryptographic algorithm.
my class CryptoFunction:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Public key type indicator.
my class CryptoKey:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| A concrete cryptographic protocol type.
my class CryptoProtocol:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The key state as defined by NIST SP 800-57.
my class CryptoState:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- D ---------------------------------------------------------------------------
#| Specifies information about the directional flow of data.
my class DataFlow:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The general theme or subject matter of model data being specified.
my class DataSource:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- E ---------------------------------------------------------------------------
#| EC curve name.
my class ECCurve:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| EdDSA curve name.
my class EdDSA:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Specifies the optional encoding a text is represented in.
my class Encoding:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The energy source of an energy provider.
my class Energy:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Unit of energy.
my class EnergyUnit:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| A technique used in method of analysis.
my class Evidence:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The target and execution environment in which an algorithm is
#| implemented in.
my class ExecutionEnvironment:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- F ---------------------------------------------------------------------------
#| The identity field of the component which an evidence describes.
my class Field:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- H ---------------------------------------------------------------------------
#| An algorithm to generate a hash value with.
my class HashAlgorithm:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- J ---------------------------------------------------------------------------
#| The rationale of why the impact analysis state was asserted.
my class Justification:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- L ---------------------------------------------------------------------------
#| Learning types describing the learning problem or hybrid
#| learning problem.
my class Learning:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

# fetched from https://raw.githubusercontent.com/spdx/license-list-data/refs/heads/main/json/licenses.json
#| A valid SPDX license identifier.
my class LicenseId:ver<0.0.3>:auth<zef:lizmat> does Enumify { }
BEGIN LicenseId.setup(
  from-json(
    %?RESOURCES<licenses.json>.open.slurp(:close)
  )<licenses>.map({ (.<licenseId>, .<name>, "").Slip }).Array
);

#| A type of license that was granted to the licensee.
my class LicenseGranted:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

# fetched from https://raw.githubusercontent.com/spdx/license-list-data/refs/heads/main/json/licenses.json
#| A valid SPDX license name.
my class LicenseName:ver<0.0.3>:auth<zef:lizmat> does Enumify { }
BEGIN LicenseName.setup(
  from-json(
    %?RESOURCES<licenses.json>.open.slurp(:close)
  )<licenses>.map({ (.<name>, .<licenseId>, "").Slip }).Array
);

#- P ---------------------------------------------------------------------------
#| Specifies the purpose for the patch including the resolution of
#| defects, security issues, or new behavior or functionality.
my class Patch:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Lifecycles communicate the stage(s) in which data in the BOM was
#| captured. Different types of data may be available at various phases
#| of a lifecycle, such as the Software Development Lifecycle (SDLC),
#| IT Asset Management (ITAM), and Software Asset Management (SAM).
#| Thus, a BOM may include data specific to or only obtainable in a
#| given lifecycle.
my class Phase:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| A platform for which an algorithm is implemented.
my class Platform:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- R ---------------------------------------------------------------------------
#| Specifies the type of external reference.
my class ReferenceSource:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The software versioning type of a release note.
my class ReleaseLevel:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| A type of issue resolvement.
my class ResolveType:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| A response to the vulnerability by the manufacturer, supplier, or
#| project responsible for the affected component or service.
#| Responses are strongly encouraged for vulnerabilities where the
#| analysis state is exploitable.
my class Response:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Specifies the severity or risk scoring methodology or standard used.
my class RiskMethodology:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- O ---------------------------------------------------------------------------
#| Describes the type of data output.
my class OutputType:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- S ---------------------------------------------------------------------------
#| The scope of a component.
my class Scope:ver<0.0.3>:auth<zef:lizmat> does Enumify {
    multi method Str(Scope:U:) { "required" }
}

#| Textual representation of a severity.
my class Severity:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Signature algorithm. The currently recognized JWA [RFC7518] and
#| RFC8037 [RFC8037] asymmetric key algorithms. Unlike RFC8037
#| [RFC8037] JSF requires explicit Ed* algorithm names instead ofi
#| "EdDSA".
my class SignatureAlgorithm:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- T ---------------------------------------------------------------------------
#| Indicates the types of activities performed by the set of workflow tasks.
my class TaskActivity:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The source type of event which caused a trigger to fire.
my class TriggerEvent:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#- V ---------------------------------------------------------------------------
#| The vulnerability status for the version or range of versions.
my class VersionAffection:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| The mode for a volume instance.
my class VolumeMode:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

#| Declares the current state of an occurrence of a vulnerability,
#| after automated or manual analysis.
my class VulnerabilityState:ver<0.0.3>:auth<zef:lizmat> does Enumify { }

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
