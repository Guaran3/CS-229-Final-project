GPLVM software
Version 2.11		Friday 17 Apr 2009 at 17:47

As of July 2005 a C++ implementation of the GPLVM exists which has most of the flexibility of this software but runs much faster. However as of this time it cannot handle very large data sets as the sparsification algorithm (i.e. the IVM) is not implemented.

Expected code updates in the near future: different kernels associated with each dimension of the IVM code (update to take place in IVM toolbox). 

A note on speed issues:

This toolbox is designed to be flexible, not fast. Large improvements in running speed can be obtained by removing that flexibility (e.g. by fixing the kernel type and the noise model etc.).

Version 2.1 Release Notes
-------------------------

As part of releasing the new FGPLVM toolbox, which uses a different sparsification approach for dealing with large data sets, large portions of the original GPLVM code were moved into two new toolboxes: the datasets toolbox and the mltools toolbox. These toolboxes are now required for running the GPLVM toolbox.

Version 2.012 Release Notes
---------------------------

This is a minor update to add compatibility to the C++ code version of the GPLVM. The command gplvmReadFromFile allows results from the C++ code to be read in and visualised (via gplvmResultsCpp).


Version 2.011 Release Notes
---------------------------

Last release was missing file gplvmInitX.m and there was a bug in the gplvmDynamicResults function, dataset in the function command should be dataSet. Thanks to Guodong Liu for pointing these out. 


Version 2.01 Release Notes
--------------------------

Version 2.01 is a minor update of the code which brings it into line with the released version of the technical report, see http://ext.dcs.shef.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04.


Version 2.0 Release Notes
-------------------------

Version 2.0 was a major update of the GPLVM code. It is now based on the IVM code available at http://www.dcs.shef.ac.uk/~neil/ivm/downloadFiles. You will need to download this software package and its dependencies to get things running.

This code is associated with a technical report, expected to be finished August 04, see http://ext.dcs.shef.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04. However another release is expected before that time.

To recreate the experiments in the NIPS paper, you can use software version 1.01.

The demonstration files are prefaced by 'dem', they then contain the data-set name and finally the experiment number. 

The new code is far more flexible because it is based on the IVM software, which is fairly modular. You can easily create your own kernel for use, or make a new noise model. The software also handles missing variables if an appropriate noise model is used ... simply set the missing variable to NaN.



MATLAB Files
------------

Matlab files associated with the toolbox are:

