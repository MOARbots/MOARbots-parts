
r = 45/2; //overall wheel diam, not including the bead protrusions
cutoff = 10; //how much to cut off each bead end
border = 3; //how much of a border arm around the steel wire channel
armthickness = 3; //how thick the arms are
beadclear = .5; //how much clearance between bead and arm
r_wire = (1.96 + 1)/2; //steel wire diam and 3d printing error allowance
extra = (r_wire/sqrt(2))*.1; //a way to close the channel for the wire just a little bit more
centeroffset = 1 ; //how much to pull in the central hub to avoid hitting the beads
wheelclearance = 2.1; //how much of a gap to allow between wheel and second wheel or body frame
fitdepth = 4;//depth of the fitted shape that allows you to glue two of these together
shapeoffset = 1;//offset from central hub of radius into which fitted shape will go
printoffset = 0.25; // for the printing hole closure expected on teh other piece

$fn = 50;


module beadshape() {
	difference() {
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
	polygon([[-r,-armthickness/2-beadclear],[-r,armthickness/2+beadclear],[r,armthickness/2+beadclear],[r,-armthickness/2-beadclear]]);
	}
}

module bead() {
	difference() {
		rotate_extrude(){ beadshape();	}
		linear_extrude(height=sqrt(2)*r,center=true) { circle(r_wire);}
	}
}


module beads() {
	translate([r/2,r/2,0]) { rotate([45,90,0]){ bead(); } }
	translate([-r/2,r/2,0]) { rotate([-45,90,0]){ bead(); } }
	translate([-r/2,-r/2,0]) { rotate([45,90,0]){ bead(); } }
	translate([r/2,-r/2,0]) { rotate([-45,90,0]){ bead(); } }
}

module channelshape() {
	union() {
		circle(r_wire);
				polygon([[-r_wire/sqrt(2)+extra,(r_wire+border)],[r_wire/sqrt(2)-extra,(r_wire+border)],[r_wire/sqrt(2)-extra,0],[-r_wire/sqrt(2)+extra,0]]);}
}

module armshape(){
	difference() {
		union() {
			polygon([[0,-(r_wire+border)],[-sqrt(2)*(r/2),-(r_wire+border)],[-sqrt(2)*r/2,(r_wire+border)],[0,(r_wire+border)]]);
			circle(r_wire+border);
		}
		channelshape();
	}
}

module arm() {
	linear_extrude(height=armthickness, center=true) { armshape(); }
}

module arms() {
	rotate([0,0,45]) {
		translate([sqrt(2)*(r/2),0,0]) { rotate([90,0,0]) { arm();} }
		translate([0,sqrt(2)*(r/2),0]) { rotate([90,0,90]) { arm();} }
		translate([-sqrt(2)*(r/2),0,0]) { rotate([90,0,180]) { arm();} }
		translate([0,-sqrt(2)*(r/2),0]) { rotate([90,0,-90]) { arm();} }
	}
}


module hub_pos() {
	translate([0,0,-(r_wire+border)]) {	
		linear_extrude(height=((2-sqrt(2))*r)-(r_wire+border)/2 + wheelclearance-fitdepth,center=false) {circle(sqrt(2)*r-r-centeroffset); }
	}
	my_r = sqrt(2)*r-r-centeroffset-shapeoffset-printoffset;
	rotate([0,0,45]){
		translate([0,0,-(r_wire+border)+((2-sqrt(2))*r)-(r_wire+border)/2 + wheelclearance-fitdepth]) {
			linear_extrude(height=fitdepth, center=false) {
				polygon([[0,my_r],[-sqrt(3)*my_r/2,-my_r/2],[sqrt(3)*my_r/2,-my_r/2]]);
			}
		}
	}
}

module d_channel () {
	r_shaft = 3;
	difference() {
		circle(3/2);
		polygon([[-1,r_shaft],[-1,-r_shaft],[-r_shaft,-r_shaft],[-r_shaft,r_shaft]]);
	}
}

module hub_neg() {
	my_r = sqrt(2)*r-r-centeroffset-shapeoffset;
		difference() {
			translate([0,0,-(r_wire+border)]) {	
				linear_extrude(height=((2-sqrt(2))*r)-(r_wire+border)/2 + wheelclearance, center=false) {circle(sqrt(2)*r-r-centeroffset); }
			}
			translate([0,0,-(r_wire+border)+((2-sqrt(2))*r)-(r_wire+border)/2 + wheelclearance-fitdepth]) {
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
hub_pos();

}

module halfbead(){
	difference() {
		bead();
		translate([0,0,-5*r]) {linear_extrude(height=10*r,center=true) {circle(r);}}
	}
}


frame1();
translate([0,0,-(r_wire+border)+((2-sqrt(2))*r)-(r_wire+border)/2 + wheelclearance+fitdepth]) {
rotate([180,0,0]){
frame2();}}

beads();
translate([0,0,-(r_wire+border)+((2-sqrt(2))*r)-(r_wire+border)/2 + wheelclearance+fitdepth]) {
rotate([0,0,45]){
beads();}}
//halfbead();
