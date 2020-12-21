# Deep Learning Stroke Lesion Segmentation
The following document keeps track of the data pre-processing, the network configuration, and the saved model in the deep learning stroke lesion segmentation study. This document will be split into three parts.
1. Data Pre-processing
2. Network configuration
3. Saved model

## Data Pre-processing

The folder with all the bash scripts used to run the data pre-processing step can be found in [this folder](https://github.com/catherinewangberkeley/DeepLearningSegmentation/tree/main/data%20processing/my_scripts).

The ATLAS dataset that we worked with gave us MRI T1s scans of brains in native space, along with hand-drawn lesion masks. The dataset included 304 brains separated into 11 cohorts.

### 1. Brain extraction
Since the brains scans included the skulls, we needed to first extract the brains from the skulls. Code for this can be found in the [extract_brain.sh](https://github.com/catherinewangberkeley/DeepLearningSegmentation/blob/main/data%20processing/my_scripts/extract_brains.sh) file. Note that the batch number was manually changed for each of the 11 cohorts.

### 2. Reslicing the brains and the lesion masks
Because the brain MRIs and lesion masks in different cohorts existed in different spaces, the next step we took was to reslice each of the scans and lesions into the same space. We used a template brain from the eleventh cohort to slice all the other brains to the same space. The scripts that contain these commands are [extract_brain.sh](https://github.com/catherinewangberkeley/DeepLearningSegmentation/blob/main/data%20processing/my_scripts/extract_brains.sh) and [mask_reslice.sh](https://github.com/catherinewangberkeley/DeepLearningSegmentation/blob/main/data%20processing/my_scripts/mask_reslice.sh).

### 3. Concatenating the lesion masks
From the ATLAS study, many of the lesion masks came in separate files - one for each lesion. In order to feed a single lesion mask per T1 into the deep learning network, we concatenated the lesion masks with the code documented in [add_masks.sh](https://github.com/catherinewangberkeley/DeepLearningSegmentation/blob/main/data%20processing/my_scripts/add_masks.sh).

### 4. Normalizing the brain
In order to standardize the brain gradients across the cohorts, we normalized all of the brain by substracting the mean and dividing by the standard deviation. The script used to do this can be found in [reslice_strip.sh](https://github.com/catherinewangberkeley/DeepLearningSegmentation/blob/main/data%20processing/my_scripts/reslice_strip.sh).

### 5. Creating regions of interest
A requirement of the network are regions of interest. To create these, we took the T1 MRIs and converted all non-zero values to 1s, effectively creating a mask of the brain.

## Network configuration

To document our network configuration for the vanilla run, the cfg files for all the necessary pieces are in the [following folder](https://github.com/catherinewangberkeley/DeepLearningSegmentation/tree/main/model%20configuration/vanilla). The file structure is separated into three pieces: model, test, and train. 

### Data setup
In the [data setup folder](https://github.com/catherinewangberkeley/DeepLearningSegmentation/tree/main/model%20configuration/vanilla/data%20setup), there are a few key pieces of setting up the data pipelines. The Config Creation iPython notebook includes the python scripts used to randomly and evenly separate the brains into the test, train and validation groups. The separation we used for the groups, as documented in the notebook, are 85% train, 10% test, and 5% validation. These separations are fed into cfg files in the [data setup](https://github.com/catherinewangberkeley/DeepLearningSegmentation/tree/main/model%20configuration/vanilla/data%20setup) folder under various filings.

## Saved models

In the [saved models folder](https://github.com/catherinewangberkeley/DeepLearningSegmentation/tree/main/final%20model/saved_models/trainVanilla), the 
