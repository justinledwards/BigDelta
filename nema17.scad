include <configuration.scad>;

// NEMA17 stepper motor

module stepper_motor(length=47.5, shaft_radius=5.00/2) {
   intersection() {
      cube([42.2, length, 42.2], center=true);
      rotate([90, 0, 0])
      cylinder(r=25.5, h=length+1, center=true);
   }
   translate([0, -length/2, 0]) {
// drive shaft
		rotate([90, 0, 0]) {
		 cylinder(r1=11, r2=11, h=2, $fn=40);
		 cylinder(r=shaft_radius, h=25);
		}
// mounting bolts
      for (a = [0:90:360]) rotate([0, a, 0]) {
         translate([15.5, 0, 15.5]) rotate([90, 0, 0])
         cylinder(r=m3_major_radius, h=10,  $fn=30);
      }
   }
}

module stepper_motor_boolean(length=47.5, shaft_radius=7.00/2) {
   intersection() {
      cube([42.2, length, 42.2], center=true);
      rotate([90, 0, 0])
      cylinder(r=25.5, h=length+1, center=true);
   }
   translate([0, -length/2, 0]) {
// drive shaft
		rotate([90, 0, 0]) {
		 cylinder(r1=12+extra_boolean, r2=11+extra_boolean, h=2, $fn=40);
		 cylinder(r=shaft_radius, h=25, $fn=8);
		}
// mounting bolts
      for (a = [0:90:360]) rotate([0, a, 0]) {
         translate([15.5, 0, 15.5]) rotate([90, 0, 0])
         cylinder(r=m3_major_radius+extra_radius, h=10,  $fn=8);
      }
   }
}

//# stepper_motor();
# stepper_motor_boolean();