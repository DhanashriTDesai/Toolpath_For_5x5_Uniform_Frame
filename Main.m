close all; clear all; clc; % Housekeeping commands
global nCellH nCellV Nrows Ncolumns BoundaryNodeID CentralNodeID nnodes nelem nx ny elemcon L LCell LCellH LCellV E tStrut bStrut Linclined

nCellH = 5; nCellV = 5; % No of cells in horizontal and vertical  direction
Nrows = nCellV+1; Ncolumns = nCellH+1; % no of rows and columns in the grid

tStrut = 0.002*1000; bStrut = 0.002*1000; % width (layer height) of strut in meters
RhoRel = 0.4; LCell=6.83*tStrut/RhoRel;
LCellH = LCell/2; LCellV = LCellH; Linclined = sqrt(LCellH^2+LCellV^2);
E0=0.5; dLdE=60; % uniform rate at which motor feed increases
nLayer=8; % no. of layers to be printed

% generate grid of nodes and elements
[BoundaryNodeID,CentralNodeID,nnodes,nelem,nx,ny,elemcon,L] = ...
Generate2DGrid(nCellH,nCellV,Nrows,Ncolumns,LCell,LCellH,LCellV);

% generate continuous nodal path
[NPh,NPv,NPzigzag] = GenerateNodalPath();

% generate uniform flow rate data according to nodal path
[E,nExtr] = GenerateFeedRate(nelem,nLayer,LCell,Linclined,E0,dLdE);

% generate G-code file
WriteToFile(NPh,NPv,NPzigzag,nx,ny,E,nExtr,nLayer);