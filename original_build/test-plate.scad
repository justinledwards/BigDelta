// 4 wheel openbuild dual vwheel carriage for makerslide
// with arm holder integrated.

use <misumi-parts-library.scad>
use <dual-v-wheel.scad>
use <myLibs.scad>
use <makerslide.scad>
use <gt2-carriage.scad>
include <configuration.scad>;
use <myLibs.scad>
use <tensioner-gt2-F695zz.scad>

mm= 25.4;

//separation = 40;
ratio= 1.39;
separation = 37.2*ratio;
echo(str("Separation= ", separation));

horn_thickness = 20;
horn_x = 15;
horn_y = 0;
horn_offset = 8;
clamp_y= 20;

gt2_pulley_inner_dia= 12.25;
belt_thick= 1.7;
belt_width = 6;
belt_x_l = gt2_pulley_inner_dia/2 + belt_thick/2;
belt_x_r_upper = -belt_x_l + belt_thick + pulley_diameter();
belt_x_r_lower = belt_x_l + belt_thick/2;
belt_z = thickness+6;

// render it for model
//carriageModel();
carriage();

// the dimensions of the extrusion to run on
extrusion= 20;
extrusion_width= 40; // the side that the wheels run on
extrusion_height= 20;

// the thickness of the base
thickness = 10;

wheel_diameter = v_wheel_dia();
wheel_width= v_wheel_width();
wheel_id= v_wheel_id();
wheel_indent= v_wheel_indent();

wheel_penetration=0; // the amount the v wheel fits in the slot

bushing_ht= 0.25*mm;
bushing_dia= 8;
pillarht= 1; // the amount the bushing sticks out

rounding= 22;

// total length (height) of carriage
length= 40;

clearance= 1; // increase for more clearance, decrease for tighter fit
wheel_separation= extrusion_width+wheel_diameter+clearance-wheel_penetration*2; // separation of wheels for given extrusion
echo(str("wheel separation= ", wheel_separation));

wheel_distance= length; // wheel_separation;
echo("wheel distance= ", wheel_distance);

wheel_z= pillarht+wheel_width/2;
function get_wheel_z()= wheel_z;
echo(str("Wheel height= ", wheel_z));

wheelpos= [ [-wheel_distance/2, 0, 0], [wheel_distance/2, 0, 0], [-wheel_distance/2, wheel_separation, 0], [wheel_distance/2, wheel_separation, 0]];

function get_wheelpos(n) = [wheelpos[n][0], -wheel_diameter/2];


echo(str("belt height above extrusion face= ", thickness+wheel_z/2));

traxxas_clearance= 7;
min_belt_ht= 20;

module carriageModel() {
	translate([0, 0, 0]) plate_with_wheels();

	// show what we are riding on
	color("silver") translate([-20, 0, 0]) rotate([0,0,0]) makerslide(300);
}

module plate_with_wheels() {
	translate([wheel_z,0,0]) rotate([90,0,90]) carriage(0);

	// show V Wheels
	rotate([0,90,0]) for(p=wheelpos) translate(p + [0,-wheel_separation/2,0]) v_wheel();

	// show bushing
	rotate([0,90,0]) translate([0, 0, bushing_ht-pillarht])  for(p=wheelpos) translate(p + [0,-wheel_separation/2,0]) wheel_pillar();
}

module wheel_pillar(){
	cylinder(r=bushing_dia/2, h=bushing_ht);
}

module base() {
	r= rounding/2;
	translate([0,0,-thickness+0.05]) linear_extrude(height= thickness) hull() {
		translate(wheelpos[0]) circle(r= r);
		translate(wheelpos[1]) circle(r= r);
		translate(wheelpos[2]) circle(r= r);
		translate(wheelpos[3]) circle(r= r);
	}
}

module plate(print=1) {
	rotate([0,180,0]) plate_main();
}

