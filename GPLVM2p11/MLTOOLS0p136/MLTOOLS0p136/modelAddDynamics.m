function model = modelAddDynamics(model, type, varargin)

% MODELADDDYNAMICS Add a dynamics kernel to the model.
%
%	Description:
%
%	MODELADDDYNAMICS(MODEL, TYPE, ...) adds a dynamics model to a model.
%	 Arguments:
%	  MODEL - the model to add dynamics to.
%	  TYPE - the type of dynamics model to add in.
%	  ... - additional arguments to be passed on creation of the
%	   dynamics model.
%	
%
%	See also
%	MODELCREATE


%	Copyright (c) 2005, 2006, 2007 Neil D. Lawrence
% 	modelAddDynamics.m CVS version 1.1
% 	modelAddDynamics.m SVN version 24
% 	last update 2007-05-22T23:18:56.000000Z

type = [type 'Dynamics'];
model.dynamics = modelCreate(type, model.q, model.q, model.X, varargin{:});
params = modelExtractParam(model);
model = modelExpandParam(model, params);

