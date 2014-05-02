// Limit Switch.scad
// GPLv2
// 2012-05-23 TakeItAndRun

// unit vectors
xaxis=[1,0,0];
yaxis=[0,1,0];
zaxis=[0,0,1];

//small number
e=0.02;

// make curves nice and round
$fn=30;

// all dimensions in mm

// switch
hsw=10;
xsw=6;
ysw=20;

//distance between holes and center
dysw=5;
rsw=2.5/2;
hhsw=3;
// switch point
hswp=14;
yswp=11;
// electric contacts
yswc=0.5;
xswc=3.2;
rswc=2/2;
hswc=3.75;
hhswc=-2;
// contact positions
dysw1=1;
dysw2=8;
dysw3=-8;
// limiter
rc=2/2;
dc=0.25;
xc=4;
yc=18;

Switch();
#%SwitchHoles();

// model a limiting switch
// The switch is shown in the position where it is just actueted.
// This limiting position is at y=yswp=11mm, z=hswp=14mm,
// relative to the center of the base ot the switch

module Switch(){
	color("DarkSlateGrey")
	difference(){
		translate(hsw/2*zaxis)cube([xsw,ysw,hsw],true);
		translate([0,dysw,hhsw])rotate(90,yaxis)cylinder(xsw+2*e,rsw,rsw,true);
		translate([0,-dysw,hhsw])rotate(90,yaxis)cylinder(xsw+2*e,rsw,rsw,true);
	}
	translate(dysw1*yaxis)Contact();
	translate(dysw2*yaxis)Contact();
	translate(dysw3*yaxis)Contact();
	translate([0,yswp,hswp])rotate(8,xaxis)Limiter();
}

module Contact(){
	color("yellow")
	difference(){
		translate((-hswc/2+1/2)*zaxis)cube([xswc,yswc,hswc+1],true);
		translate(hhswc*zaxis)rotate(90,xaxis)cylinder(yswc+2*e,rswc,rswc,true);
	}
}

// model the limiter, positioning the part to press at the center of origin
module Limiter(){
	color("yellow");
	translate(-rc*zaxis){
		rotate(-90,yaxis)Cut()
			difference(){
				cylinder(xc,rc,rc,true);
				cylinder(xc+2*e,rc-dc,rc-dc,true);
			}
		translate(-(yc/2+rc-dc/2)*yaxis)cube([xc,yc+dc,dc],true);
		translate(-(yc+rc-dc/2)*yaxis-xc/2*zaxis)cube([xc,dc,xc],true);
	}
}

// holes for mounting of the switch
module SwitchHoles(l=40){
		translate([0,dysw,hhsw])rotate(90,yaxis)cylinder(xsw+l+2*e,rsw,rsw,true);
		translate([0,-dysw,hhsw])rotate(90,yaxis)cylinder(xsw+l+2*e,rsw,rsw,true);
}

// cut whateverer follows at the plane x=0
// (used to cut the lower half of the round part of the limiter)
module Cut(){
	for(i=[0,$children-1])
		difference(convexity=8){
			child(i);
			translate(-100*xaxis)cube(200,true);
		}
}

