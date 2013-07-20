// Crowned Pulley
// John Rood, 2012-11-18
// inspired by http://www.thingiverse.com/thing:14117 by DaleDunn

$fn = 100;

// 608
crownRadius = 13.6;
pulleyHeight = 9;
bearingSize = 22;
bearingClearing = 0.1; // 22.6mm inside diameter
innerHole = 9.15;

// 605
// pulleyHeight = 5+2;
// bearingSize = 14;
// bearingClearing = 0.1;
// innerHole = bearingSize/2-1.5;
// crownRadius = bearingSize/2+2;

function pulley_width() = pulleyHeight;
function pulley_diameter() = crownRadius*2;

echo(str("pulley_diameter=", crownRadius*2));
module crowned_pulley() {
	difference() {
	    intersection() {
	        cylinder(r = crownRadius, h = pulleyHeight);
	        translate([0, 0, pulleyHeight / 2]) sphere(r=crownRadius);
	    }
	    translate([0, 0, 1])
	        cylinder(r = (bearingSize + bearingClearing) / 2, h = pulleyHeight);
	    translate([0, 0, -1])
	        cylinder(r = innerHole, h = pulleyHeight + 2);
	}
}

crowned_pulley();