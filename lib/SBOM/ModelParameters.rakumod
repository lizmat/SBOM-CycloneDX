use SBOM::enums:ver<0.0.7>:auth<zef:lizmat> <
  DataSource Learning
>;

use SBOM::subsets:ver<0.0.7>:auth<zef:lizmat> <
  bom-ref
>;

use SBOM:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::DataContents:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Governance:ver<0.0.7>:auth<zef:lizmat>;
use SBOM::Graphics:ver<0.0.7>:auth<zef:lizmat>;

#- Approach --------------------------------------------------------------------
#| The overall approach to learning used by the model for problem
#| solving.
class SBOM::Approach:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| Learning types describing the learning problem or hybrid learning
#| problem.
    has Learning $.type;
}

#- ModelDataset ----------------------------------------------------------------
#| A dataset used to train and evaluate the model.
class SBOM::ModelDataset:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| An optional identifier which can be used to reference the dataset
#| elsewhere in the BOM.
    has bom-ref $.bom-ref;

#| The general theme or subject matter of the data being specified.
    has DataSource $.type is required;

#| The name of the dataset.
    has Str $.name;

#| The contents or references to the contents of the data being described.
    has SBOM::DataContents $.contents;

#| Data classification tags data according to its type, sensitivity,
#| and value if altered, stolen, or destroyed.
    has Str $.classification;

#| A description of any sensitive data in a dataset.
    has Str @.sensitiveData;

#| A collection of graphics that represent various measurements.
    has SBOM::Graphics $.graphics;

#| A description of the dataset. Can describe size of dataset, whether
#| it's used for source code, training, testing, or validation, etc.
    has Str $.description;

#| Data governance captures information regarding data ownership,
#| stewardship, and custodianship, providing insights into the
#| individuals or entities responsible for managing, overseeing,
#| and safeguarding the data throughout its lifecycle.
    has SBOM::Governance $.governance;
}

#- ModelFormat -----------------------------------------------------------------
#| The input / output format of a model
class SBOM::ModelFormat:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| The data format for input/output to the model, e.g. "string",
#| "image", "time-series".
    has Str $.format;
}

#- ModelParameters -------------------------------------------------------------
#| Hyper-parameters for construction of the model.
class SBOM::ModelParameters:ver<0.0.7>:auth<zef:lizmat> does SBOM {

#| The overall approach to learning used by the model for problem
#| solving.
    has SBOM::Approach $.approach;

#| Directly influences the input and/or output. Examples include
#| classification, regression, clustering, etc.
    has Str $.task;

#| The model architecture family such as transformer network,
#| convolutional neural network, residual neural network, LSTM
#| neural network, etc.
    has Str $.architectureFamily;

#| The specific architecture of the model such as GPT-1, ResNet-50,
#| YOLOv3, etc.
    has Str $.modelArchitecture;

#| The datasets used to train and evaluate the model.
    has SBOM::ModelDataset @.datasets;

#| The input format(s) of the model.
    has SBOM::ModelFormat @.inputs;

#| The output format(s) of the model.
    has SBOM::ModelFormat @.outputs;
}

# vim: expandtab shiftwidth=4