module plate_main(print=1) {
	difference() {
		base();

		for(p=wheelpos) {
			// bushing holes
			translate(p + [0,0,-(bushing_ht-pillarht)]) hole(bushing_dia, bushing_ht);
			// M5 holes for wheels
			translate(p + [0,0,-50/2]) hole(5,50);
		}

		for(p= [wheelpos[2], wheelpos[3]]) {
			// slot for adjustable wheel
		   translate(p + [0,0,-50/2]) rotate([0,0,90]) slot(5,12,50);
			// slot for bushing
		   translate(p + [0,0,-(bushing_ht-pillarht)]) rotate([0,0,90]) slot(bushing_dia,15,bushing_ht);
		}

		// grub screw at bottom for adjusting tightness of bottom wheels
		for(p= [wheelpos[2], wheelpos[3]]) {
			translate(p+ [0,rounding/2+2,-thickness/2]) rotate([90,0,0]) hole(3,rounding/2);
			translate(p+ [0,14/2+1.0,-thickness/2]) rotate([90,30,0]) nutTrap(ffd=5.46,height=5);
			translate(p+ [0,14/2,0]) cube([5.46,3,thickness], center=true);
		}
	}
}

belt_clamp_radius= 4;
module belt_clamp() {
	ht= 15;
	rd= belt_clamp_radius;
	translate([-rd, 0, 0]) {
		cylinder(r=rd, h=ht, center=false);
		translate([0, 0, ht-0.05]) cylinder(r1=rd, r2=rd+2, h=3, center=false);
	}

}

%translate([separation/2, -8/2, thickness]) cube(size=[8, 8, 8], center=false);

module carriage(print=0) {
	// Timing belt (up and down).
	if (true) {
		%translate([-belt_x_l, 0, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
		%translate([belt_x_r_upper, 100/2, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
		%translate([belt_x_r_lower, -100/2, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
	}

	difference() {
		union() {
			// Plate
			translate([wheel_separation/2, 0, 0]) rotate([0, 180, 90]) {
				plate_main(print);
				// layers for bridging wheel slots
		   		for(p=wheelpos) {
		   			#translate(p-[0,0,(bushing_ht-pillarht)]) cube([bushing_dia+4,bushing_dia+8, 0.3], center= true);
				}
			}

			// Ball joint mount horns.
			for (x = [-1, 1]) {
				scale([x, 1, 1]) intersection() {
					translate([0, horn_y+1, horn_thickness/2+horn_offset]) cube([separation, 14, horn_thickness], center=true);
					translate([horn_x, horn_y, horn_thickness/2+horn_offset]) rotate([0, 90, 0]) cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
				}
			}

			translate([0, horn_y+1,thickness-0.5+5/2]) cube([separation-14, 14, 5], center=true);
			translate([belt_x_r_upper-belt_thick/2, clamp_y, thickness-0.05]) belt_clamp();
			translate([belt_x_r_lower-belt_thick/2, -clamp_y, thickness-0.05]) belt_clamp();
		}

		// screws for belt termination
		translate([belt_x_r_upper-belt_thick/2-belt_clamp_radius, clamp_y, 3.3]) hole(3, 30);
		translate([belt_x_r_lower-belt_thick/2-belt_clamp_radius, -clamp_y, 3.3]) hole(3, 30);
		// inset bolt heads on bottom
		translate([belt_x_r_upper-belt_thick/2-belt_clamp_radius, clamp_y, -0.1]) hole(6, 3);
		translate([belt_x_r_lower-belt_thick/2-belt_clamp_radius, -clamp_y, -0.1]) hole(6, 3);


		// Screws for ball joints.
		#translate([22, horn_y, horn_thickness/2+horn_offset]) rotate([0, 90, 0]) cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
		#translate([-22, horn_y, horn_thickness/2+horn_offset]) rotate([0, 90, 0]) cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);

		// Lock nuts for ball joints.
		for (x = [-1, 1]) {
			scale([x, 1, 1]) intersection() {
				translate([horn_x, horn_y, horn_thickness/2+horn_offset]) rotate([90, 0, -90])
				cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8,
					center=true, $fn=6);
			}
		}
	}
}