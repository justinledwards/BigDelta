// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;
//use <light_ring_mount.scad>;

effector_offset = 37;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
effector_height = 11;
effector_arm_width = 15;
effector_arm_depth = 3;
effector_arm_bore = m3_bolt;

arm_separation = global_delta_arm_seperation-effector_arm_width;  // delta arm seperation
effector_bore_radius = global_effector_bore_radius;
mounting_hole_radius = global_mounting_hole_radius;


module effector() {
difference() {
// Main Body
	intersection() {	
		union() {
			minkowski() {
				cylinder(r=effector_offset-effector_arm_depth, h=1, center=true, $fn=6);
				sphere(effector_height/2, $fn=8);
			}
// Arms
			for (a = [60:120:360]) rotate([0, 0, a]) {
				for (s = [-1, 1]) scale([s, 1, 1]) {
					translate([arm_separation/2, effector_offset, 0]) rotate([90, 22.5, 90])
					 cylinder(r=effector_height/2+0.5, h=effector_arm_width, center=true, $fn=8);
					translate([arm_separation/2, effector_offset/2, 0])
					 cube([effector_arm_width, effector_offset, effector_height], center=true);
				}
			}
		}

// Plane down the height
	cube([300, 300, effector_height], center=true);	
	}

// Horizontal Arm Bore
#	for (a = [60:120:360]) rotate([0, 0, a]) {
		translate([0, effector_offset, 0]) rotate([0, 90, 0])
		 cylinder(r=effector_arm_bore/2, h=arm_separation+2*effector_arm_width, center=true, $fn=15);
	}

// Angled Arm Bores
*		for (a = [60:120:360]) rotate([0, 0, a]) {
			for (s = [-1, 1]) scale([s, 1, 1]) {
			translate([arm_separation/2, 22, -15]) rotate([-45, 0, 0])
			 cap_bolt(effector_arm_bore, 30);
			}		
		}

// Angled Nut channels
*		for (a = [60:120:360]) rotate([0, 0, a]) {
			for (a = [-1, 1]) scale([a, 1, 1]) {
			 translate([arm_separation/2, 36, -1]) rotate([-45, 0, 0])
				hull() {	
					for (h = [-1,1]) {
						translate([0, 10*h-9.5, 0]) rotate([0, 0, 30])
						 flat_nut_boolean(effector_arm_bore);
					}
				}
			}
		}

// Central Hole
	 cylinder(r=effector_bore_radius, h=effector_height*2, center=true, $fn=90);

// Hot End Mounting Holes
	for (a = [0:30:360]) rotate([0, 0, a]) {
		translate([0, mounting_hole_radius, 10]) rotate([0, 180, 0])
		 cap_bolt_boolean(m3_bolt_boolean, 20);
	 }

}

// Add the Light Ring Mount
	translate([0, 0, -effector_height/2-0.5]) rotate([0, 0, 0])	
	 light_mount();

}

// Primary placement
translate([0, 0, 0]) rotate([0, 0, 0])
 effector();


// reference/measure
*#	translate([0, 0, 0]) rotate([0, 0, 0])
	 cylinder(r=effector_offset, h=effector_height*2, center=true, $fn=30);

*#	translate([0, 0, 0]) rotate([0, 0, 0])
	 cube([arm_separation+effector_arm_width, effector_offset*2, effector_height*2], center=true);
