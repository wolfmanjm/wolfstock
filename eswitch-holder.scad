cow= 30;
col= 15;
coh= 24;
hd= 12.5;
w= 40+10;
o= col/2;
l= col+hd+col/2+5;
h= 3;
ht= 40;


module eswitch() {
	translate([-40/2, -30/2,0]) cube([40,30, 10]);
	translate([0,0,10]) cylinder(r=30/2, h=32);
	translate([0,0,32+10]) cylinder(r=40/2, h=3);
	translate([-cow/2, -30+col, -coh]) cube([cow, col, coh]);
}

module base() {
	difference() {
		cube([w, l, h], center=true);
		translate([0,o,0]) cube([cow, col, h], center= true);
		translate([0,-hd,0]) cylinder(r= 3/2+0.2, h= h, center=true, $fn=32);
	}
}

module negative_base() {
	difference() {
		cube([w-1, l-1, 10], center=true);
		base();
	}
}

module flange() {
	difference() {
		translate([-w/2, -h, 0]) cube([w, h, ht]);
		#translate([-10,0,ht/2-10]) rotate([90,0,0]) cylinder(r= 4/2+0.2, h= h+5, center=true, $fn=32);
		#translate([-10,0,ht/2+10]) rotate([90,0,0]) cylinder(r= 4/2+0.2, h= h+5, center=true, $fn=32);
		#translate([10,0,ht/2-10]) rotate([90,0,0]) cylinder(r= 4/2+0.2, h= h+5, center=true, $fn=32);
		#translate([10,0,ht/2+10]) rotate([90,0,0]) cylinder(r= 4/2+0.2, h= h+5, center=true, $fn=32);

	}
}

module side() {
	translate([0, 0, ht/2-h/2]){
		intersection() {
			cube(size=[h, l, ht], center=true);
			translate([0, -5, 0])  rotate([0, 90, 0]) cylinder(r=25, h=h*2, center=true);
		}
	}
}

module stand() {

	difference() {
		cylinder(r1=w, r2=w/2+8, h=ht);
		translate([0, 0, -h+0.1])  cylinder(r1=w-2, r2=w/2+8-2, h=ht);
		#translate([0, w-2, 0])  rotate([90, 0, 0])  cylinder(r=10/2, h=10, center=true);
	}

}

module holder() {
	union() {
		base();
		translate([0,-l/2,-h/2]) flange();
		translate([w/2-h/2, 0, 0])  side();
		translate([-w/2+h/2, 0, 0])  side();
	}
}

module holderstand() {
	difference() {
		translate([0,0,-ht+h/2-0.1]) stand();
		negative_base();
	}
}

//holder();
rotate([0, 180, 0])  holderstand();
//stand();
//negative_base();

%translate([0,0,0]) rotate([180,0,0]) eswitch();
