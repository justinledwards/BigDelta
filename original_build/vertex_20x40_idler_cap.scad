// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;


module idler_block(length=4, shaft_radius=5.00/2) {
difference() {	
	union() {
		intersection() {
			translate([0, 0, 0]) rotate([0, 0, 0])
			 cube([40, length, 40], center=true);
			translate([0, 0, 0]) rotate([90, 0, 0])
			 cylinder(r=27, h=length+1, center=true, $fn=20);
	  	}

	translate([0, -length/2, 0]) rotate([90, 0, 0])
	 cylinder(r1=12+extra_boolean, r2=11+extra_boolean, h=2, $fn=60);
	}

// idler shaft
	translate([0, 0, 0]) rotate([90, 0, 0])
	 cylinder(r=shaft_radius+0.5, h=50, center=true, $fn=30);

// Bearing shaft
	translate([0, -length/2, 0]) rotate([90, 0, 0])
	 cylinder(r=8, h=5, $fn=60);

// mounting bolts
	for (a = [0:90:360]) rotate([0, a, 0]) {
		translate([15.5, 15, 15.5]) rotate([90, 0, 0])
		 cylinder(r=m3_major_radius+extra_radius, h=30,  $fn=30);
	}

*	for (a = [-1, 1]) translate([0, -48.7, 0]) rotate([0, 0, 30*a]) {
		translate([1*a, 30, 0]) rotate([90, 30, 0])
		 cylinder(r=5, h=60, center=true, $fn=30);
	}
}
}

// Primary Placement
translate([0, 0, 0]) rotate([-90, 0, 0])
 idler_block();