/* Hub module for omniwheel by Shira Epstein
 * This work is licensed under the Creative Commons Attribution 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
 */

//Variables
hub_clearance = 1.5; //Clearance between the hub and the beads
wheelclearance = 2; //how much of a gap to allow between the two halves of the wheel
fitdepth = 4; //depth of the triangular key that allows a snap fit of the two halves of the omniwheel

printoffset = 0.25; // Pull the positive triangular key in by this much, to accomodate good fit w/negative
keyoffset = 1;//how far to pull in the corners of the triangular key from the edge of the hub center

r=30;


//Computed Variables
hub_center_r = sqrt(2)*r -r -hub_clearance; //Hub central radius
tri_r_n = hub_center_r - keyoffset; //Radius of circle into which triangular hole is inscribed
tri_r_p = tri_r_n - printoffset; //Radius of circle into which triangular key is inscribed

// - printoffset; //

//Central part of the hub
module hub_center(){
	linear_extrude(height=((2-sqrt(2))*r) + wheelclearance - fitdepth,center=false) {
		circle(hub_center_r);
	}
}

//The positive triangular key
module key_pos() {

	rotate([0,0,45]){
		translate([0,0,((2-sqrt(2))*r) + wheelclearance - fitdepth]) {
			linear_extrude(height=fitdepth, center=false) {
				polygon([[0,tri_r_p],[-sqrt(3)*tri_r_p/2,-tri_r_p/2],[sqrt(3)*tri_r_p/2,-tri_r_p/2]]);
			}
		}
	}
}

module hub_center_positive() {
	hub_center();
	key_pos();
}

hub_center_positive();