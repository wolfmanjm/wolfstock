module makerslide(h=100) {
	linear_extrude(height=h, center=true, convexity = 10)
		import("makerslide/makerslide_extrusion_profile.dxf");
}

makerslide(50);
