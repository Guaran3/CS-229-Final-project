% GPLVM toolbox
% Version 2.11		17-Apr-2009
% Copyright (c) 2009, Neil D. Lawrence
% 
, Neil D. Lawrence
% GPLVMKERNELGRADIENT Gradient of likelihood approximation wrt kernel parameters.
% POINTNEGGRADX Wrapper function for calling noise gradients.
% GPLVMISOMAPINIT Initialise gplvm model with isomap (need isomap toolbox).
% DEMRATEMAPS2RECONSTRUCT
% GPLVMVISUALISE1D Visualise the fantasies along a line (as a movie).
% GPLVMPPCAINIT Initialise gplvm model with probabilistic PCA.
% DEMDIGITSGTM For visualising digits data --- uses NETLAB toolbox.
% DEMTWOSTEST Present test data to the twos models with some missing pixels.
% GPLVMKERNELOBJECTIVE Likelihood approximation.
% GPLVMSTATICIMAGEVISUALISE Generate a scatter plot of the images without overlap.
% GPLVMGRADIENTPOINT Compute gradient of data-point likelihood wrt x.
% GPLVMLATENTCLASSIFY Load a results file and classify using the latent space.
% DEMBRENDAN1 Model the face data with a 2-D RBF GPLVM.
% GPLVMRESULTSCPP Load a results file and visualise them.
% GPLVMINIT Initialise a GPLVM model.
% DEMLINEARORDINAL1 Model the twos data with a 2-D RBF GPLVM with binomial noise.
% GPLVMACTIVESETNEGLOGLIKELIHOOD Wrapper function for calling noise likelihoods.
% DEMSWISSROLL1 Model the face data with a 2-D GPLVM.
% GPLVMREADFROMFID Load from a FID produced by the C++ implementation.
% DEMRATEMAPS2PROJECT
% DEMDIGITS2 Model the digits data with a 1-D RBF GPLVM.
% DEMSWISSROLL2 Model the face data with a 2-D GPLVM initialised with isomap.
% GPLVMINITX Initialise the X values.
% GPLVMRESULTSDYNAMIC Load a results file and visualise them.
% DEMOIL4 Model the oil data with a 2-D GPLVM using RBF kernel and normal uniform latent prior.
% GPLVMRESULTSFANTASY Load a results file and visualise the `fantasies'.
% DEMBRENDAN3 Model the face data with a 2-D GPLVM.
% DEMDIGITS1 Model the digits data with a 2-D RBF GPLVM.
% GPLVMFIT Fit a Gaussian process latent variable model.
% GPLVMOPTIONS Initialise an options stucture.
% SWISSROLL3DPLOT 2-D scatter plot of the latent points with color - for Swiss Roll data.
% GPLVMSCATTERPLOTCOLOR 2-D scatter plot of the latent points with color - for Swiss Roll data.
% VECTOR3MODIFY Helper code for visualisation of 3-D vectorial data.
% GPLVMLOADRESULT Load a previously saved result.
% GPLVMTOOLBOXES Load in relevant toolboxes for GPLVM.
% POINTAPPROXNEGGRADX Wrapper function for calling approximate noise gradients.
% DEMTWOSGTM For visualising oil data --- uses NETLAB toolbox.
% GPLVMAPPROXLOGLIKEACTIVESETGRAD Gradient of the approximate likelihood wrt active set.
% GPLVMPCAINIT Initialise gplvm model with PCA.
% GPLVMOPTIMISEPOINT Optimise the postion of a non-active point.
% DEMDIGITS3 Model the digits data with a 2-D MLP GPLVM.
% DEMOILPCA Model the oil data with PCA.
% DEMBRENDAN2 Model the face data with a 1-D RBF GPLVM.
% INVGETNORMAXESPOINT Take a point on a plot and return a point within the figure.
% DEMOIL1 Model the oil data with a 2-D GPLVM using RBF kernel.
% DEMRATEMAPS1PROJECT
% GPLVMVISUALISE Visualise the manifold.
% DEMOIL3 Model the oil data with a 2-D GPLVM using RBF kernel and Laplacian latent prior.
% GPLVMOPTIMISEKERNEL Jointly optimise the kernel parameters and active set positions.
% DEMHORSECLASSIFYPLOT Load results form horse classify experiments and plot them.
% GPLVMKPCAINIT Initialise gplvm model with Kernel PCA.
% GPLVMACTIVESETOBJECTIVE Wrapper function for calling noise likelihoods.
% GPLVMVERS Brings dependent toolboxes into the path.
% POINTNEGLOGLIKELIHOOD Wrapper function for calling noise likelihoods.
% DEMTWOS1 Model the twos data with a 2-D RBF GPLVM with Gaussian noise.
% GPLVMDECONSTRUCT break GPLVM in pieces for saving.
% GPLVMRESULTSSTATIC Load a results file and visualise them dynamically.
% GPLVMSPPCAINIT Initialise gplvm model with Scaled Probabilistic PCA.
% POINTAPPROXNEGLOGLIKELIHOOD Wrapper function for calling likelihoods.
% VECTOR3VISUALISE  Helper code for plotting a 3-D vector during 2-D visualisation.
% DEMTWOS2 Model the twos data with a 2-D RBF GPLVM with binomial noise.
% DEMOIL5 Model the oil data with probabilistic PCA.
% GPLVMACTIVESETGRADIENT Wrapper function for calling gradient for active set positions.
% GPLVMFANTASYPLOT Block plot of fantasy data.
% GPLVMPATH Brings dependent toolboxes into the path.
% GPLVMOPTIMISEACTIVESET Optimise the location of the active points.
% DEMOILGTM For visualising oil data --- uses NETLAB toolbox.
% DEMDIGITSPCA Model the digits data with PCA.
% GPLVMREADFROMFILE Load a file produced by the c++ implementation.
% GPLVMOPTIMISE Optimise the parameters and points of a GPLVM model.
% DEMOIL2 Model the oil data with a 2-D GPLVM using MLP kernel.
