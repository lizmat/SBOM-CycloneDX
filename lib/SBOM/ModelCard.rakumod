use SBOM::subsets:ver<0.0.15>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.15>:auth<zef:lizmat>;
use SBOM::Considerations:ver<0.0.15>:auth<zef:lizmat>;
use SBOM::Graphics:ver<0.0.15>:auth<zef:lizmat>;
use SBOM::ModelParameters:ver<0.0.15>:auth<zef:lizmat>;
use SBOM::Property:ver<0.0.15>:auth<zef:lizmat>;

#- ConfidenceInterval ----------------------------------------------------------
#| The confidence interval of a metric.
class SBOM::ConfidenceInterval:ver<0.0.15>:auth<zef:lizmat> does SBOM {

#| The lower bound of the confidence interval.
    has Str $.lowerBound;

#| The upper bound of the confidence interval.
    has Str $.upperBound;
}

#- PerformanceMetric -----------------------------------------------------------
#| The model performance metrics being reported. Examples may include
#| accuracy, F1 score, precision, top-3 error rates, MSC, etc.
class SBOM::PerformanceMetric:ver<0.0.15>:auth<zef:lizmat> does SBOM {

#| The type of performance metric.
    has Str $.type;

#| The value of the performance metric.
    has Str $.value;

#| The name of the slice this metric was computed on. By default,
#| assume this metric is not sliced.
    has Str $.slice;

#| The confidence interval of the metric.
    has SBOM::ConfidenceInterval $.confidenceInterval;
}

#- QuantitativeAnalysis --------------------------------------------------------
#| A quantitative analysis of a model
class SBOM::QuantitativeAnalysis:ver<0.0.15>:auth<zef:lizmat> does SBOM {

#| The model performance metrics being reported.
    has SBOM::PerformanceMetric @.performanceMetrics;

#| A collection of graphics that represent various measurements.
    has SBOM::Graphics $.graphics;

    # These should probably be auto-generated in RakUAST at some point
    method performanceMetrics(SBOM::QuantitativeAnalysis:D:) {
        @!performanceMetrics.List
    }
}

#- ModelCard -------------------------------------------------------------------
#| A model card describes the intended uses of a machine learning model
#| and potential limitations, including biases and ethical considerations.
#| Model cards typically contain the training parameters, which datasets
#| were used to train the model, performance metrics, and other relevant
#| data useful for ML transparency.
class SBOM::ModelCard:ver<0.0.15>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the model card
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| Hyper-parameters for construction of the model.
    has SBOM::ModelParameters $.modelParameters;

#| A quantitative analysis of the model
    has SBOM::QuantitativeAnalysis $.quantitativeAnalysis;
    has SBOM::Considerations $.considerations;

#| Any additional properties as name-value pairs.
    has SBOM::Property @.properties;

    # These should probably be auto-generated in RakUAST at some point
    method properties(SBOM::ModelCard:D:) { @!properties.List }
}

# vim: expandtab shiftwidth=4
