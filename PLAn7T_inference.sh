#!/bin/bash

# initialize conda environment
conda activate PLAn_7T

# set important environment variables
export RESULTS_FOLDER="/all_data/7_henry/processed/nnUNet/nnUNet_trained_models"
export nnUNet_preprocessed="/all_data/7_henry/processed/nnUNet/nnUNet_preprocessed"
export nnUNet_raw_data_base="/all_data/7_henry/processed/nnUNet/nnUNet_raw_data_base"

# specify input folder of .nii or .nii.gz files
INPUT="/all_data/7_henry/processed/nnUNet/inference_Task601/fold_0/"
# specify output folder for segmentation results
OUTPUT="/all_data/7_henry/processed/nnUNet/inference_Task601/fold_0/"

nnUNet_predict -i "$INPUT" -o "$OUTPUT" -t 601 -tr nnUNetTrainerV2Transfer_125epochs_0p0001 -p nnUNetPlans_pretrained_3Tto7T_TRANSFER -m 3d_fullres -f 0

# Notes:
# -i and -o set input and output folders (like usual)
# -t and -m set the task ID and model configuration (like usual)

# -tr sets the "Trainer" to use - this is where settings like epochs and learning rate are defined
# since I used a custom Trainer to do the fine-tuning, we have to set this manually

# -p sets the "Plan Identifier" to use - this is where settings like preprocessing are defined
# again, I used a custom planner to do the fine-tuning, so we have to set this manually
