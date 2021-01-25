// Gmsh project created on Wed Jan 20 14:30:19 2021
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1E-4, 0, 0, 1.0};
//+
Point(3) = {1.5E-4, 0, 0, 1.0};
//+
Point(4) = {2E-4, 0, 0, 1.0};
//+
Point(5) = {3E-4, 0, 0, 1.0};
//+
Point(5) = {1E-4, 0, 0, 1.0};
//+
Line(1) = {1,2};
//+
Line(2) = {2,3};
//+
Line(3) = {3,4};
//+
Line(4) = {4,5};
//+
BooleanFragments{ Line{1,2,3,4}; Delete; }{}
//+
Transfinite Curve {1} = 300 Using Progression 0.99;
//+
Transfinite Curve {2} = 300 Using Progression 1.01;
//+
Transfinite Curve {3} = 300 Using Progression 0.99;
//+
Transfinite Curve {4} = 300 Using Progression 1.01;
//+
Physical Curve("S1") = {1};
//+
Physical Curve("M1") = {2};
//+
Physical Curve("M2") = {3};
//+
Physical Curve("S2") = {4};
//+
Physical Point("left") = {1};
//+
Physical Point("right") = {5};
