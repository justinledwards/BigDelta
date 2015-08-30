// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;


height = 41;
thickness = 5;
motor_offset = 48.7;
triangle_side = 316;
printer_height = 680;
delta_radius = 212.4;

module slot_fill(length = 20) {
	difference() {
		translate([0, 0, 0]) rotate([0, 0, 0])
		 cylinder(r=4.5, h=length, center=true,  $fn=4);	

//plane sides
		translate([-3.8, 0, 0]) rotate([0, 0, 0])
		 cube([4, 20, length*2], center=true);
		translate([3, 0, 0]) rotate([0, 0, 0])
		 cube([6, 20, length*2], center=true);
	}
}


module vertex() {
	union() {
		difference() {
			union() {



				intersection(){
					translate([-27.5,-15.2,20.5])
						cube([55,30.5,40]);
				}
// Corner Section
				intersection() {
					minkowski() {
						translate([0, 40, 0]) rotate([0, 0, 0])
						 cylinder(r=63-thickness, h=height-1, center=true, $fn=6);					
						cylinder(r=thickness, h=1, center=true, $fn=60);
					}
					translate([0, -20, 0]) rotate([0, 0, 30])
					 cylinder(r=50, h=height+1, center=true, $fn=6);
 				}

// A Frame
				intersection() { 
					translate([0, 40, 0]) rotate([0, 0, -90])
					 cylinder(r=70, h=height, center=true, $fn=3);
					translate([0, 35, 0]) rotate([0, 0, 30])
					 cylinder(r=64, h=height*2, center=true, $fn=6);
					translate([0, 35, 0])  rotate([0, 0, 0])
					 cube([200, 60, height*2], center=true);
				}

// Slot Fill
			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) scale([a, 1, 1]) {
				for (z = [-10, 10]) translate([-15, 53.75, z]) rotate([90, 0, 0]) {
					 slot_fill(60);
				}
			}

		}

//Upper A Frame Hole
			translate([0, 90, 0]) rotate([0, 0, 0]){
				minkowski() {
					intersection() {
						translate([0, 0, 0]) rotate([0, 0, -90])
						 cylinder(r=100, h=height, center=true, $fn=3);
						translate([0, -62, 0])  rotate([0, 0, 0])
						 cube([100, 16, height*2], center=true);
					}
				cylinder(r=thickness, h=1, center=true, $fn=60);
				}

//Lower A Frame Hole
				minkowski() {
					intersection() {
						translate([0, 0, 0]) rotate([0, 0, -90])
						 cylinder(r=100, h=height, center=true, $fn=3);
						translate([0, -28.5, 0]) rotate([0, 0, 0])
						 cube([150, 16, height*2], center=true);
					}
					cylinder(r=thickness, h=1, center=true, $fn=60);
				}
			}

// Misumi Beam Boolean 
			difference() {
				translate([0, 0, 330-height+5]) rotate([0, 0, 90])
				 cube([20.1+extra_boolean, 40.1+extra_boolean, 660],center=true);
//			 misumibeam(20, 40, 660, extra_boolean);
			
// 			front slot fill
			for (a = [-1, 1])
			 translate([-10*a, -(20.1+extra_boolean)/2, 0]) rotate([0, 0, -90]) {
			  slot_fill(height+80);
				}
			}

// Steel Rod Boolean 
			for (m = [1, -1]) scale([1, 1, m]) {
				for (a = [-1, 1]) translate([26*a, 8, height/2-15]) rotate([0, 0, 0]) {
*					translate([0, 0, 0]) rotate([0, 0, 0])
					 cylinder(r=3.99+extra_boolean, h=height*2, $fn=30);
				
					translate([0, 0, 20]) rotate([0, 180, 0])
						 cap_bolt_boolean(m3_bolt_boolean, 35);
				}
			}

// M3 Nut channels
			for (a = [-1, 1]) translate([26*a, 8, -1.24]) rotate([0, 0, 150*a]) {
				hull() {	
					for (h = [-1,1]) {
						translate([0, 10*h-9.5, 0]) rotate([0, 0, 30])
						 flat_nut_boolean(m3_bolt_boolean);
					}
				}
			}

//micro switch bore
	for (m = [1, -1]) scale([1, 1, m]) {
	    translate([0, 17, 21]) rotate([0, 0, 0])
		 cube([31, 7, 15], center=true);
		for (m = [1, -1]) {
			translate([10*m, 17, 16]) rotate([90, 0, 0])
			 cap_bolt_boolean(m3_major_radius*2, 10);
		}
	}

// Stepper Motor
			translate([0, motor_offset + motor_length/2, 0]) rotate([0, 0, 0])
			 stepper_motor_boolean();

// Bearing Boolean
			translate([0, 27.5, 0]) rotate([90, 0, 0])
			 cylinder(r=8, h=40, center=true, $fn=60);

// Beam Screw Sockets 
			for (a = [-1, 1]) translate([0, 0, 0]) rotate([180, 0, 30*a]) {
			 for (z = [-10, 10]) translate([-25.1*a, 0.5, z]) rotate([90, 0, 0]) {
			  cap_bolt_boolean(m5_bolt_boolean, 40);
			 }
			}

// Side Screw Sockets
			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) {
				for (z = [-10, 10]) translate([-16.5*a, 111, z]) rotate([0, 0, 0]) {
					for (y = [-76, -39]) {
						translate([a*7, y, 0]) rotate([0, a*90, 180])
						 cap_bolt_boolean(m5_bolt_boolean, 10);
			         }
				}
			}

// Corner Screw Sockets
			for (z = [-1, 1]) scale([1, 1, z]) {
				for (a = [-1, 1]) translate([10*a, -16, 0]) rotate([90, 0, 180]) {
				 cap_bolt_boolean(m5_bolt_boolean, 10);
				}
 			}
			for (z = [-1, 1]) scale([1, 1, z]) {
				for (a = [-1, 1]) translate([10*a, -16, 40]) rotate([90, 0, 180]) {
				 cap_bolt_boolean(m5_bolt_boolean, 10);
				}
 			}

// Wire runs 
			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) {
				translate([1*a, 30, 0]) rotate([90, 30, 0])
				 cylinder(r=5, h=60, center=true, $fn=30);
			}
			hull() {		
				for (a = [-1, 1]) {
					 translate([13/2*a, 15, 0]) rotate([90, 0, 0*a])
					 cylinder(r=5, h=40, center=true, $fn=30);
					}
				}
		}
	}


// Beam Supports 
*#			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) {
			 translate([-25.1*a, triangle_side/2+25.9, 0]) rotate([90, 0, 0])
			  misumibeam(20, 40, triangle_side, 0);
			}

// Fix overhang Pads 
	for (m = [1, -1]) translate([0, 0, 0]) scale([1, 1, m]) {
		for (a = [-1, 1]) translate([26*a, 8, height/2-19.25]) rotate([0, 0, 0]) {
			translate([0, 0, 0]) rotate([0, 0, 0])
			 cylinder(r=5, h=0.2, $fn=30);
		}
	}

}


// Primary Placement
translate([0, 0, height/2]) rotate([0, 0, 0])
 vertex();




// Full Setup
*	for (a = [0:120:360]) rotate([0, 0, a]) {
		translate([0, delta_radius, 0]) rotate([0, 0, 180])
		 vertex();
	}
//measure
*%union() {
*	translate([0, 0, 0]) rotate([0, 0, 0])
 	 cylinder(r=delta_radius, h=10, $fn=30, center=true);
// glass plate
	translate([0, 0, 30]) rotate([0, 0, 0])
 	 cylinder(r=350/2, h=10, $fn=90);
}