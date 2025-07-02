use SBOM::Enum:ver<0.0.1>:auth<zef:lizmat>;

class SBOM::LearningType:ver<0.0.1>:auth<zef:lizmat> does SBOM::Enum { }
BEGIN SBOM::LearningType.setup(
  "supervised",
  "Supervised machine learning involves training an algorithm on labeled data to predict or classify new data based on the patterns learned from the labeled examples.",

  "unsupervised",
  "Unsupervised machine learning involves training algorithms on unlabeled data to discover patterns, structures, or relationships without explicit guidance, allowing the model to identify inherent structures or clusters within the data.",

  "reinforcement-learning",
  "Reinforcement learning is a type of machine learning where an agent learns to make decisions by interacting with an environment to maximize cumulative rewards, through trial and error.",

  "semi-supervised",
  "Semi-supervised machine learning utilizes a combination of labeled and unlabeled data during training to improve model performance, leveraging the benefits of both supervised and unsupervised learning techniques.",

  "self-supervised",
  "Self-supervised machine learning involves training models to predict parts of the input data from other parts of the same data, without requiring external labels, enabling learning from large amounts of unlabeled data.",
);

# vim: expandtab shiftwidth=4
