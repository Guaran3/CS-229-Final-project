% MLTOOLS toolbox
% Version 0.136		27-Oct-2010
% Copyright (c) 2010, Neil D. Lawrence
% 
, Neil D. Lawrence
% VITERBIALIGN Compute the Viterbi alignment.
% ISOMAPDECONSTRUCT break isomap in pieces for saving.
% LLECREATE Locally linear embedding model.
% LVMNEARESTNEIGHBOUR Give the number of errors in latent space for 1 nearest neighbour.
% ISOMAPRECONSTRUCT Reconstruct an isomap form component parts.
% LINEARDISPLAY Display a linear model.
% MLPLOGLIKELIHOOD Multi-layer perceptron log likelihood.
% RBFPERIODICOUTPUTGRAD Evaluate derivatives of RBFPERIODIC model outputs with respect to parameters.
% VECTORVISUALISE  Helper code for plotting a vector during 2-D visualisation.
% MODELCREATE Create a model of the specified type.
% DNETOPTIMISE Optimise an DNET model.
% LVMCLASSCLICKVISUALISE Callback function for visualising data in 2-D with clicks.
% RBFPERIODICLOGLIKEGRADIENTS Gradient of RBFPERIODIC model log likelihood with respect to parameters.
% DNETUPDATEBETA Do an M-step (update parameters) on an Density Network model.
% DNETGRADIENT Density Network gradient wrapper.
% MOGCREATE Create a mixtures of Gaussians model.
% VECTORMODIFY Helper code for visualisation of vectorial data.
% MODELLOGLIKEGRADIENTS Compute a model's gradients wrt log likelihood.
% IMAGEMODIFY Helper code for visualisation of image data.
% MODELEXTRACTPARAM Extract the parameters of a model.
% LVMLOADRESULT Load a previously saved result.
% DNETPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
% MODELHESSIAN Hessian of error function to minimise for given model.
% MULTIMODELPARAMINIT MULTIMODEL model parameter initialisation.
% LVMVISUALISE Visualise the manifold.
% RBFOUT Output of an RBF model.
% LVMTHREEDPLOT Helper function for plotting the labels in 3-D.
% MULTIMODELDISPLAY Display parameters of the MULTIMODEL model.
% MVUCREATE Maximum variance unfolding embedding model.
% RBFOPTIONS Default options for RBF network.
% MOGMEANCOV Project a mixture of Gaussians to a low dimensional space.
% MLPOPTIONS Options for the multi-layered perceptron.
% PPCAOUT Output of an PPCA model.
% LINEARCREATE Create a linear model.
% LFMCLASSVISUALISE Callback function to visualize LFM in 2D
% SPECTRUMMODIFY Helper code for visualisation of spectrum data.
% LLEOPTIMISE Optimise an LLE model.
% MULTIMODELEXTRACTPARAM Extract parameters from the MULTIMODEL model structure.
% RBFEXPANDPARAM Update rbf model with new vector of parameters.
% LINEARPARAMINIT Initialise the parameters of an LINEAR model.
% DEMSWISSROLLFULLLLE1 Demonstrate LLE on the oil data.
% MODELREADFROMFILE Read model from a file FID produced by the C++ implementation.
% MODELWRITERESULT Write a model to file.
% LECREATE Laplacian eigenmap model.
% MODELGRADIENT Gradient of error function to minimise for given model.
% MLPOUTPUTGRAD Evaluate derivatives of mlp model outputs with respect to parameters.
% PPCADECONSTRUCT break PPCA in pieces for saving.
% MAPMODELREADFROMFID Load from a FID produced by C++ code.
% DNETWRITERESULT Write a DNET result.
% MOGPRINTPLOT Print projection of MOG into two dimensions.
% MODELOUT Give the output of a model for given X.
% DEMOILLLE1 Demonstrate LLE on the oil data.
% MLPOPTIMISE Optimise MLP for given inputs and outputs.
% DOUBLEMATRIXWRITETOFID Writes a double matrix to an FID.
% MODELTIEPARAM Tie parameters of a model together.
% DNETDECONSTRUCT break DNET in pieces for saving.
% DEMOILLLE2 Demonstrate LLE on the oil data.
% MODELPOINTLOGLIKELIHOOD Compute the log likelihood of a given point.
% MOGUPDATEPRIOR Update the priors of an MOG model.
% MATRIXREADFROMFID Read a matrix from an FID.
% MODELOUTPUTGRADX Compute derivatives with respect to model inputs of model outputs.
% MODELOPTIONS Returns a default options structure for the given model.
% DNETOUT Output of an DNET model.
% RBFOUTPUTGRAD Evaluate derivatives of rbf model outputs with respect to parameters.
% LVMRESULTSCLICK Load a results file and visualise them with clicks
% DNETLOADRESULT Load a previously saved result.
% MODELEXPANDPARAM Update a model structure with parameters.
% RBFPERIODICOPTIONS Create a default options structure for the RBFPERIODIC model.
% DISTANCEWARP Dynamic Time Warping Algorithm
% KBROUTPUTGRAD Evaluate derivatives of KBR model outputs with respect to parameters.
% MLPDISPLAY Display the multi-layer perceptron model.
% RBFPERIODICEXPANDPARAM Create model structure from RBFPERIODIC model's parameters.
% DNETOUTPUTGRADX Evaluate derivatives of DNET model outputs with respect to inputs.
% RBFPERIODICEXTRACTPARAM Extract parameters from the RBFPERIODIC model structure.
% LINEAREXTRACTPARAM Extract weights from a linear model.
% LVMPRINTPLOT Print latent space for learnt model.
% ISOMAPOPTIMISE Optimise an ISOMAP model.
% RBFOPTIMISE Optimise RBF for given inputs and outputs.
% RBFOUTPUTGRADX Evaluate derivatives of a RBF model's output with respect to inputs.
% IMAGEVISUALISE Helper code for showing an image during 2-D visualisation.
% RBFPERIODICOUTPUTGRADX Evaluate derivatives of a RBFPERIODIC model's output with respect to inputs.
% MVUDECONSTRUCT break MVU in pieces for saving.
% KBREXTRACTPARAM Extract parameters from the KBR model structure.
% KBROUT Compute the output of a KBR model given the structure and input X.
% DNETLOWERBOUND Computes lower bound on log likelihood for an DNET model.
% MLPLOGLIKEGRADIENTS Multi-layer perceptron gradients.
% MODELWRITETOFID Write to a stream a given model.
% SPECTRALUPDATEX Update the latent representation for spectral model.
% DNETLOGLIKEGRADIENTS Density network gradients.
% MLPEXTRACTPARAM Extract weights and biases from an MLP.
% MODELREADFROMFID Load from a FID produced by C++ code.
% KBROPTIONS Create a default options structure for the KBR model.
% KBROPTIMISE Optimise a KBR model.
% LVMSCATTERPLOTCOLOR 2-D scatter plot of the latent points with color.
% MODELLOADRESULT Load a previously saved result.
% LFMRESULTSDYNAMIC Load a results file and visualise them.
% LINEARLOGLIKEGRADIENTS Linear model gradients.
% MLPLOGLIKEHESSIAN Multi-layer perceptron Hessian.
% LFMVISUALISE Visualise the outputs in a latent force model
% MODELOUTPUTGRAD Compute derivatives with respect to params of model outputs.
% LVMSETPLOT Sets up the plot for visualization of the latent space.
% MODELGRADIENTCHECK Check gradients of given model.
% MULTIMODELLOGLIKELIHOOD Log likelihood of MULTIMODEL model.
% LERECONSTRUCT Reconstruct an LE form component parts.
% ISOMAPOPTIONS Options for a isomap.
% LVMSCOREMODEL Score model with a GP log likelihood.
% DNETOPTIONS Options for a density network.
% DNETUPDATEOUTPUTWEIGHTS Do an M-step (update parameters) on an Density Network model.
% MODELPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
% PPCACREATE Density network model.
% SMALLRANDEMBED Embed data set with small random values.
% LVMSCATTERPLOTNEIGHBOURS 2-D scatter plot of the latent points with neighbourhood.
% MODELOBJECTIVE Objective function to minimise for given model.
% LINEAREXPANDPARAM Update linear model with vector of parameters.
% DEMMPPCA1 Demonstrate MPPCA on a artificial dataset.
% MULTIMODELEXPANDPARAM Create model structure from MULTIMODEL model's parameters.
% MOGUPDATECOVARIANCE Update the covariances of an MOG model.
% KBREXPANDPARAM Create model structure from KBR model's parameters.
% DNETEXPANDPARAM Update dnet model with new vector of parameters.
% LEOPTIMISE Optimise an LE model.
% DEMSWISSROLLFULLLLE2 Demonstrate LLE on the oil data.
% KBRDISPLAY Display parameters of the KBR model.
% MLPOUTPUTGRADX Evaluate derivatives of mlp model outputs with respect to inputs.
% DNETRECONSTRUCT Reconstruct an DNET form component parts.
% FINDNEIGHBOURS find the k nearest neighbours for each point in Y.
% SPRINGDAMPERSVISUALISE Helper code for showing an spring dampers during 2-D visualisation.
% LINEARLOGLIKELIHOOD Linear model log likelihood.
% MVUOPTIMISE Optimise an MVU model.
% RBFPERIODICLOGLIKELIHOOD Log likelihood of RBFPERIODIC model.
% MLTOOLSTOOLBOXES Load in the relevant toolboxes for the MLTOOLS.
% DEMSWISSROLLLLE3 Demonstrate LLE on the oil data.
% MOGUPDATEMEAN Update the means of an MOG model.
% DNETESTEP Do an E-step (update importance weights) on an Density Network model.
% MODELSAMP Give a sample from a model for given X.
% DEMSWISSROLLLLE4 Demonstrate LLE on the oil data.
% LLEDECONSTRUCT break LLE in pieces for saving.
% RBFPERIODICPARAMINIT RBFPERIODIC model parameter initialisation.
% MLPOUT Output of an MLP model.
% MLPCREATE Multi-layer peceptron model.
% LINEAROUTPUTGRADX Evaluate derivatives of linear model outputs with respect to inputs.
% DNETTEST Test some settings for the density network.
% MLPPARAMINIT Initialise the parameters of an MLP model.
% LINEAROUT Obtain the output of the linear model.
% DEMSWISSROLLFULLLLE4 Demonstrate LLE on the oil data.
% MODELGETOUTPUTWEIGHTS Wrapper function to return output weight and bias matrices.
% DNETOUTPUTGRAD Evaluate derivatives of dnet model outputs with respect to parameters.
% LLERECONSTRUCT Reconstruct an LLE form component parts.
% LVMCLASSVISUALISE Callback function for visualising data.
% DNETCREATE Density network model.
% MVUOPTIONS Options for a MVU.
% LEOPTIONS Options for a Laplacian eigenmaps.
% MOGLOWERBOUND Computes lower bound on log likelihood for an MOG model.
% MODELTEST Run some tests on the specified model.
% SPECTRUMVISUALISE Helper code for showing an spectrum during 2-D visualisation.
% MOGOPTIONS Sets the default options structure for MOG models.
% MOGTWODPLOT Helper function for plotting the labels in 2-D.
% KPCAEMBED Embed data set with kernel PCA.
% LVMCLASSVISUALISEPATH Latent variable model path drawing in latent space.
% PARAMNAMEREGULAREXPRESSIONLOOKUP Returns the indices of the parameter containing the given regular expression.
% MOGESTEP Do an E-step on an MOG model.
% DEMSWISSROLLLLE1 Demonstrate LLE on the oil data.
% LVMTWODPLOT Helper function for plotting the labels in 2-D.
% DNETLOGLIKELIHOOD Density network log likelihood.
% DOUBLEMATRIXREADFROMFID Read a full matrix from an FID.
% MODELSETOUTPUTWEIGHTS Wrapper function to return set output weight and bias matrices.
% MLPEXPANDPARAM Update mlp model with new vector of parameters.
% MULTIMODELCREATE Create a MULTIMODEL model.
% PPCAPOSTERIORVAR Mean and variances of the posterior at points given by X.
% MOGPROJECT Project a mixture of Gaussians to a low dimensional space.
% LLEEMBED Embed data set with LLE.
% PPCARECONSTRUCT Reconstruct an PPCA form component parts.
% PARAMNAMEREVERSELOOKUP Returns the index of the parameter with the given name.
% MODELDISPLAY Display a text output of a model.
% MODELPARAMINIT Initialise the parameters of the model.
% MODELPOSTERIORVAR variances of the posterior at points given by X.
% LINEAROPTIONS Options for learning a linear model.
% LMVUEMBED Embed data set with landmark MVU
% RBFCREATE Wrapper for NETLAB's rbf `net'.
% MULTIMODELLOGLIKEGRADIENTS Gradient of MULTIMODEL model log likelihood with respect to parameters.
% MOGOPTIMISE Optimise an MOG model.
% MOGSAMPLE Sample from a mixture of Gaussians model.
% KBRCREATE Create a KBR model.
% LLEOPTIONS Options for a locally linear embedding.
% LINEAROUTPUTGRAD Evaluate derivatives of linear model outputs with respect to parameters.
% PPCAOPTIONS Options for probabilistic PCA.
% MOGLOGLIKELIHOOD Mixture of Gaussian's log likelihood.
% DEMOILLLE4 Demonstrate LLE on the oil data.
% RBFPERIODICDISPLAY Display parameters of the RBFPERIODIC model.
% LVMCLICKVISUALISE Visualise the manifold using clicks.
% LEDECONSTRUCT break LE in pieces for saving.
% DEMOILLLE3 Demonstrate LLE on the oil data.
% SPRINGDAMPERSMODIFY Helper code for visualisation of springDamper data.
% MODELOPTIMISE Optimise the given model.
% MVURECONSTRUCT Reconstruct an MVU form component parts.
% MODELADDDYNAMICS Add a dynamics kernel to the model.
% DEMSWISSROLLLLE2 Demonstrate LLE on the oil data.
% PPCAEMBED Embed data set with probabilistic PCA.
% DNETEXTRACTPARAM Extract weights and biases from an DNET.
% DNETOBJECTIVE Wrapper function for Density Network objective.
% LVMSCATTERPLOT 2-D scatter plot of the latent points.
% RBFPERIODICOUT Compute the output of a RBFPERIODIC model given the structure and input X.
% SPECTRALUPDATELAPLACIAN Update the Laplacian using graph connections.
% MODELLOGLIKELIHOOD Compute a model log likelihood.
% ISOMAPCREATE isomap embedding model.
% LVMRESULTSDYNAMIC Load a results file and visualise them.
% MAPPINGOPTIMISE Optimise the given model.
% KBRPARAMINIT KBR model parameter initialisation.
% RBFPERIODICCREATE Create a RBFPERIODIC model.
% PPCAPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
% DEMSWISSROLLFULLLLE3 Demonstrate LLE on the oil data.
% MULTIMODELOPTIONS Create a default options structure for the MULTIMODEL model.
% MVUEMBED Embed data set with MVU.
% RBFDISPLAY Display an RBF network.
% ISOMAPEMBED Embed data set with Isomap.
% LINEAROPTIMISE Optimise a linear model.
% RBFEXTRACTPARAM Wrapper for NETLAB's rbfpak.
