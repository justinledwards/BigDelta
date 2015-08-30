difference(){

translate([0,0,10])
union(){

cube([100,20,40]);
translate([10,0,0])
rotate([0,0,30])

cube([20,40,100]);
}

union(){
cube([100.01,20.01,40.01]);

rotate([0,0,30])
translate([0,0,0])
cube([20.01,40.01,180]);
}

translate([-10,20,0])
cube([40,40,140]);


translate([-12,-20,0])
rotate([0,0,30])
cube([30,30,170]);
}
