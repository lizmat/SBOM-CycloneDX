use SBOM::Graphics:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::ConfidenceInterval:ver<0.0.1>:auth<zef:lizmat> {
    has Str $.lowerBound;
    has Str $.UpperBound;
}

class SBOM::PerformanceMetric:ver<0.0.1>:auth<zef:lizmat> {
    has Str                      $.type;
    has Str                      $.value;
    has Str                      $.slice;
    has SBOM::ConfidenceInterval $.confidenceInterval;
}

class SBOM::QuantitativeAnalysis:ver<0.0.1>:auth<zef:lizmat> {
    has SBOM::PerformanceMetric @.performanceMetrics;
    has SBOM::Graphics          $.graphics;
}

# vim: expandtab shiftwidth=4
