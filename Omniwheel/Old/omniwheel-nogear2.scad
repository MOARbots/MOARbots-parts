
naildiam = 1.5; //1.85 - 1.92 diam finishing nails use 2.5 for beads/
naillength = 35; //nail length
nailhead = 1.5; //diam of the finishing nail's head
nailheadlength=1.5; //how long nailhead area is
holderborder = 1; //how much material on either side of the nail will hold it;
armheight = 6; //how tall arms are, at least bigger than nailhead+holderborder
armthickness = 1.0; //how thick the arms are
spacing = 1.2; // spacing between wheel and holder

//computations
side = naillength+nailhead/2; //length of the square inscribed in the omniwheel outer circlep  
r = side/(sqrt(2)); //overall wheel size is determined by nail length
holdersquare = nailhead+2*holderborder; //outside shape of the nail holding part
	f = 2; //pull in slightly to stay in circle

cutoff = 16; //how much to cut off each bead end
border = 3; //how much of a border arm around the steel wire channel
extra = nailhead/(2*sqrt(2))*.1; //a way to close the channel for the wire just a little bit more

centeroffset = 1.5 ; //how much to pull in the central hub to avoid hitting the beads
wheelclearance = 4; //how much of a gap to allow between wheel and second wheel or body frame
fitdepth = 4;//depth of the fitted shape that allows you to glue two of these together
shapeoffset = 1;//offset from central hub of radius into which fitted shape will go
printoffset = 0.25; // for the printing hole closure expected on teh other piece

$fn = 50;

module d_channel () {
	r_shaft = 3.6;//actually d_shaft, lol
	difference() {
		circle(r_shaft/2);
		polygon([[-1,r_shaft],[-1,-r_shaft],[-r_shaft,-r_shaft],[-r_shaft,r_shaft]]);
	}
}

module beadshape() {
		intersection() {
			polygon([[0,-(r-cutoff)],[r,-(r-cutoff)],[r,(r-cutoff)],[0,(r-cutoff)]]);
			rotate([0,0,-45]) {	
				translate([-r/2,-r/2,0]){
					difference() {
						circle(r);
						polygon([[-r,-r],[r,-r],[r,0],[0,r],[-r,r]]);//make this parametric for number beads
					}
				}
			}
		}
	}

module beadshapestretch() {
scale([1.2,1.05]) {beadshape();}
	}

module bead() {
	difference() {
		rotate_extrude(){ beadshape();	}
		linear_extrude(height=sqrt(2)*r,center=true) { circle(naildiam/2);}
	}
}

module beadnohole() {
		rotate_extrude(){ beadshapestretch();	}
}

module beads() {
	translate([r/2,r/2,0]) { rotate([45,90,0]){ bead(); } }
	translate([-r/2,r/2,0]) { rotate([-45,90,0]){ bead(); } }
	translate([-r/2,-r/2,0]) { rotate([45,90,0]){ bead(); } }
	translate([r/2,-r/2,0]) { rotate([-45,90,0]){ bead(); } }
}
module beadsnohole() {
	translate([r/2,r/2,0]) { rotate([45,90,0]){ beadnohole(); } }
	translate([-r/2,r/2,0]) { rotate([-45,90,0]){ beadnohole(); } }
	translate([-r/2,-r/2,0]) { rotate([45,90,0]){ beadnohole(); } }
	translate([r/2,-r/2,0]) { rotate([-45,90,0]){ beadnohole(); } }
}

module channel(){
	rotate ([0,90,45]) {
			rotate([0,0,90]){
				translate([0,0,nailheadlength]) {linear_extrude(height=20,center=true) {
					circle(nailhead/2);
					polygon([[-naildiam/(2*sqrt(2))+extra,20],[naildiam/(2*sqrt(2))-extra,20],[naildiam/(2*sqrt(2))-extra,0],[-naildiam/(2*sqrt(2))+extra,0]]);
			}
		}
	}
	rotate([90,-90,0]){
		translate([0,0,nailhead/2]){
			linear_extrude(height=nailheadlength+15,center=true) {
				circle(naildiam/2);
				polygon([[-naildiam/(2*sqrt(2))+extra,10],[naildiam/(2*sqrt(2))-extra,10],[naildiam/(2*sqrt(2))-extra,0],[-naildiam/(2*sqrt(2))+extra,0]]);
			}
		}
	}

	}
}

module hub_pos() {
		linear_extrude(height=((2-sqrt(2))*r)-armheight/2 + wheelclearance-fitdepth,center=false) {circle(sqrt(2)*r-r-centeroffset); }
	difference() {	
	linear_extrude(height=armheight,center=true){circle(r-f);}
	beadsnohole();
	}
	my_r = sqrt(2)*r-r-centeroffset-shapeoffset-printoffset;
	rotate([0,0,45]){
		translate([0,0,((2-sqrt(2))*r) + wheelclearance-fitdepth-armheight/2]) {
			linear_extrude(height=fitdepth, center=false) {
				polygon([[0,my_r],[-sqrt(3)*my_r/2,-my_r/2],[sqrt(3)*my_r/2,-my_r/2]]);
			}
		}
	}
}
hub_pos();
beads();

module hub_neg() {
	my_r = sqrt(2)*r-r-centeroffset-shapeoffset;
		difference() {
			translate([0,0,-armheight/2]) {	
				linear_extrude(height=((2-sqrt(2))*r) -armheight/2 + wheelclearance-fitdepth, center=false) {circle(sqrt(2)*r-r-centeroffset); }
			}
			translate([0,0,((2-sqrt(2))*r) + wheelclearance - fitdepth-armheight-fitdepth]) {
				linear_extrude(height=fitdepth+1, center=false) {
					polygon([[0,my_r],[-sqrt(3)*my_r/2,-my_r/2],[sqrt(3)*my_r/2,-my_r/2]]);
				}
			}
		}
}

module frame1 () {

	difference(){
		union(){
			arms();
			hub_neg();
		}
		linear_extrude(height = r*10,center=true) {d_channel();}
	}
}

module frame2() {
	arms();
	translate([0,0,-armheight/2]) { hub_pos(); }
}



//bead();
//frame1();
//arm(); //channel();

/*frame1();
translate([0,0,((2-sqrt(2))*r) + wheelclearance - armheight]) {
rotate([180,0,45]){
frame2();}}

beads();
translate([0,0,((2-sqrt(2))*r) + wheelclearance - armheight]) {
rotate([0,0,45]){
beads();}}
*/