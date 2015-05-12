


// Misumi Beam
module misumibeam(size1=15, size2=15, length=100, extra=0.1) {
   difference() {
      cube([size1+extra, size2+extra, length], center=true);
      for (a = [0:180:180]) rotate([0, 0, a]) {
         translate([size1/2, 0, 0]) {
          //  % cube([size1/2, 3, length+1], center=true);
			minkowski() {
               cube([size1/2-(extra+1), size1/6-extra, length+1], center=true);
               cylinder(r=0.5, h=1, center=true);
			} 
        }
      }
      for (a = [0:90:270]) rotate([0, 0, a]) {
         translate([size2/2, 0, 0]) {
          //  % cube([size1/2, 3, length+1], center=true);
			minkowski() {
               cube([size1/2-(extra+1), size1/6-extra, length+1], center=true);
               cylinder(r=0.5, h=1, center=true);
			} 
        }
      }
   }
}

# misumibeam(15, 15, 300);


