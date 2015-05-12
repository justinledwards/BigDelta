// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;
use <effector.scad>;

effector_height = 11;
effector_bore = global_effector_bore_radius+1;
mounting_hole_radius = global_mounting_hole_radius;

/*************************************************************************/

// Light Ring
module light_ring(){
difference () {
	translate([0, 0, 0]) rotate([0, 0, 0]) 
	 cylinder(r=60/2, h=1.8, center=true, $fn=90);
	translate([0, 0, 0]) rotate([0, 0, 0]) 
	 cylinder(r=44/2, h=10, center=true, $fn=90);		
	}
}


// Light Ring Mount
module light_mount(){
	difference () {
		union() {
			translate([0, 0, 0]) rotate([0, 0, 0]) 
			 cylinder(r=64/2, h=8, center=true, $fn=90);
		}

// Center Bore
	translate([0, 0, 0]) rotate([0, 0, 0]) 
	 cylinder(r=effector_bore, h=10, center=true, $fn=90);		
	translate([0, 0, -6]) rotate([0, 0, 0]) 
	 cylinder(r=59/2, h=10, center=true, $fn=90);

// Light Ring
	translate([0, 0, -2]) rotate([0, 0, 0]) 
	 cylinder(r=61/2, h=2.2, center=true, $fn=90);

// Wedge Cuts
		for (a = [30:120:360]) rotate([0, 0, a]) {
			translate([30, 0, -8.5]) rotate([0, 0, 60]) 
			 cylinder(r=90/2, h=10, center=false, $fn=3);		
		}

// Bolt holes
		for (a = [0:30:360]) rotate([0, 0, a]) {
			translate([mounting_hole_radius, 0, 25]) rotate([0, 180, 0]) 
			 cap_bolt_boolean(m3_bolt_boolean, 50);
		}

// Nut holes
		for (a = [0:30:360]) rotate([0, 0, a]) {
			translate([mounting_hole_radius, 0, 1.5]) rotate([0, 180, 0]) 
			 flat_nut_boolean(m3_bolt_boolean);
		}
	}
}



// Primary Placement
	translate([0, 0, -effector_height/2-4.5]) rotate([0, 0, 0])	
	 light_mount();


//  Reference objects
*%union () {
// Effector
	translate([0, 0, 0]) rotate([0, 0, 0]) 
	 effector();

// Light Ring
	translate([0, 0, -effector_height/2-6.5]) rotate([0, 0, 0])  color ("white")
	 light_ring();
}
