function [g1, g2] = ggXgaussianKernGradient(ggKern, gaussianKern, x, x2, covGrad)

% GGXGAUSSIANKERNGRADIENT Compute gradient between the GG and GAUSSIAN kernels.
%
%	Description:
%
%	[G1, G2] = GGXGAUSSIANKERNGRADIENT(GGKERN, GAUSSIANKERN, X) computes
%	the gradient of an objective function with respect to cross kernel
%	terms between GG and GAUSSIAN kernels for the multiple output
%	kernel.
%	 Returns:
%	  G1 - gradient of objective function with respect to kernel
%	   parameters of GG kernel.
%	  G2 - gradient of objective function with respect to kernel
%	   parameters of GAUSSIAN kernel.
%	 Arguments:
%	  GGKERN - the kernel structure associated with the GG kernel.
%	  GAUSSIANKERN - the kernel structure associated with the GAUSSIAN
%	   kernel.
%	  X - inputs for which kernel is to be computed.
%
%	[G1, G2] = GGXGAUSSIANKERNGRADIENT(GGKERN, GAUSSIANKERN, X1, X2)
%	computes the gradient of an objective function with respect to cross
%	kernel terms between GG and GAUSSIAN kernels for the multiple output
%	kernel.
%	 Returns:
%	  G1 - gradient of objective function with respect to kernel
%	   parameters of GG kernel.
%	  G2 - gradient of objective function with respect to kernel
%	   parameters of GAUSSIAN kernel.
%	 Arguments:
%	  GGKERN - the kernel structure associated with the GG kernel.
%	  GAUSSIANKERN - the kernel structure associated with the GAUSSIAN
%	   kernel.
%	  X1 - row inputs for which kernel is to be computed.
%	  X2 - column inputs for which kernel is to be computed.
%	gaussianKernParamInit
%	
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, GGKERNPARAMINIT, 


%	Copyright (c) 2008 Mauricio A. Alvarez and Neil D. Lawrence


%	With modifications by Mauricio A. Alvarez 2009
% 	ggXgaussianKernGradient.m SVN version 426
% 	last update 2009-07-17T10:58:29.000000Z
 
if nargin < 5
    covGrad = x2;
    x2 = x;
end

matGradPr  = zeros(size(ggKern.precisionU));
matGradPqr = zeros(size(ggKern.precisionG));


if ggKern.isArd
    [K, Kbase, Pqrinv, Prinv, P, fSigma2Noise, fSens1] = ...
        ggXgaussianKernCompute(ggKern, gaussianKern, x, x2);    
    preFactorPqr = 1./(2*Pqrinv + Prinv);
    preFactorPr  = 1./Prinv + (1./(2*Pqrinv + Prinv));
    for i=1:ggKern.inputDimension
        X = repmat(x(:,i),1, size(x2,1));
        X2 = repmat(x2(:,i)',size(x,1),1);
        X_X2 = (X - X2).*(X - X2);
        matGradPr(i) = sum(sum(0.5*covGrad.*K.*...
            (Prinv(i)*(P(i) - 0.5*preFactorPr(i)- P(i)*X_X2*P(i))*Prinv(i))));
        matGradPqr(i) = sum(sum(0.5*covGrad.*K.*...
            (Pqrinv(i)*(P(i) - preFactorPqr(i)- P(i)*X_X2*P(i))*Pqrinv(i))));
    end
else
    [K, Kbase, Pqrinv, Prinv, P, fSigma2Noise, fSens1, dist] = ...
        ggXgaussianKernCompute(ggKern, gaussianKern, x, x2);
    dim = ggKern.inputDimension;
    preFactorPqr = 1/(2*Pqrinv + Prinv);
    preFactorPr = 1/Prinv + (1/(2*Pqrinv + Prinv));
    matGradPr = sum(sum(0.5*covGrad.*K.*...
        (Prinv*(dim*P - 0.5*dim*preFactorPr- P*dist*P)*Prinv)));   
    matGradPqr = sum(sum(0.5*covGrad.*K.*...
        (Pqrinv*(dim*P - dim*preFactorPqr- P*dist*P)*Pqrinv)));   
end

gradSigma2Latent =  fSigma2Noise*sum(sum(covGrad.*Kbase));
gradSens1 = fSens1*sum(sum(covGrad.*Kbase));

% only pass the gradient with respect to the inverse width to one
% of the gradient vectors ... otherwise it is counted twice.
g1 = [matGradPr(:)' matGradPqr(:)' gradSigma2Latent gradSens1];
g2 = zeros(1,size(matGradPr,1)+1);

