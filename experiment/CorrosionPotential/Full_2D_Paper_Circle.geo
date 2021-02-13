// Gmsh project created on Tue Feb 09 15:25:32 2021
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0.035, 0, 0, 1.0};
//+
Point(3) = {0.040, 0, 0, 1.0};
//+
Point(4) = {0.045, 0, 0, 1.0};
//+
Point(5) = {0.050, 0, 0, 1.0};
//+
Point(6) = {0.055, 0, 0, 1.0};
//+
Point(7) = {0.060, 0, 0, 1.0};
//+
Point(8) = {0.065, 0, 0, 1.0};
//+
Point(9) = {0.1, 0, 0, 1.0};
//+
Point(10) = {0.1, 0.127323954, 0, 1.0};
//+
Point(11) = {0, 0.127323954, 0, 1.0};
//+
Line(1) = {1,2};
//+
Line(2) = {2,3};
//+
Line(3) = {3,4};
//+
Line(4) = {4,5};
//+
Line(5) = {5,6};
//+
Line(6) = {6,7};
//+
Line(7) = {7,8};
//+
Line(8) = {8,9};
//+
Line(9) = {9,10};
//+
Line(10) = {10,11};
//+
Line(11) = {11,1};
//+
Curve Loop(1) = {11, 1, 2, 3, 4, 5,6,7,8,9,10};
Surface(1) = {1};
//+
Circle(12) = {4, 5, 6};
//+
Circle(13) = {3, 5, 7};
//+
Circle(14) = {2, 5, 8};
//+
Curve Loop(3) = {5, -12, 4};
//+
Surface(2) = {3};
//+
Curve Loop(5) = {6, -13, 3, 12};
//+
Surface(3) = {5};
//+
Curve Loop(7) = {13, 7, -14, 2};
//+
Surface(4) = {7};
//+
BooleanFragments {Surface{1,2,3,4};Delete;}{}
//+
Transfinite Curve {24,25} = 25 Using Progression 1;
//+
Transfinite Curve {12} = 70 Using Progression 1;
//+
Transfinite Curve {23,22} = 15 Using Progression 1;
//+
Transfinite Curve {13} = 50 Using Progression 1;
//+
Transfinite Curve {21,20} = 15 Using Progression 1;
//+
Transfinite Curve {17} = 50 Using Progression 1;
//+
Transfinite Curve {16} = 25 Using Progression 0.97;
//+
Transfinite Curve {18} = 25 Using Progression 1.03;
//+
Transfinite Curve {15,19} = 25 Using Progression 0.997;
//+
Transfinite Curve {14} = 25 Using Progression 1;//+
Physical Surface("Solution") = {5, 4, 3, 2};
//+
Physical Curve("Copper_top") = {24, 25};
