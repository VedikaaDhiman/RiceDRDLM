# Deep learning-based model predicting resistance proteins in rice and related species

Rice (_Oryza sativa_) is a significant agricultural crop consumed by more than half of the global population.
Moreover, it is severely affected by disease-causing pathogens such as fungi,

# Data pre-processing, feature extraction and selection

The pre-processing, feature extraction and selection were performed in the R program. The following is the detailed information of the scripts used to perform these steps:
1. ```feature_extraction_negative_dataset.R```: Script for feature extraction in the negative dataset
2. ```feature_extraction_negative_dataset.R```: Script for feature extraction in the positive dataset
3. ```merge_matrix.R```: Script for merging every single feature matrix generated from the feature extraction steps into a single matrix
4. ```feature_selection_fscore_libsvm.py```: Script for feature selection on the extracted features by libSVM (https://github.com/cjlin1/libsvm)

## DL Model Building

The Deep Learning model is developed and cross-validated in the Jupyter Notebook and is described in the following script:
```Deep learning-based model predicting resistance proteins in rice and related species.ipynb```: Script for model development and its validation
![Uploading Abstract.png…]()
