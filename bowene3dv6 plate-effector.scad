fudge = 0.2;
plate_width = 58;
plate_depth = 28;
plate_height = 6;
top_diameter = 16;
grovemount_diameter = 12;
mount_hole_width = 54;
mount_hole_dia = 3;
translate([15,10,3])
rotate([90,180,0])

good_holder();


difference(){
//import("bowden_v1.4_E3D_V6.stl");
//mount_holes();

}

module cap_bolt_boolean(dia,len,fn=8)
{
	e=1.87*dia;
	h1=2*dia;
	cylinder(r=dia/2,h=len,$fn=fn);
	translate([0,0,-h1+0.05]) cylinder(r2=e/2+0.15,r1=e/2+0.3,h=h1,$fn=fn);
}

module main_plate()
{
  cube([plate_width-fudge,plate_depth-fudge,plate_height-fudge], center=true);
}

module mount_holes()
{
for (a = [0:30:360]) rotate([0, 0, a]) {
		translate([0, 27, 10]) rotate([0, 180, 0])
		 cap_bolt_boolean(3, 20);
	 }  


//translate([mount_hole_width/2,0,0])
//   cylinder(d=mount_hole_dia+fudge, h=plate_height+100, center=true);
//  translate([mount_hole_width/-2,0,0])
//   cylinder(d=mount_hole_dia+fudge, h=plate_height+100, center=true);
}
module grove_mount()
{
cylinder(d=grovemount_diameter+fudge, h=plate_height+1, center=true);
translate([0,plate_depth/2-grovemount_diameter/2,0])
cube([grovemount_diameter+fudge,plate_depth/2+1,plate_height+1], center=true);

}


module good_holder()
{
difference(){
union(){
translate([0,0,(plate_height/2)-(fudge/2)+3.5])
cylinder(d=top_diameter+3,h=7, center=true);
translate([0,0,11.2])
cube([plate_width-fudge,plate_depth-fudge,3], center=true);
}
mount_holes();

translate([0,0,4.4])
cylinder(d=top_diameter,h=3, center=true);
translate([0,0,(plate_height/2)-(fudge/2)+2])
cylinder(d=10,h=50, center=true);

}
}






*difference(){
main_plate();
mount_holes();
grove_mount();
};


