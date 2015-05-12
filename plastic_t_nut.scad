// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;

size = 3;

module t_nut(size=size) { rotate([180,0,0]) 
	difference() {
	 translate([-6, -7.5, 0]) rotate([270,0,0])
		 linear_extrude(height=15)
		 polygon([ [0.5,0], [11.5, 0], [11.5, 0.9], [9.0, 3.8], [3, 3.8], [0.5, 0.9] ]);

#	translate([0, 0, 10]) rotate([180, 0, 30])
	 cap_bolt_boolean(size+.3, 20);

#	translate([0, 0, -size*1.28]) rotate([0, 0, 30])
	 flat_nut(size);

	}

}



// Primary Placement
translate([0, 0, 0]) rotate([0, 0, 0])
 t_nut();


module beam(length=40) {
	linear_extrude(length)
	 polygon([ [-4.5, 0], [-2.7, -1.9], [-5.5,-1.9], [-5.5, -2.8], [-3, -5.7], [3, -5.7], [5.5, -2.8], [5.5,-1.9], [2.7, -1.9], [4.5, 0], [2.7, 1.9], [5.5, 1.9], [5.5, 2.8], [3, 5.7], [-3, 5.7], [-5.5, 2.8], [-5.5,1.9], [-2.7, 1.9] ]);
}

