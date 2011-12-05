MLTOOLS software
Version 0.136		Wednesday 27 Oct 2010 at 00:13

This toolbox provides various machine learning tools, either through wrapping other toolboxes (such as NETLAB) or providing the tool directly. It was designed originally as part of splitting the GPLVM and FGPLVM toolboxes.

Version 0.136
-------------

Minor Mods.

Version 0.135
-------------

Minor mods.


Version 0.134
-------------

Added pmvu model.

Version 0.133
-------------

Added functionality for writing model files using modelDeconstruct commands to keep written files smaller.

Version 0.132
-------------

Add click visualise functionality for LVM visualization, Laplacian eigenmaps and wrapper for MVU. 

Version 0.1311
--------------

Minor change to lvmScatterPlot to fix bug caused when minimum values were positive.

Version 0.131
-------------

Minor changes to toolbox to fix reading in of files written by C++ code.

Version 0.13
------------

Added paramNameRegularExpressionLookup.m to regular expression match a parameter name in a model and return the associated indices. paramNameReverseLookup.m does the same thing but for the specific parameter name. Also added multimodel type, which allows for multi-task style learning of existing models. Added linear mapping type of model. 

Version 0.1291
--------------

Changes to modelOutputGrad.m, modelOut.m, kbrOutputGrad.m, kbrExpandParam.m, modelOptimise.m to allow compatibility with SGPLVM and NCCA toolboxes. Added a preliminary coding of LLE.


Version 0.129
-------------

Added dnet type model for GTM and density networks. Added various lvm helper files for doing nearest neighbour and plotting results for latent variable models. Added lmvu and mvu embedding wrapper. Added ppca model type. Added output gradients for model out functions (for magnification factor computation in dnet models). Added helpers for reading various models from FID mapmodel, matrix etc.).
Added rbfOutputGradX and visualisation for spring dampers type.

Version 0.128
-------------

Fixed Viterbi alignment algorithm, thanks to Raquel Urtasun for pointing out the problems with it.

Carl Henrik Ek added embeddings with maximum variance unfolding (landmark and normal) to the toolbox. Also several files modified by Carl to allow a single output dimension of a model to be manipulated.

Version 0.127
-------------

Minor modifications including adding file modelAddDynamics to replace fgplvmAddDynamics.

Version 0.126
-------------

Modified kbrParamInit to scale alpha weights and biases by number of data. Added 'dynamicsSliderChange' to lvmClassVisualise to allow visulisation of models with 'gpTime' style-dynamics.

Version 0.125
-------------

Added multimodel for learning multiple indepedent models with shared parameters.

Version 0.124
-------------

Added model gradient checker and added rbfperiodic function to provide a length scale for the gibbsperiodic kernel.

Version 0.123
-------------

Minor release in line with IVM toolbox 0.4.

Version 0.122
-------------

Added Hessian code for base model type and for MLP. Added Viterbi alignment code, viterbiAlign.

Version 0.121
-------------

Various minor bug fixes and changes which seem to have gone undocumented.

Version 0.12
------------

Extended model type to be a generic container module for optimising any model. Added model test for testing a created model. The code is still in a bit of flux though with some design decisions not made and some code untested.

Version 0.111
-------------

Fixed bug in kbr where bias parameter fields where still being referred to as b.Also acknowledged the fact that the isomap graph may not be fully connected in isomapEmbed, but don't yet deal with it properly. Finally added lleEmbed.m for wrapping the lle code.


Version 0.11
------------

Updated release for operation with FGPLVM toolbox 0.13. Structure of model creation changed and functions of the form modelOptions.m included for setting default options of the various machine learning models.

Version 0.1
-----------

The first release of the toolbox with various wrappers for NETLAB functions. Also latent variable model visualisation code was moved into this toolbox.


MATLAB Files
------------

Matlab files associated with the toolbox are:

