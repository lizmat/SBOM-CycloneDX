use SBOM::enums:ver<0.0.1>:auth<zef:lizmat> <
  Learning
>;

use SBOM::ModelDataset:ver<0.0.1>:auth<zef:lizmat>;

#- Approach --------------------------------------------------------------------
#| The overall approach to learning used by the model for problem
#| solving.
class SBOM::Approach:ver<0.0.1>:auth<zef:lizmat> {

#| Learning types describing the learning problem or hybrid learning
#| problem.
    has Learning $.type;
}

#- ModelFormat -----------------------------------------------------------------
#| The input / output format of a model
class SBOM::ModelFormat:ver<0.0.1>:auth<zef:lizmat> {

#| The data format for input/output to the model, e.g. "string",
#| "image", "time-series".
    has Str $.format;
}

#- ModelParameters -------------------------------------------------------------
#| Hyper-parameters for construction of the model.
class SBOM::ModelParameters:ver<0.0.1>:auth<zef:lizmat> {

#| The overall approach to learning used by the model for problem
#| solving.
    has SBOM::Approach    $.approach;

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
