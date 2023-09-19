from nnunet.training.network_training.nnUNetTrainerV2 import nnUNetTrainerV2


class nnUNetTrainerV2Transfer_125epochs_0p0001(nnUNetTrainerV2):
    """
    Custom trainer class, inherits from default nnU-Net trainer class
    """

    def __init__(self, plans_file, fold, output_folder=None, dataset_directory=None, batch_dice=True, stage=None,
                 unpack_data=True, deterministic=True, fp16=False):
        super().__init__(plans_file, fold, output_folder, dataset_directory, batch_dice, stage, unpack_data,
                         deterministic, fp16)
        self.max_num_epochs = 125  # reduce epochs (default=1000)
        self.initial_lr = 1e-4  # reduce learning rate(default=1e-2)
