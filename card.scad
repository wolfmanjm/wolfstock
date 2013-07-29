include <Orbitron_Medium.scad>;                                                                    

w= 68/2;
l= 24/2;
h= 0.3;

module text() {
	// steps - the amount of detail, the higher the more detailed.                                     
	// center - whether the output is centered or not                                                  
	// extra - extra distance between characters                                                       
	// height - height of extrusion, 0 for 2d                                                          
	Orbitron_Medium("Wolfstock", steps=2, center=true, extra=10, height=5);
}

scale([1, 1, 1]) difference() {
	hull() {
		for(p= [[w,l,h], [-w,l,h], [-w,-l,h], [w,-l,h]]) {
			translate(p) cylinder(r=10, h=0.2, $fn=24);
		}
	}
   #translate([1, -4, 0]) scale([0.2, 0.2, 1]) text();
}
