# Version 1.5
OS-SIFT is a coregistration algorithm designed for optical-to-SAR image registration. We hope this code will be helpful and we remain to your disposal and we are interested in getting back your remarks. 

2023/10/27 V1.5: No need to adjust the harris threshold, we now select the strongest 5000 keypoints. Add the source code of CSC_match (CSC2.m).

2023/7/17 V1.4: Support remote sensing images with black blocks (GEC images), by using a Mask to remove keypoints at image boundary. 

We have improved the OS-SIFT method by adding parallel processing in descriptor construction stage and combining FSC with geometric constraints. The improved OS-SIFT is faster than the original OS-SIFT and it can obtain more correspondences. However, it does not support multi-region by now. 

The FSC with geometric constraint algorithm (CSC2) was proposed in this paper (X. Zhang, Y. Wang and H. Liu, "Robust Optical and SAR Image Registration Based on OS-SIFT and Cascaded Sample Consensus," in IEEE Geoscience and Remote Sensing Letters, vol. 19, pp. 1-5, 2022). We just implemented the algorithm and cannot guarantee its correctness.

# Usage
The source code is provided here in matlab.

For images with no rotation differences, the main angle of each keypoint should be set to 0 to avoid inaccurate main orientation.

For images with extremely large rotation differences, we suggest to use imrotate and flipr(flipud) function in Matlab for pre-processing.

# Citation
If you are using OS-SIFT in your project, we kindly ask you to cite:

    @article{xiang2018sift,
      title={OS-SIFT: A robust SIFT-like algorithm for high-resolution optical-to-SAR image registration in suburban areas},
      author={Xiang, Yuming and Wang, Feng and You, Hongjian},
      journal={IEEE Transactions on Geoscience and Remote Sensing},
      volume={56},
      number={6},
      pages={3078--3090},
      year={2018},
      publisher={IEEE}
    }
