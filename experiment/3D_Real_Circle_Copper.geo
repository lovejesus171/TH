// Gmsh project created on Tue Sep 08 10:46:33 2020
SetFactory("OpenCASCADE");
//+
Cylinder(1) = {0, 0, 0, 0, 0, 0.070847, 0.015, 2*Pi};
//+
Cylinder(2) = {0, 0, 0, 0, 0, 0.001, 0.005, 2*Pi};
//+
BooleanDifference(3) = { Volume{1}; Delete;}{ Volume{2}; Delete;};//+
Physical Volume("Solution") = {3};
//+
Physical Surface("Solution_BC") = {2, 1, 3};
//+
Physical Surface("Copper_top") = {5};
//+
Physical Surface("Copper_side") = {4};
