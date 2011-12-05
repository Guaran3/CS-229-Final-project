% IVM toolbox
% Version 0.4		Saturday 13 Jan 2007 at 01:05
% Copyright (c) 2007 Neil D. Lawrence
% 
% DEMCLASSIFICATION1 Test IVM code on a toy feature selection.
% DEMCLASSIFICATION2 IVM for classification on a data-set sampled from a GP
% DEMCLASSIFICATION3 IVM for classification on a data-set sampled from a GP with null category.
% DEMEP1 Demonstrate Expectation propagation on a toy data set..
% DEMORDERED1 Run a demonstration of the ordered categories noise model (linear data).
% DEMORDERED2 Run a demonstration of the ordered categories noise model (circular data).
% DEMREGRESSION1 The data-set is sampled from a GP with known parameters.
% DEMREGRESSION2 The data-set is sampled from a GP with known parameters.
% DEMTHREEFIVE Try the IVM & NCNM on 3 vs 5.
% DEMTHREEFIVERESULTS Plot results from the three vs five experiments.
% DEMUNLABELLED1 Test IVM code on a toy crescent data.
% DEMUNLABELLED2 Test IVM code on a toy crescent data.
% DEMUSPS1 Try the IVM on the USPS digits data with RBF kernel.
% DEMUSPS2 Try the IVM on the USPS digits data with MLP kernel.
% DEMUSPS3 Try the ARD IVM on some digits data.
% IVM Initialise an IVM model.
% IVM3DPLOT Make a 3-D or contour plot of the IVM.
% IVMADDPOINT Add a point into the IVM representation.
% IVMAPPROXGRADX Returns the gradient of the approxmate log-likelihood wrt x.
% IVMAPPROXLOGLIKEKERNGRAD Gradient of the approximate likelihood wrt kernel parameters.
% IVMAPPROXLOGLIKELIHOOD Return the approximate log-likelihood for the IVM.
% IVMCOMPUTEINFOCHANGE Compute the information change associated with each point.
% IVMCOMPUTELANDM Compute the L and M matrix.
% IVMCONTOUR Special contour plot showing decision boundary.
% IVMCOVARIANCEGRADIENT The gradient of the likelihood approximation wrt the covariance.
% IVMCREATE Create a IVM model with the IVM sparse approximaiton.
% IVMDECONSTRUCT break IVM in pieces for saving.
% IVMDISPLAY Display parameters of an IVM model.
% IVMDOWNDATEM Remove point from M, L, mu and varSigma.
% IVMDOWNDATENUG Downdate nu and g parameters associated with noise model.
% IVMDOWNDATESITES Downdate site parameters.
% IVMEPLOGLIKELIHOOD Return the EP approximation to the log-likelihood.
% IVMEPUPDATEM Update matrix M, L, varSigma and mu for EP.
% IVMEPUPDATEPOINT Do an EP update of a point.
% IVMGRADX Returns the gradient of the log-likelihood wrt x.
% IVMGUNNARDATA Script for running experiments on Gunnar data.
% IVMINIT Initialise the IVM model.
% IVMKERNELGRADIENT Gradient of likelihood approximation wrt kernel parameters.
% IVMKERNELOBJECTIVE Compute the negative of the IVM log likelihood approximation.
% IVMLOGLIKELIHOOD Return the log-likelihood for the IVM.
% IVMMESHVALS Give the output of the IVM for contour plot display.
% IVMNEGGRADIENTNOISE Wrapper function for calling noise param gradients.
% IVMNEGLOGLIKELIHOOD Wrapper function for calling IVM likelihood.
% IVMOPTIMISE Optimise the IVM.
% IVMOPTIMISEIVM Selects the points for an IVM model.
% IVMOPTIMISEKERNEL Optimise the kernel parameters.
% IVMOPTIMISENOISE Optimise the noise parameters.
% IVMOPTIONS Return default options for IVM model.
% IVMOUT Evaluate the output of an IVM model.
% IVMPOSTERIORGRADMEANVAR Gradient of mean and variances of the posterior wrt X.
% IVMPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
% IVMPRINTPLOT Make a 3-D or contour plot of the IVM.
% IVMREADFROMFID Load from a FID produced by the C++ implementation.
% IVMREADFROMFILE Load a file produced by the C++ implementation.
% IVMRECONSTRUCT Reconstruct an IVM form component parts.
% IVMREMOVEPOINT Removes a given point from the IVM.
% IVMRUN Run the IVM on a given data set.
% IVMSELECTPOINT Choose a point for inclusion or removal.
% IVMSELECTPOINTS Selects the point for an IVM.
% IVMSELECTVISUALISE Visualise the selected point.
% IVMTOOLBOXES Load in the toolboxes for the IVM.
% IVMUPDATEM Update matrix M, L, v and mu.
% IVMUPDATENUG Update nu and g parameters associated with noise model.
% IVMUPDATESITES Update site parameters.
% IVMUSPSRESULTS Summarise the USPS result files in LaTeX.
% IVMVIRTUAL Create virtual data points with the specified invariance.
% NCNMCONTOUR Special contour plot showing null category region.
% VIVMRUNDATASET Try the virtual IVM on a data set and save the results.
% VIVMRUNDATASETLEARN Try the virtual IVM on a data set and save the results.
% VIVMUSPSRESULTS Summarise the USPS result files in LaTeX.