gplvmKernelGradient.m: Gradient of likelihood approximation wrt kernel parameters.
pointNegGradX.m: Wrapper function for calling noise gradients.
gplvmIsomapInit.m: Initialise gplvm model with isomap (need isomap toolbox).
demRatemaps2Reconstruct.m:
gplvmVisualise1D.m: Visualise the fantasies along a line (as a movie).
gplvmPpcaInit.m: Initialise gplvm model with probabilistic PCA.
demDigitsGtm.m: For visualising digits data --- uses NETLAB toolbox.
demTwosTest.m: Present test data to the twos models with some missing pixels.
gplvmKernelObjective.m: Likelihood approximation.
gplvmStaticImageVisualise.m: Generate a scatter plot of the images without overlap.
gplvmGradientPoint.m: Compute gradient of data-point likelihood wrt x.
gplvmLatentClassify.m: Load a results file and classify using the latent space.
demBrendan1.m: Model the face data with a 2-D RBF GPLVM.
gplvmResultsCpp.m: Load a results file and visualise them.
gplvmInit.m: Initialise a GPLVM model.
demLinearOrdinal1.m: Model the twos data with a 2-D RBF GPLVM with binomial noise.
gplvmActiveSetNegLogLikelihood.m: Wrapper function for calling noise likelihoods.
demSwissRoll1.m: Model the face data with a 2-D GPLVM.
gplvmReadFromFID.m: Load from a FID produced by the C++ implementation.
demRatemaps2Project.m:
demDigits2.m: Model the digits data with a 1-D RBF GPLVM.
demSwissRoll2.m: Model the face data with a 2-D GPLVM initialised with isomap.
gplvmInitX.m: Initialise the X values.
gplvmResultsDynamic.m: Load a results file and visualise them.
demOil4.m: Model the oil data with a 2-D GPLVM using RBF kernel and normal uniform latent prior.
gplvmResultsFantasy.m: Load a results file and visualise the `fantasies'.
demBrendan3.m: Model the face data with a 2-D GPLVM.
demDigits1.m: Model the digits data with a 2-D RBF GPLVM.
gplvmFit.m: Fit a Gaussian process latent variable model.
gplvmOptions.m: Initialise an options stucture.
swissRoll3Dplot.m: 2-D scatter plot of the latent points with color - for Swiss Roll data.
gplvmScatterPlotColor.m: 2-D scatter plot of the latent points with color - for Swiss Roll data.
vector3Modify.m: Helper code for visualisation of 3-D vectorial data.
gplvmLoadResult.m: Load a previously saved result.
gplvmToolboxes.m: Load in relevant toolboxes for GPLVM.
pointApproxNegGradX.m: Wrapper function for calling approximate noise gradients.
demTwosGtm.m: For visualising oil data --- uses NETLAB toolbox.
gplvmApproxLogLikeActiveSetGrad.m: Gradient of the approximate likelihood wrt active set.
gplvmPcaInit.m: Initialise gplvm model with PCA.
gplvmOptimisePoint.m: Optimise the postion of a non-active point.
demDigits3.m: Model the digits data with a 2-D MLP GPLVM.
demOilPca.m: Model the oil data with PCA.
demBrendan2.m: Model the face data with a 1-D RBF GPLVM.
invGetNormAxesPoint.m: Take a point on a plot and return a point within the figure.
demOil1.m: Model the oil data with a 2-D GPLVM using RBF kernel.
demRatemaps1Project.m:
gplvmVisualise.m: Visualise the manifold.
demOil3.m: Model the oil data with a 2-D GPLVM using RBF kernel and Laplacian latent prior.
gplvmOptimiseKernel.m: Jointly optimise the kernel parameters and active set positions.
demHorseClassifyPlot.m: Load results form horse classify experiments and plot them.
gplvmKpcaInit.m: Initialise gplvm model with Kernel PCA.
gplvmActiveSetObjective.m: Wrapper function for calling noise likelihoods.
gplvmVers.m: Brings dependent toolboxes into the path.
pointNegLogLikelihood.m: Wrapper function for calling noise likelihoods.
demTwos1.m: Model the twos data with a 2-D RBF GPLVM with Gaussian noise.
gplvmDeconstruct.m: break GPLVM in pieces for saving.
gplvmResultsStatic.m: Load a results file and visualise them dynamically.
gplvmSppcaInit.m: Initialise gplvm model with Scaled Probabilistic PCA.
pointApproxNegLogLikelihood.m: Wrapper function for calling likelihoods.
vector3Visualise.m:  Helper code for plotting a 3-D vector during 2-D visualisation.
demTwos2.m: Model the twos data with a 2-D RBF GPLVM with binomial noise.
demOil5.m: Model the oil data with probabilistic PCA.
gplvmActiveSetGradient.m: Wrapper function for calling gradient for active set positions.
gplvmFantasyPlot.m: Block plot of fantasy data.
gplvmPath.m: Brings dependent toolboxes into the path.
gplvmOptimiseActiveSet.m: Optimise the location of the active points.
demOilGtm.m: For visualising oil data --- uses NETLAB toolbox.
demDigitsPca.m: Model the digits data with PCA.
gplvmReadFromFile.m: Load a file produced by the c++ implementation.
gplvmOptimise.m: Optimise the parameters and points of a GPLVM model.
demOil2.m: Model the oil data with a 2-D GPLVM using MLP kernel.
