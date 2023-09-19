#!/bin/bash

# initialize conda environment (not sure how you do this for someone else's environment)
# location of environments: /all_data/7_henry/processed/.conda/envs
conda activate modify_nnUNet

# set important environment variables
export RESULTS_FOLDER="/all_data/7_henry/processed/nnUNet/nnUNet_trained_models"
export nnUNet_preprocessed="/all_data/7_henry/processed/nnUNet/nnUNet_preprocessed"
export nnUNet_raw_data_base="/all_data/7_henry/processed/nnUNet/nnUNet_raw_data_base"
export nnUNet_n_proc_DA=20

# preprocess pseudolabels
nnUNet_plan_and_preprocess -t 523 --verify_dataset_integrity

# train on pseudolabels (if not training, just debugging, use nnUNetTrainerV2_5epochs)
nnUNet_train 3d_fullres nnUNetTrainerV2 523 0

# preprocess 7T labels (overwrite preprocessing settings)
nnUNet_plan_and_preprocess -t 601 --verify_dataset_integrity -overwrite_plans /all_data/7_henry/processed/nnUNet/nnU
Net_preprocessed/Task523_3TSeg_t1map_inv1_inv2/nnUNetPlansv2.1_plans_3D.pkl -overwrite_plans_identifier 3Tto7T_
TRANSFER -pl3d ExperimentPlanner3D_v21_Pretrained

# fine-tune on 7T labels (load pre-trained model and use custom trainer)
nnUNet_train 3d_fullres nnUNetTrainerV2Transfer_125epochs_0p0001 Task601_7TSeg_transfer_5foldCV 0 -pretra
ined_weights /all_data/7_henry/processed/nnUNet/nnUNet_trained_models/nnUNet/3d_fullres/Task523_3TSeg_t1map_inv1_in
v2/nnUNetTrainerV2__nnUNetPlansv2.1/fold_0/model_best.model -p nnUNetPlans_pretrained_3Tto7T_TRANSFER

# Notes:
# Task 523 is the pseudo-label training task, which we preprocess and train just like any normal nnU-Net run

# Task 601 is the 7T fine-tuning task, which requires some modifications to do what we want

# Preprocessing is where hyperparameters are set up, but we NEED these to be consistent b/w the two runs, so we overwrite the "plans" which define these parameters
# -overwrite_plans defines which plans we want to use instead, which are from Task 523
# -overwrite_plans_identifier defines a custom name to use for this run
# -pl3d does something I can't remember

# Training has a few modifications as well
# -pretrained_weights defines the model whose weights we want to use as our starting point, which is from Task523
# -p references the custom -overwrite_plans_identifier from preprocessing to tell it where to save the data
# nnUNetTrainerV2Transfer_125epochs_0p0001 is a custom Trainer that we defined in the modify_nnUNet code to run fine-tuning

# location of custom trainers: /all_data/7_henry/processed/scripts/nnUNet/nnunet/training/network_training

