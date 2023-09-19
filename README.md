# PLAn-7T

PLAn-7T is an MR image segmentation method optimized for processing ultra-high field (7T) images. It is built upon the nnU-Net framework and uses transfer learning to enable effective training with a relatively small (<10) number of annotated examples.

This repository is a companion to the PLAn 7T paper:
```
Donnay, C.*, Dieckhaus, H.*,* Tsagkas, H., Gaitán, M.I., Beck, E.S., Mullins, W., Reich, D.S., Nair, G.
Pseudo-Label Assisted nnU-Net (PLAn) Enables Automatic Segmentation of 7T MRI From a Single Acquisition.
Under review, 2023.
```

## Installation

These details are also found in ```install_PLAn7T.txt```.

To install PLAn 7T for training or inference, you first need to install the necessary python packages:

```
conda create --name PLAn_7T python=3.8 cudatoolkit=11.3 pytorch torchvision torchaudio -c pytorch
```

You next need to install the base nnU-Net package. NOTE: PLAn 7T uses [nnU-Net v1]([url](https://github.com/MIC-DKFZ/nnUNet/tree/nnunetv1)), so please be sure to install the correct version.
```
conda activate PLAn_7T

git clone https://github.com/MIC-DKFZ/nnUNet.git

cd nnUNet
git checkout nnunetv1
pip install -e .
```

Set your nnU-Net environment variables as directed [here](https://github.com/MIC-DKFZ/nnUNet/blob/nnunetv1/documentation/setting_up_paths.md).

Obtain the PLAn files from this repository:
```
git clone https://github.com/hdieckhaus/PLAn-7T.git
```

Finally, add the custom Trainer file **nnUNetTrainerV2Transfer_125epochs_0p0001.py** into the **nnunet/training/network_training** folder 

## Inference

See the ```PLAn7T_inference.sh``` script. Accepted input formats are .nii or .nii.gz files.

## Training

See the ```PLAn7T_training.sh``` script. Accepted input formats are .nii or .nii.gz files.
