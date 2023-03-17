# Version 1.3
OS-SIFT is a coregistration algorithm designed for optical-to-SAR image registration. We hope this code will be helpful and we remain to your disposal and we are interested in getting back your remarks. 

We have improved the OS-SIFT method by adding parallel processing in descriptor construction stage and combining FSC with geometric constraints.

The improved OS-SIFT is faster than the original OS-SIFT and it can obtain more correspondences. However, it does not support multi-region by now.

# Usage
The source code is provided here in matlab.

For different datasets, the Harris function thresholds d_SH_1 & d_SH_2 must be adjusted to produce comparable keypoint detection results for SAR and optical images.

For images with extremely large rotation differences, we suggest to use imrotate and flipr(flipud) function in Matlab for pre-processing.

For images with no rotation differences, the main angle of each keypoint can be set to 0.

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
