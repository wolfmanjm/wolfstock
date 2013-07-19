// Crowned Pulley
// John Rood, 2012-11-18
// inspired by http://www.thingiverse.com/thing:14117 by DaleDunn

$fn = 72;

crownRadius = 13.6;
pulleyHeight = 9;
bearingSize = 22;
bearingClearing = 0.6; // 22.6mm inside diameter
innerHole = 9.15;

function pulley_width() = pulleyHeight;
function pulley_diameter() = crownRadius*2;

module crowned_pulley() {
	difference() {
	    intersection() {
	        cylinder(r = crownRadius, h = pulleyHeight);
	        translate([0, 0, pulleyHeight / 2])
	            sphere(r=crownRadius);
	    }
	    translate([0, 0, 1])
	        cylinder(r = (bearingSize + bearingClearing) / 2, h = pulleyHeight);
	    translate([0, 0, -1])
	        cylinder(r = innerHole, h = pulleyHeight + 2);
	}
}
