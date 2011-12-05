% FGPLVM toolbox
% Version 0.163		19-May-2010
% Copyright (c) 2010, Neil D. Lawrence
% 
, Neil D. Lawrence
% DEMVOWELSFGPLVM3 Model the vowels data with a 2-D FGPLVM using RBF kernel and back constraints, but without PCA initialisation.
% GPDYNAMICSDISPLAY Display a GP dynamics model.
% GPREVERSIBLEDYNAMICSLOGLIKELIHOOD Give the log likelihood of the dynamics part.
% FGPLVMOPTIONS Return default options for FGPLVM model.
% FGPLVMSEQUENCELOGLIKELIHOOD Log-likelihood of a sequence for the GP-LVM.
% ROBTHREEDYNAMICSEXPANDPARAM Place the parameters vector into the model for first robot dynamics.
% DEMVOWELSFGPLVM1 Model the vowels data with a 2-D FGPLVM using RBF kernel and back constraints.
% FGPLVMADDCONSTRAINT Add latent constraints to FGPLVM model
% GPTIMEDYNAMICSCREATE Create the time dynamics model. 
% ROBONEDYNAMICSEXPANDPARAM Place the parameters vector into the model for first robot dynamics.
% MODELLATENTGRADIENTS Gradients of the latent variables for dynamics models in the GPLVM.
% FGPLVMCOVGRADSTEST Test the gradients of the covariance.
% DEMROBOTWIRELESSFGPLVM1 Wireless Robot data from University of Washington, without dynamics and without back constraints.
% GPREVERSIBLEDYNAMICSSAMP Sample from the dynamics for a given input.
% ROBTWODYNAMICSSETLATENTVALUES Set the latent values inside the model.
% FGPLVMDYNAMICSPLOT 2-D scatter plot of the latent points.
% DEMOILFGPLVM2 Oil data with fully independent training conditional, and MLP back constraints.
% FGPLVMLOGLIKEGRADIENTS Compute the gradients for the FGPLVM.
% ROBTHREEDYNAMICSSETLATENTVALUES Set the latent values inside the model.
% GPTIMEDYNAMICSEXPANDPARAM Place the parameters vector into the model for GP time dynamics.
% GPDYNAMICSSETLATENTVALUES Set the latent values inside the model.
% ROBTWODYNAMICSEXPANDPARAM Place the parameters vector into the model for first robot dynamics.
% FGPLVMGRADIENT GP-LVM gradient wrapper.
% DEMWALKSITJOGDYNAMICSLEARN Learn the stick man dynamics.
% GPSEQUENCELOGLIKEGRADIENT Log-likelihood gradient for of a sequence of the GP-LVM.
% FGPLVMTESTMISSING Make sure missing data likelihood match full ones.
% DEMROBOTWIRELESSFGPLVM3 Wireless Robot data from University of Washington with dynamics and no back constraints.
% FGPLVMCMU35ANIMATE Animate the test data jointly with predictions.
% FGPLVMPOINTLOGLIKEGRADIENT Log-likelihood gradient for of a point of the GP-LVM.
% ROBTWODYNAMICSLOGLIKELIHOOD Give the log likelihood of the robot one dynamics part.
% GPDYNAMICSLATENTGRADIENTS Gradients of the X vector given the dynamics model.
% GPDYNAMICSPOINTLOGLIKELIHOOD Compute the log likelihood of a point under the GP dynamics model.
% FGPLVMWRITERESULT Write a FGPLVM result.
% GPDYNAMICSCREATE Create the dynamics model. 
% FGPLVMEXPANDPARAM Expand a parameter vector into a GP-LVM model.
% ROBTWODYNAMICSLATENTGRADIENTS Gradients of the X vector given the dynamics model.
% CMDSROADDATA This script uses classical MDS to visualise some road distance data.
% DEMVOWELSFGPLVM2 Model the vowels data with a 2-D FGPLVM using RBF kernel.
% FGPLVMOPTIMISEPOINT Optimise the postion of a latent point.
% FGPLVMSEQUENCEGRADIENT Wrapper function for gradient of a latent sequence.
% DEMOILFGPLVM9 Oil data with three dimensions and variational sparse approximation.
% FGPLVMTAYLORANGLEERRORS Helper function for computing angle errors for CMU 35 data.
% FGPLVMDYNAMICSRUN Runs auto regressive dynamics in a forward manner.
% FGPLVMPOINTLOGLIKELIHOOD Log-likelihood of a point for the GP-LVM.
% DEMFOURWALKS1 Model four seperate walsk using an RBF kernel and dynamics.
% FGPLVMOBJECTIVE Wrapper function for GP-LVM objective.
% DEMCMU35SEQUENCEOPTIMISE 
% FGPLVMSEQUENCEOBJECTIVE Wrapper function for objective of a single sequence in latent space and the corresponding output sequence.
% DEMOIL100FGPLVM1 Oil100 data with fully independent training conditional.
% DEMOILFGPLVM3 Oil data with deterministic training conditional.
% FGPLVMFIELDPLOT 2-D field plot of the dynamics.
% GPDYNAMICSEXPANDPARAM Place the parameters vector into the model for GP dynamics.
% DEMBRENDANPPCA1 Use PPCA to model the Frey face data with five latent dimensions.
% DEMCMU35GPLVMRECONSTRUCT Reconstruct right leg and body of CMU 35.
% FGPLVMREADFROMFID Load from a FID produced by the C++ implementation.
% GPTIMEDYNAMICSLOGLIKELIHOOD Give the log likelihood of GP time dynamics.
% FGPLVMRESULTSCPP Load a results file and visualise them.
% FGPLVMVISUALISE Visualise the manifold.
% GPDYNAMICSSAMP Sample from the dynamics for a given input.
% ROBTWODYNAMICSCREATE Create the dynamics model. 
% FGPLVMCREATE Create a GPLVM model with inducing variables.
% DEMSTICKFGPLVM5 Model the stick man using an RBF kernel and regressive dynamics.
% ROBTHREEDYNAMICSDISPLAY Display the robot dynamics model. 
% GPDYNAMICSLOGLIKEGRADIENTS Gradients of the GP dynamics wrt parameters.
% DEMOILFGPLVM7 Oil data with variational sparse approximation.
% DEMCMU35GPLVM4 Learn a GPLVM on CMU 35 data set.
% GPTIMEDYNAMICSLATENTGRADIENTS Gradients of the X vector given the time dynamics model.
% GPREVERSIBLEDYNAMICSDISPLAY Display a GP dynamics model.
% FGPLVMKERNDYNAMICSSAMPLE Sample a field from a given kernel.
% DEMCMU35ANIMATE Animate reconstructed right leg and body.
% ROBTHREEDYNAMICSLOGLIKELIHOOD Give the log likelihood of the robot three dynamics part.
% ROBONEDYNAMICSLATENTGRADIENTS Gradients of the X vector given the dynamics model.
% DEMSTICKFGPLVM3 Model the stick man using an RBF kernel and RBF kernel based back constraints.
% ROBTHREEDYNAMICSEXTRACTPARAM Extract parameters from the robot three dynamics model.
% DEMOILFGPLVM5 Oil data with partially independent training conditional.
% FGPLVMNEARESTNEIGHBOUR Give the number of errors in latent space for 1 nearest neighbour.
% DEMBRENDANFGPLVM3 Use the GP-LVM to model the Frey face data with DTCVAR.
% ROBTWODYNAMICSEXTRACTPARAM Extract parameters from the robot two dynamics model.
% DEMCMU35GPLVMRECONSTRUCTTAYLOR Reconstruct right leg of CMU 35.
% FGPLVMTEST Test the gradients of the gpCovGrads function and the fgplvm models.
% DEMFOURWALKSRECONSTRUCT Reconstruct right leg of CMU 35.
% DEMSTICKFGPLVM2 Model the stick man using an RBF kernel and dynamics.
% DEMCMU35GPLVMFGPLVM3 Learn a GPLVM on CMU 35 data set.
% DEMSTICKFGPLVM4 Model the stick man using an RBF kernel and 3-D latent space.
% FGPLVMPOINTOBJECTIVEGRADIENT Wrapper function for objective and gradient of a single point in latent space and the output location..
% GPDYNAMICSSEQUENCELOGLIKELIHOOD Return the log likelihood of a given latent sequence.
% DEMBRENDANFGPLVM1 Use the GP-LVM to model the Frey face data with FITC.
% GPTIMEDYNAMICSSEQUENCELOGLIKEGRADIENT Log-likelihood gradient for of a sequence of the GP-LVM time dynamics.
% GPLVMCMU35ANIMATE Animate the test data jointly with predictions.
% FGPLVMCLASSVISUALISE Callback function for visualising data in 2-D.
% FGPLVMOBJECTIVEGRADIENT Wrapper function for FGPLVM objective and gradient.
% GPDYNAMICSEXTRACTPARAM Extract parameters from the GP dynamics model.
% FGPLVMDYNAMICSFIELDPLOT 2-D field plot of the dynamics.
% ROBONEDYNAMICSLOGLIKELIHOOD Give the log likelihood of the robot one dynamics part.
% ROBTWODYNAMICSDISPLAY Display the robot dynamics model. 
% GPTIMEDYNAMICSEXTRACTPARAM Extract parameters from the GP time dynamics model.
% FGPLVMPRINTPLOT Print latent space for learnt model.
% DEMBRENDANFGPLVM4 Use the GP-LVM to model the Frey face data with DTCVAR and back constraints.
% FGPLVMPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
% ROBONEDYNAMICSDISPLAY Display the robot dynamics model. 
% FGPLVMRECONSTRUCT Reconstruct an FGPLVM from component parts.
% FGPLVMOPTIMISESEQUENCE Optimise the postion of a latent sequence.
% DEMVOWELSLLE Model the vowels data with a 2-D FGPLVM using RBF kernel.
% DEMOIL100FGPLVM2 Oil100 data with FGPLVM.
% GPREVERSIBLEDYNAMICSEXTRACTPARAM Extract parameters from the GP reversible dynamics model.
% FGPLVMEXTRACTPARAM Extract a parameter vector from a GP-LVM model.
% DEMVOWELSISOMAP Model the vowels data with a 2-D FGPLVM using RBF kernel.
% DEMOILFGPLVM8 Oil data with variational sparse approximation.
% FGPLVMDYNAMICSPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
% DEMOILFGPLVM4 Oil data with deterministic training conditional, and MLP back constraints.
% FGPLVMSEQUENCEOBJECTIVEGRADIENT Wrapper function for objective
% FGPLVMRESULTSDYNAMIC Load a results file and visualise them.
% FGPLVMLOADRESULT Load a previously saved result.
% FGPLVMREADFROMFILE Load a file produced by the C++ implementation.
% FGPLVMLOGLIKELIHOOD Log-likelihood for a GP-LVM.
% GPTIMEDYNAMICSLOGLIKEGRADIENTS Gradients of the GP dynamics wrt parameters.
% ROBONEDYNAMICSSETLATENTVALUES Set the latent values inside the model.
% FGPLVMADDDYNAMICS Add a dynamics kernel to the model.
% GPTIMEDYNAMICSDISPLAY Display a GP time dynamics model.
% ROBONEDYNAMICSEXTRACTPARAM Extract parameters from the robot one dynamics model.
% DEMOILFGPLVM1 Oil data with fully independent training conditional.
% GPDYNAMICSSEQUENCELOGLIKEGRADIENT Log-likelihood gradient for of a sequence of the GP-LVM dynamics.
% DEMCMU35GPLVMFGPLVM2 Learn a GPLVM on CMU 35 data set.
% FGPLVMVITERBISEQUENCE Viterbi align a latent sequence.
% ROBONEDYNAMICSLOGLIKEGRADIENTS Gradients of the robot one dynamics wrt parameters.
% DEMTWOCLUSTERS1
% ROBTHREEDYNAMICSLATENTGRADIENTS Gradients of the X vector given the dynamics model.
% DEMROBOTWIRELESSFGPLVM4 Wireless Robot data from University of Washington with dynamics and back constraints.
% GPREVERSIBLEDYNAMICSSETLATENTVALUES Set the latent values inside the model.
% FGPLVMDISPLAY Display an FGPLVM model.
% DEMCMU35GPLVMFGPLVM1 Learn a GPLVM on CMU 35 data set.
% DEMSTICKFGPLVM1 Model the stick man using an RBF kernel.
% ROBONEDYNAMICSCREATE Create the dynamics model. 
% GPTIMEDYNAMICSSETLATENTVALUES Set the latent values inside the model.
% DEMCMU35TAYLORNEARESTNEIGHBOUR Recreate the Nearest Neighbour result from Taylor et al, NIPS 2006.
% GPTIMEDYNAMICSSEQUENCELOGLIKELIHOOD Return the log likelihood of a given latent sequence.
% DEMROBOTTRACES1 Wireless Robot data from University of Washington, with tailored dynamics.
% DEMOILFGPLVM6 Oil data with partially independent training conditional, and MLP back constraints.
% FGPLVMSEQUENCELOGLIKEGRADIENT Log-likelihood gradient for of a sequence of the GP-LVM.
% DEMROBOTWIRELESSFGPLVM2 Wireless Robot data from University of Washington, without dynamics and without back constraints.
% GPTIMEDYNAMICSOUT Evaluate the output of GPTIMEDYNAMICS.
% ROBTHREEDYNAMICSCREATE Create the dynamics model. 
% ROBTWODYNAMICSLOGLIKEGRADIENTS Gradients of the robot two dynamics wrt parameters.
% DYNAMICSTEST Run some tests on the specified dynamics model.
% ROBTHREEDYNAMICSLOGLIKEGRADIENTS Gradients of the robot three dynamics wrt parameters.
% DEMBRENDANFGPLVM5 Use the GP-LVM to model the Frey face data with DTCVAR and five latent dimensions..
% FGPLVMBACKCONSTRAINTGRAD Gradient with respect to back constraints if present.
% FGPLVMDECONSTRUCT break FGPLVM in pieces for saving.
% GPREVERSIBLEDYNAMICSLATENTGRADIENTS Gradients of the X vector given the dynamics model.
% GPDYNAMICSLOGLIKELIHOOD Give the log likelihood of GP dynamics.
% GPREVERSIBLEDYNAMICSOPTIONS Return default options for GP reversible dynamics model.
% GPREVERSIBLEDYNAMICSCREATE Create a reversible dynamics model. 
% GPREVERSIBLEDYNAMICSLOGLIKEGRADIENTS Gradients of the GP reversible dynamics wrt parameters.
% DEMROBOTWIRELESSNAVIGATE Take some test data for the robot and navigate with it.
% FGPLVMPOSTERIORVAR Variances of the posterior at points given by X.
% DEMBRENDANFGPLVM2 Use the GP-LVM to model the Frey face data with FITC and back constraints.
% FGPLVMPOINTGRADIENT Wrapper function for gradient of a single point.
% GPREVERSIBLEDYNAMICSEXPANDPARAM Place the parameters vector into the model for GP dynamics.
% FGPLVMPOINTSAMPLELOGLIKELIHOOD
% FGPLVMTOOLBOXES Load in the relevant toolboxes for fgplvm.
% MODELSETLATENTVALUES Set the latent variables for dynamics models in the GPLVM.
% FGPLVMDYNAMICSSAMPLE Sample a field from the GP.
% FGPLVMPOINTOBJECTIVE Wrapper function for objective of a single point in latent space and the output location..
% FGPLVMOPTIMISE Optimise the FGPLVM.