viterbiAlign.m: Compute the Viterbi alignment.
isomapDeconstruct.m: break isomap in pieces for saving.
lleCreate.m: Locally linear embedding model.
lvmNearestNeighbour.m: Give the number of errors in latent space for 1 nearest neighbour.
isomapReconstruct.m: Reconstruct an isomap form component parts.
linearDisplay.m: Display a linear model.
mlpLogLikelihood.m: Multi-layer perceptron log likelihood.
rbfperiodicOutputGrad.m: Evaluate derivatives of RBFPERIODIC model outputs with respect to parameters.
vectorVisualise.m:  Helper code for plotting a vector during 2-D visualisation.
modelCreate.m: Create a model of the specified type.
dnetOptimise.m: Optimise an DNET model.
lvmClassClickVisualise.m: Callback function for visualising data in 2-D with clicks.
rbfperiodicLogLikeGradients.m: Gradient of RBFPERIODIC model log likelihood with respect to parameters.
dnetUpdateBeta.m: Do an M-step (update parameters) on an Density Network model.
dnetGradient.m: Density Network gradient wrapper.
mogCreate.m: Create a mixtures of Gaussians model.
vectorModify.m: Helper code for visualisation of vectorial data.
modelLogLikeGradients.m: Compute a model's gradients wrt log likelihood.
imageModify.m: Helper code for visualisation of image data.
modelExtractParam.m: Extract the parameters of a model.
lvmLoadResult.m: Load a previously saved result.
dnetPosteriorMeanVar.m: Mean and variances of the posterior at points given by X.
modelHessian.m: Hessian of error function to minimise for given model.
multimodelParamInit.m: MULTIMODEL model parameter initialisation.
lvmVisualise.m: Visualise the manifold.
rbfOut.m: Output of an RBF model.
lvmThreeDPlot.m: Helper function for plotting the labels in 3-D.
multimodelDisplay.m: Display parameters of the MULTIMODEL model.
mvuCreate.m: Maximum variance unfolding embedding model.
rbfOptions.m: Default options for RBF network.
mogMeanCov.m: Project a mixture of Gaussians to a low dimensional space.
mlpOptions.m: Options for the multi-layered perceptron.
ppcaOut.m: Output of an PPCA model.
linearCreate.m: Create a linear model.
lfmClassVisualise.m: Callback function to visualize LFM in 2D
spectrumModify.m: Helper code for visualisation of spectrum data.
lleOptimise.m: Optimise an LLE model.
multimodelExtractParam.m: Extract parameters from the MULTIMODEL model structure.
rbfExpandParam.m: Update rbf model with new vector of parameters.
linearParamInit.m: Initialise the parameters of an LINEAR model.
demSwissRollFullLle1.m: Demonstrate LLE on the oil data.
modelReadFromFile.m: Read model from a file FID produced by the C++ implementation.
modelWriteResult.m: Write a model to file.
leCreate.m: Laplacian eigenmap model.
modelGradient.m: Gradient of error function to minimise for given model.
mlpOutputGrad.m: Evaluate derivatives of mlp model outputs with respect to parameters.
ppcaDeconstruct.m: break PPCA in pieces for saving.
mapmodelReadFromFID.m: Load from a FID produced by C++ code.
dnetWriteResult.m: Write a DNET result.
mogPrintPlot.m: Print projection of MOG into two dimensions.
modelOut.m: Give the output of a model for given X.
demOilLle1.m: Demonstrate LLE on the oil data.
mlpOptimise.m: Optimise MLP for given inputs and outputs.
doubleMatrixWriteToFID.m: Writes a double matrix to an FID.
modelTieParam.m: Tie parameters of a model together.
dnetDeconstruct.m: break DNET in pieces for saving.
demOilLle2.m: Demonstrate LLE on the oil data.
modelPointLogLikelihood.m: Compute the log likelihood of a given point.
mogUpdatePrior.m: Update the priors of an MOG model.
matrixReadFromFID.m: Read a matrix from an FID.
modelOutputGradX.m: Compute derivatives with respect to model inputs of model outputs.
modelOptions.m: Returns a default options structure for the given model.
dnetOut.m: Output of an DNET model.
rbfOutputGrad.m: Evaluate derivatives of rbf model outputs with respect to parameters.
lvmResultsClick.m: Load a results file and visualise them with clicks
dnetLoadResult.m: Load a previously saved result.
modelExpandParam.m: Update a model structure with parameters.
rbfperiodicOptions.m: Create a default options structure for the RBFPERIODIC model.
distanceWarp.m: Dynamic Time Warping Algorithm
kbrOutputGrad.m: Evaluate derivatives of KBR model outputs with respect to parameters.
mlpDisplay.m: Display the multi-layer perceptron model.
rbfperiodicExpandParam.m: Create model structure from RBFPERIODIC model's parameters.
dnetOutputGradX.m: Evaluate derivatives of DNET model outputs with respect to inputs.
rbfperiodicExtractParam.m: Extract parameters from the RBFPERIODIC model structure.
linearExtractParam.m: Extract weights from a linear model.
lvmPrintPlot.m: Print latent space for learnt model.
isomapOptimise.m: Optimise an ISOMAP model.
rbfOptimise.m: Optimise RBF for given inputs and outputs.
rbfOutputGradX.m: Evaluate derivatives of a RBF model's output with respect to inputs.
imageVisualise.m: Helper code for showing an image during 2-D visualisation.
rbfperiodicOutputGradX.m: Evaluate derivatives of a RBFPERIODIC model's output with respect to inputs.
mvuDeconstruct.m: break MVU in pieces for saving.
kbrExtractParam.m: Extract parameters from the KBR model structure.
kbrOut.m: Compute the output of a KBR model given the structure and input X.
dnetLowerBound.m: Computes lower bound on log likelihood for an DNET model.
mlpLogLikeGradients.m: Multi-layer perceptron gradients.
modelWriteToFID.m: Write to a stream a given model.
spectralUpdateX.m: Update the latent representation for spectral model.
dnetLogLikeGradients.m: Density network gradients.
mlpExtractParam.m: Extract weights and biases from an MLP.
modelReadFromFID.m: Load from a FID produced by C++ code.
kbrOptions.m: Create a default options structure for the KBR model.
kbrOptimise.m: Optimise a KBR model.
lvmScatterPlotColor.m: 2-D scatter plot of the latent points with color.
modelLoadResult.m: Load a previously saved result.
lfmResultsDynamic.m: Load a results file and visualise them.
linearLogLikeGradients.m: Linear model gradients.
mlpLogLikeHessian.m: Multi-layer perceptron Hessian.
lfmVisualise.m: Visualise the outputs in a latent force model
modelOutputGrad.m: Compute derivatives with respect to params of model outputs.
lvmSetPlot.m: Sets up the plot for visualization of the latent space.
modelGradientCheck.m: Check gradients of given model.
multimodelLogLikelihood.m: Log likelihood of MULTIMODEL model.
leReconstruct.m: Reconstruct an LE form component parts.
isomapOptions.m: Options for a isomap.
lvmScoreModel.m: Score model with a GP log likelihood.
dnetOptions.m: Options for a density network.
dnetUpdateOutputWeights.m: Do an M-step (update parameters) on an Density Network model.
modelPosteriorMeanVar.m: Mean and variances of the posterior at points given by X.
ppcaCreate.m: Density network model.
smallrandEmbed.m: Embed data set with small random values.
lvmScatterPlotNeighbours.m: 2-D scatter plot of the latent points with neighbourhood.
modelObjective.m: Objective function to minimise for given model.
linearExpandParam.m: Update linear model with vector of parameters.
demMppca1.m: Demonstrate MPPCA on a artificial dataset.
multimodelExpandParam.m: Create model structure from MULTIMODEL model's parameters.
mogUpdateCovariance.m: Update the covariances of an MOG model.
kbrExpandParam.m: Create model structure from KBR model's parameters.
dnetExpandParam.m: Update dnet model with new vector of parameters.
leOptimise.m: Optimise an LE model.
demSwissRollFullLle2.m: Demonstrate LLE on the oil data.
kbrDisplay.m: Display parameters of the KBR model.
mlpOutputGradX.m: Evaluate derivatives of mlp model outputs with respect to inputs.
dnetReconstruct.m: Reconstruct an DNET form component parts.
findNeighbours.m: find the k nearest neighbours for each point in Y.
springDampersVisualise.m: Helper code for showing an spring dampers during 2-D visualisation.
linearLogLikelihood.m: Linear model log likelihood.
mvuOptimise.m: Optimise an MVU model.
rbfperiodicLogLikelihood.m: Log likelihood of RBFPERIODIC model.
mltoolsToolboxes.m: Load in the relevant toolboxes for the MLTOOLS.
demSwissRollLle3.m: Demonstrate LLE on the oil data.
mogUpdateMean.m: Update the means of an MOG model.
dnetEstep.m: Do an E-step (update importance weights) on an Density Network model.
modelSamp.m: Give a sample from a model for given X.
demSwissRollLle4.m: Demonstrate LLE on the oil data.
lleDeconstruct.m: break LLE in pieces for saving.
rbfperiodicParamInit.m: RBFPERIODIC model parameter initialisation.
mlpOut.m: Output of an MLP model.
mlpCreate.m: Multi-layer peceptron model.
linearOutputGradX.m: Evaluate derivatives of linear model outputs with respect to inputs.
dnetTest.m: Test some settings for the density network.
mlpParamInit.m: Initialise the parameters of an MLP model.
linearOut.m: Obtain the output of the linear model.
demSwissRollFullLle4.m: Demonstrate LLE on the oil data.
modelGetOutputWeights.m: Wrapper function to return output weight and bias matrices.
dnetOutputGrad.m: Evaluate derivatives of dnet model outputs with respect to parameters.
lleReconstruct.m: Reconstruct an LLE form component parts.
lvmClassVisualise.m: Callback function for visualising data.
dnetCreate.m: Density network model.
mvuOptions.m: Options for a MVU.
leOptions.m: Options for a Laplacian eigenmaps.
mogLowerBound.m: Computes lower bound on log likelihood for an MOG model.
modelTest.m: Run some tests on the specified model.
spectrumVisualise.m: Helper code for showing an spectrum during 2-D visualisation.
mogOptions.m: Sets the default options structure for MOG models.
mogTwoDPlot.m: Helper function for plotting the labels in 2-D.
kpcaEmbed.m: Embed data set with kernel PCA.
lvmClassVisualisePath.m: Latent variable model path drawing in latent space.
paramNameRegularExpressionLookup.m: Returns the indices of the parameter containing the given regular expression.
mogEstep.m: Do an E-step on an MOG model.
demSwissRollLle1.m: Demonstrate LLE on the oil data.
lvmTwoDPlot.m: Helper function for plotting the labels in 2-D.
dnetLogLikelihood.m: Density network log likelihood.
doubleMatrixReadFromFID.m: Read a full matrix from an FID.
modelSetOutputWeights.m: Wrapper function to return set output weight and bias matrices.
mlpExpandParam.m: Update mlp model with new vector of parameters.
multimodelCreate.m: Create a MULTIMODEL model.
ppcaPosteriorVar.m: Mean and variances of the posterior at points given by X.
mogProject.m: Project a mixture of Gaussians to a low dimensional space.
lleEmbed.m: Embed data set with LLE.
ppcaReconstruct.m: Reconstruct an PPCA form component parts.
paramNameReverseLookup.m: Returns the index of the parameter with the given name.
modelDisplay.m: Display a text output of a model.
modelParamInit.m: Initialise the parameters of the model.
modelPosteriorVar.m: variances of the posterior at points given by X.
linearOptions.m: Options for learning a linear model.
lmvuEmbed.m: Embed data set with landmark MVU
rbfCreate.m: Wrapper for NETLAB's rbf `net'.
multimodelLogLikeGradients.m: Gradient of MULTIMODEL model log likelihood with respect to parameters.
mogOptimise.m: Optimise an MOG model.
mogSample.m: Sample from a mixture of Gaussians model.
kbrCreate.m: Create a KBR model.
lleOptions.m: Options for a locally linear embedding.
linearOutputGrad.m: Evaluate derivatives of linear model outputs with respect to parameters.
ppcaOptions.m: Options for probabilistic PCA.
mogLogLikelihood.m: Mixture of Gaussian's log likelihood.
demOilLle4.m: Demonstrate LLE on the oil data.
rbfperiodicDisplay.m: Display parameters of the RBFPERIODIC model.
lvmClickVisualise.m: Visualise the manifold using clicks.
leDeconstruct.m: break LE in pieces for saving.
demOilLle3.m: Demonstrate LLE on the oil data.
springDampersModify.m: Helper code for visualisation of springDamper data.
modelOptimise.m: Optimise the given model.
mvuReconstruct.m: Reconstruct an MVU form component parts.
modelAddDynamics.m: Add a dynamics kernel to the model.
demSwissRollLle2.m: Demonstrate LLE on the oil data.
ppcaEmbed.m: Embed data set with probabilistic PCA.
dnetExtractParam.m: Extract weights and biases from an DNET.
dnetObjective.m: Wrapper function for Density Network objective.
lvmScatterPlot.m: 2-D scatter plot of the latent points.
rbfperiodicOut.m: Compute the output of a RBFPERIODIC model given the structure and input X.
spectralUpdateLaplacian.m: Update the Laplacian using graph connections.
modelLogLikelihood.m: Compute a model log likelihood.
isomapCreate.m: isomap embedding model.
lvmResultsDynamic.m: Load a results file and visualise them.
mappingOptimise.m: Optimise the given model.
kbrParamInit.m: KBR model parameter initialisation.
rbfperiodicCreate.m: Create a RBFPERIODIC model.
ppcaPosteriorMeanVar.m: Mean and variances of the posterior at points given by X.
demSwissRollFullLle3.m: Demonstrate LLE on the oil data.
multimodelOptions.m: Create a default options structure for the MULTIMODEL model.
mvuEmbed.m: Embed data set with MVU.
rbfDisplay.m: Display an RBF network.
isomapEmbed.m: Embed data set with Isomap.
linearOptimise.m: Optimise a linear model.
rbfExtractParam.m: Wrapper for NETLAB's rbfpak.
