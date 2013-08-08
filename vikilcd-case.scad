l= 154;
w= 73;
d= 25;
inset= 7;
sep= 53;

holepos= [
	[-l/2+(inset/2), sep/2, d/2-1],
	[-l/2+(inset/2), -sep/2, d/2-1],
	[l/2-(inset/2), sep/2, d/2-1],
	[l/2-(inset/2), -sep/2, d/2-1] ];

//%translate([-64.5,-22.5,-6]) lcd();
case();

module lcd() {
	import("vikilcd.stl");
}

// generate a negative fillet for an edge
module fillet(pos= [0,0,0], radius=3, height=100, fn=16, angle= 0) {                                     
   translate(pos) rotate([0,0,a]) translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=fn);
        }
}

module case() {
	t= 0.5*4*2;
	rad= 3;

	difference() {
		union() {
			difference() {
				cube([l, w, d], center= true);
				translate([0,0,0.25*3]) cube([l-t, w-t, d], center= true);
				#translate([0,w/2+2,-d/2+8]) rotate([90,0,0]) cylinder(r=5, h=6, $fn=6);
			}
			translate([-l/2,-w/2,d/2-4]) cube([7, w, 4]);
			translate([l/2-7,-w/2,d/2-4]) cube([7, w, 4]);
			// posts
			for(p= holepos) {
				translate(p-[0,0,d-1.1]) cylinder(r=3.5, h=d-1);
			}
			// corners
			for(p= [ [l/2-4,w/2-4, 0], [-l/2+4,w/2-4,0], [-l/2+4,-w/2+4,0], [l/2-4,-w/2+4,0] ]) {
				translate(p+[0,0,-d/2]) cylinder(r=3, h=d);
			}
			// base edges
			#translate([-l/2+1,-w/2+3,-d/2+2]) rotate([0,90,0]) cylinder(r=2, h=l-2);
			#translate([-l/2+1,w/2-3,-d/2+2]) rotate([0,90,0]) cylinder(r=2, h=l-2);
						
		}
		// mounting holes
		for(p= holepos) {
			#translate(p-[0,0,3]) cylinder(r=rad/2, h=5);
		}
		
		fillet(pos=[l/2,w/2,0], a= 0, radius=3, height= d+0.1);
		fillet(pos=[-l/2,w/2,0], a= 90, radius=3, height= d+0.1);
		fillet(pos=[l/2,-w/2,0], a= -90, radius=3, height= d+0.1);
		fillet(pos=[-l/2,-w/2,0], a= 180, radius=3, height= d+0.1);
	}
}

module mesh(gridX, gridY, meshSolid=1.0, meshSpace=10.0, thickness= 0.4) {
	borderX= 0;
	borderY= 0;
	meshX=gridX-(borderX*2);
	meshY=gridY-(borderY*2);
	nX=meshX/(meshSolid+meshSpace);
	nY=meshY/(meshSolid+meshSpace);
		
	for (i=[0:nX]) {
		 	 translate([-(meshX/2)+i*(meshSolid+meshSpace),-meshY/2,-thickness/2]) cube(size=[meshSolid,meshY,thickness],center=false);
	}
	
	for (i=[0:nY]) {
		 	translate([-meshX/2,-(meshY/2)+i*(meshSolid+meshSpace),-thickness/2]) cube(size=[meshX,meshSolid,thickness],center=false);

	}
}
