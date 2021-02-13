// Gmsh project created on Sat Feb 13 11:32:04 2021
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, 12.73239545, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Transfinite Curve {1} = 3000 Using Progression 1.005;
//+
Physical Curve("Solution") = {1};
//+
Physical Point("Copper_top") = {1};
