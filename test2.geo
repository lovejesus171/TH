// Gmsh project created on Thu Sep 03 11:42:37 2020
SetFactory("OpenCASCADE");
//+
Cylinder(1) = {0, 0, 0, 0, 0, 0.0707, 0.015, 2*Pi};
//+
Physical Volume("solution") = {1};
//+
Physical Surface("solution_top") = {2};
//+
Physical Surface("solution_bottom") = {3};
//+
Physical Surface("solution_side") = {1};
//+
Box(2) = {1, 1, 0, 0.01, 0.01, 0.002};
//+
Physical Volume("Cu") = {2};
//+
Physical Surface("Cu_top") = {9};
//+
Physical Surface("Cu_bottom") = {8};
//+
Physical Surface("Cu_sides") = {6, 7, 5, 4};
//+
Box(3) = {0.5, 0.5, 0, 0.012, 0.012, 0.002};
//+
Physical Volume("sample") = {3};
//+
Physical Surface("sample_top") = {15};
//+
Physical Surface("sample_bottom") = {14};
//+
Physical Surface("sample_sides") = {13, 10, 12, 11};
//+
Translate {-1.005, -1.005, 0} {
  Volume{2}; 
}
//+
Translate {-0.506, -0.506, 0} {
  Volume{3}; 
}
