IVM software
Version 0.4		Saturday 13 Jan 2007 at 01:05
Copyright (c) 2007 Neil D. Lawrence

Changes in vs 0.4
-----------------

The toolbox has been brought into line with other toolboxes on the site. Now the ivm model is created using ivmCreate, and all the model options are set in ivmOptions. The files are now better descrived. The null category noise model examples are now integrated with the IVM (the main ncnm code is in the NOISE toolbox).

Changes in vs 0.33
------------------

The code now relies upon the datasets toolbox for loading of datasets used. The EP updates have now been fixed so that the site parameters can be refined.


Changes in vs 0.32
------------------

This code no longer works under MATLAB 6.1, it requires MATLAB 7.0 or higher to run.
 
This version of the software now relies on the following toolboxes:

KERN vs 0.14
------------

This toolbox implements the different kernels. IVM interacts with this toolbox through an interface which involves files starting with kern.

NOISE vs 0.12
-------------

This toolbox implements the different noise models. IVM interacts with this toolbox through an interface which involves files starting with noise.

NDLUTIL vs 0.12
---------------

This toolbox implements some generic functions which could be used beyond the ivm toolbox, for example sigmoid.m, cumGaussian.m

OPTIMI vs 0.12
--------------

This toolbox implements functions which allow non-linear transformations between parameters to be optimised. For example it allows variances to be optimised in log space.

PRIOR vs 0.12
-------------

This toolbox allows priors to be placed over parameters, at the moment this is used so that MAP solutions can be found for the parameters rather than type-II maximum likelihood. The priors were written for the Null Category Noise Model (see NCNM toolbox) so that an exponential prior could be placed over the process variances. The rest of its funcitonality has not been tested.

ROCHOL vs 0.12
--------------

This toolbox implements the rank one Cholesky updates. These are need when points are removed or EP updates are applied to selected points.

Changes in vs 0.31
------------------

The options are now held in a structure whose values are set in ivmOptions.m
There were some missing files in the last release, these have now been added.

The EP updates are currently unstable numerically and should be used with caution.

Demos
-----

Six toy demos are provided: demClassification1, demClassification2, demRegression1, demRegression2, demOrdered1 and demOrdered2. Each runs a different noise model with. They display their results as they run and therefore they don't use the ivmRun function which is the normal recommended way for running code.

Three large scale experiments are provided on the USPS data-set, demUsps1-3. The use three different types of kernel.

General comments
----------------

Since version 0.22 the code is far more modular, this was done in an effort to improve its readability and reduce the need for re-writes. However it may be slower than the previous version as a result. 

Yet to be implemented functionality still includes:

Multi-class noise models (which will probably be done mostly in the NOISE toolbox) and randomised greed selection.


MATLAB Files
------------

Matlab files associated with the toolbox are:

demClassification1.m: Test IVM code on a toy feature selection.
demClassification2.m: IVM for classification on a data-set sampled from a GP
demClassification3.m: IVM for classification on a data-set sampled from a GP with null category.
demEP1.m: Demonstrate Expectation propagation on a toy data set..
demOrdered1.m: Run a demonstration of the ordered categories noise model (linear data).
demOrdered2.m: Run a demonstration of the ordered categories noise model (circular data).
demRegression1.m: The data-set is sampled from a GP with known parameters.
demRegression2.m: The data-set is sampled from a GP with known parameters.
demThreeFive.m: Try the IVM & NCNM on 3 vs 5.
demThreeFiveResults.m: Plot results from the three vs five experiments.
demUnlabelled1.m: Test IVM code on a toy crescent data.
demUnlabelled2.m: Test IVM code on a toy crescent data.
demUsps1.m: Try the IVM on the USPS digits data with RBF kernel.
demUsps2.m: Try the IVM on the USPS digits data with MLP kernel.
demUsps3.m: Try the ARD IVM on some digits data.
ivm.m: Initialise an IVM model.
ivm3dPlot.m: Make a 3-D or contour plot of the IVM.
ivmAddPoint.m: Add a point into the IVM representation.
ivmApproxGradX.m: Returns the gradient of the approxmate log-likelihood wrt x.
ivmApproxLogLikeKernGrad.m: Gradient of the approximate likelihood wrt kernel parameters.
ivmApproxLogLikelihood.m: Return the approximate log-likelihood for the IVM.
ivmComputeInfoChange.m: Compute the information change associated with each point.
ivmComputeLandM.m: Compute the L and M matrix.
ivmContour.m: Special contour plot showing decision boundary.
ivmCovarianceGradient.m: The gradient of the likelihood approximation wrt the covariance.
ivmCreate.m: Create a IVM model with the IVM sparse approximaiton.
ivmDeconstruct.m: break IVM in pieces for saving.
ivmDisplay.m: Display parameters of an IVM model.
ivmDowndateM.m: Remove point from M, L, mu and varSigma.
ivmDowndateNuG.m: Downdate nu and g parameters associated with noise model.
ivmDowndateSites.m: Downdate site parameters.
ivmEpLogLikelihood.m: Return the EP approximation to the log-likelihood.
ivmEpUpdateM.m: Update matrix M, L, varSigma and mu for EP.
ivmEpUpdatePoint.m: Do an EP update of a point.
ivmGradX.m: Returns the gradient of the log-likelihood wrt x.
ivmGunnarData.m: Script for running experiments on Gunnar data.
ivmInit.m: Initialise the IVM model.
ivmKernelGradient.m: Gradient of likelihood approximation wrt kernel parameters.
ivmKernelObjective.m: Compute the negative of the IVM log likelihood approximation.
ivmLogLikelihood.m: Return the log-likelihood for the IVM.
ivmMeshVals.m: Give the output of the IVM for contour plot display.
ivmNegGradientNoise.m: Wrapper function for calling noise param gradients.
ivmNegLogLikelihood.m: Wrapper function for calling IVM likelihood.
ivmOptimise.m: Optimise the IVM.
ivmOptimiseIVM.m: Selects the points for an IVM model.
ivmOptimiseKernel.m: Optimise the kernel parameters.
ivmOptimiseNoise.m: Optimise the noise parameters.
ivmOptions.m: Return default options for IVM model.
ivmOut.m: Evaluate the output of an IVM model.
ivmPosteriorGradMeanVar.m: Gradient of mean and variances of the posterior wrt X.
ivmPosteriorMeanVar.m: Mean and variances of the posterior at points given by X.
ivmPrintPlot.m: Make a 3-D or contour plot of the IVM.
ivmReadFromFID.m: Load from a FID produced by the C++ implementation.
ivmReadFromFile.m: Load a file produced by the C++ implementation.
ivmReconstruct.m: Reconstruct an IVM form component parts.
ivmRemovePoint.m: Removes a given point from the IVM.
ivmRun.m: Run the IVM on a given data set.
ivmSelectPoint.m: Choose a point for inclusion or removal.
ivmSelectPoints.m: Selects the point for an IVM.
ivmSelectVisualise.m: Visualise the selected point.
ivmToolboxes.m: Load in the toolboxes for the IVM.
ivmUpdateM.m: Update matrix M, L, v and mu.
ivmUpdateNuG.m: Update nu and g parameters associated with noise model.
ivmUpdateSites.m: Update site parameters.
ivmUspsResults.m: Summarise the USPS result files in LaTeX.
ivmVirtual.m: Create virtual data points with the specified invariance.
ncnmContour.m: Special contour plot showing null category region.
vivmRunDataSet.m: Try the virtual IVM on a data set and save the results.
vivmRunDataSetLearn.m: Try the virtual IVM on a data set and save the results.
vivmUspsResults.m: Summarise the USPS result files in LaTeX.
