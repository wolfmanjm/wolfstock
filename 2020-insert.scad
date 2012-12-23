slotneckw= 6-0.2;
slotthick= 2+0.3;
slotdepth= 3.2+0.6-0.1;
slotwidth= 9.95+1.0;
shoulder=0.8;
edge= (slotwidth-slotneckw)/2;
diagl=3.6;

p1= [0,0];
p2= [slotwidth,0];
p3= [slotwidth,-shoulder];
p4= [slotwidth-edge,-slotdepth];
p5= [edge,-slotdepth];
p6= [0,-shoulder];
p7= [0,0];

module slider_body(width, height, thick) {
	union() {
		translate([-width/2,slotthick,0]) cube([width,thick,height]);
		translate([-slotneckw/2,0,0]) cube([slotneckw, slotthick, height]);
		translate([-slotwidth/2,0,0]) linear_extrude(height=height)
			polygon(points=[ p1,p2,p3,p4,p5,p6,p7 ]);
	}
}

module slider2020(w= 20, h= 20, t=2) {
	translate([0,-slotthick,0]) slider_body(w, h, t);
}

slider2020(w=10, h=10, t=2);