// Gmsh project created on Tue Feb 09 15:25:32 2021
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0.045, 0, 0, 1.0};
//+
Point(3) = {0.055, 0, 0, 1.0};
//+
Point(4) = {0.1, 0, 0, 1.0};
//+
Point(5) = {0.1, 0.127323954, 0, 1.0};
//+
Point(6) = {0, 0.127323954, 0, 1.0};
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
Line(6) = {6,1};
//+
Curve Loop(1) = {6, 1, 2, 3, 4, 5};
Surface(1) = {1};
//+
Rectangle(2) = {0.045, 0, 0, 0.01, 0.0001, 0};
//+
Rectangle(3) = {0.0445, 0, 0, 0.011, 0.0003, 0};
//+
Rectangle(4) = {0.044, 0, 0, 0.012, 0.0005, 0};
//+
Rectangle(5) = {0.043, 0, 0, 0.014, 0.001, 0};
//+
Rectangle(6) = {0.04, 0, 0, 0.02, 0.002, 0};
//+
BooleanFragments {Surface{1,2,3,4,5,6};Delete;}{}
//+
Transfinite Curve {29,26} = 250 Using Progression 1;
//+
Transfinite Curve {27,25} = 10 Using Progression 1;
//+
Transfinite Curve {28,24} = 10 Using Progression 1;
//+
Transfinite Curve {22,20} = 10 Using Progression 1;
//+
Transfinite Curve {21} = 150 Using Progression 1;
//+
Transfinite Curve {17,15} = 10 Using Progression 1;
//+
Transfinite Curve {10,23} = 10 Using Progression 1;
//+
Transfinite Curve {16} = 100 Using Progression 1;
//+
Transfinite Curve {10,12} = 10 Using Progression 1;
//+
Transfinite Curve {18,14} = 10 Using Progression 1;
//+
Transfinite Curve {11} = 100 Using Progression 1;
//+
Transfinite Curve {9,13} = 10 Using Progression 1;
//+
Transfinite Curve {4,6} = 10 Using Progression 1;
//+
Transfinite Curve {5} = 100 Using Progression 1;
//+
Transfinite Curve {3} = 20 Using Progression 0.9;
//+
Transfinite Curve {7} = 20 Using Progression 1.1;
//+
Transfinite Curve {1,2,8} = 20 Using Progression 1;
//+
Physical Curve("Copper_top") = {29};
//+
Physical Surface("Solution") = {2,3,4,5,6,7};