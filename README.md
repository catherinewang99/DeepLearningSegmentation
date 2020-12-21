# Deep Learning Stroke Lesion Segmentation
The following document keeps track of the data pre-processing, the network configuration, and the saved model in the deep learning stroke lesion segmentation study. This document will be split into three parts.
1. Data Pre-processing
2. Network configuration
3. Saved model

## Data Pre-processing

The folder with all the bash scripts used to run the data pre-processing step can be found in [this folder](https://github.com/catherinewangberkeley/DeepLearningSegmentation/tree/main/data%20processing/my_scripts).

The ATLAS dataset that we worked with gave us MRI T2s scans of brains in native space, along with hand-drawn lesion masks. The dataset included 304 brains separated into 11 cohorts.

### 1. Brain extraction
Since the brains scans included the skulls, we needed to first extract the brains from the skulls. Code for this can be found in the [extract_brain.sh](https://github.com/catherinewangberkeley/DeepLearningSegmentation/blob/main/data%20processing/my_scripts/extract_brains.sh) file. Note that the batch number was manually changed for each of the 11 cohorts.

### 2. Brain extraction
