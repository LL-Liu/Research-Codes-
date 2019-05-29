# Research-Codes-
The codes are for the research of the improvement of the accuracy of a canopy height model

Paper title: A multiscale morphological algorithm for improvements to canopy height models

Authors: Li Liu, Samsung Lim, Xuesong Shen, and Marta Yebra

Codes description: The codes contain 4 parts, namely, the multiscale Laplacian operation, the multiscale morphological closing operation, the multiscale median filtering operation, and replacing the identified pits with correct values. The parameters set in each part should be carefully chosen since they are related to the characteristics of the study region, such as forest type, the height of the first branch. For instance, in the paper, we assume that the canopy of a tree from the top view forms a circle. Therefore the proposed algorithm can be effectively applied to different species and sizes whenever this assumption is applicable, but cannot be applied if tree canopies are not circular from the top view. If the study region is dominated by spindle-shaped trees whose canopies are oval from the top view, the multiscale morphological closing operation with a circular kernel cannot be used to identify the canopies and the multiscale morphological closing operation with a kernel of oval should be used instead. 
