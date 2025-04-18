#  RiceDRDLM: A deep learning framework to identify disease-resistance proteins in _Oryza sativa_ and its related species

## Graphical overview
![Graphical abstract](https://github.com/VedikaaDhiman/Deep-learning-based-model-predicting-resistance-proteins-in-rice-and-related-species/blob/main/Abstract.png?raw=true)

Rice (_Oryza sativa_) is a significant agricultural crop consumed by more than half of the global population. Moreover, it is severely affected by biotic stresses, reducing yield losses. Developing disease-resistant varieties is the best-suited way to counter these stresses, and this can be done through the identification of the disease-resistance proteins. Thus, a Deep Learning model is developed in rice and its related species to accurately and rapidly identify such proteins, which will contribute to develope novel disease-resistant varieties in rice.

# Data pre-processing, feature extraction and selection

The pre-processing, feature extraction and selection were performed in the R program. The following is the detailed information of the scripts used to perform these steps:
1. ```feature_extraction_negative_dataset.R```: Script for feature extraction in the negative dataset
2. ```feature_extraction_negative_dataset.R```: Script for feature extraction in the positive dataset
3. ```feature_selection_fscore_libsvm.py```: Script for feature selection on the extracted features by libSVM (https://github.com/cjlin1/libsvm)

# DL Model Building and testing

The Deep Learning model is developed and cross-validated on internal and external datasets. Experimentally validated and whole sets of proteins are the internal datasets. On the other hand, proteins involved in disease resistance mechanisms and morphological and flowering development are the external datasets. in the Jupyter Notebook and is described in the following script:
```Internal Dataset/Python script1 .ipynb```: Script for model development and its validation on internal dataset
```External Dataset/Python script2 .ipynb```: Script for model development and its validation on external dataset


