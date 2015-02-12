width = 14;
thickness =25;
border = 2;
height = 40;
bottom = 2;

difference() {
	linear_extrude(height=bottom+height) {
		polygon([[0,0],[0,width+border],[thickness+border,width+border],[thickness+border,0]]);
	}

	translate([border/2,border/2,bottom]) {
		linear_extrude(height=height+1) {
			polygon([[0,0],[0,width],[thickness,width],[thickness,0]]);
		}
	}
}