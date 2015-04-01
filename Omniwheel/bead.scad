/* Bead module for omniwheel by Shira Epstein
 * This work is licensed under the Creative Commons Attribution 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
 */

//Code

//Create the 2D shape of the bead
module beadshape( bead_length, w_rad ) {
	intersection() {
		polygon([[0,-(bead_length/2)],[w_rad,-(bead_length/2)],[w_rad,(bead_length/2)],[0,(bead_length/2)]]);
		rotate([0,0,-45]) {	
			translate([-w_rad/2,-w_rad/2,0]){
				difference() {
					circle(w_rad);
					polygon([[-w_rad,-w_rad],[w_rad,-w_rad],[w_rad,0],[0,w_rad],[-w_rad,w_rad]]);
				}
			}
		}
	}
}

//Create the 3d shape of the bead
module bead( bead_length, w_rad, central_hole_rad) {
	difference() {
		rotate_extrude(){ beadshape( bead_length, w_rad );	}
		linear_extrude(height=sqrt(2)*w_rad,center=true) { circle(central_hole_rad);}
	}
}

//Show 4 beads arranged along the wheel
module beads() {
	translate([ w_r/2,	 w_r/2,	0])	{ rotate([ 45,90,0])	{ bead(); } }
	translate([-w_r/2,	 w_r/2,	0]) 	{ rotate([-45,90,0])	{ bead(); } }
	translate([-w_r/2,	-w_r/2,	0])	{ rotate([ 45,90,0])	{ bead(); } }
	translate([ w_r/2, -w_r/2,	0])	{ rotate([-45,90,0])	{ bead(); } }
}
