wheeldiam = 32; //overall wheel diam, not including the bead protrusions
radius = (1.55 + 1)/2; //steel wire diam 14 gauge (misc stuff was 1.55+2) and 3d printing error allowance
thickness = 5; //thickness of the wheel, larger than steelwirediam by enough
pedestal = 3; //pedestal for the gear
inset = 3; //how far the center of the channel should be moved in from the wheel edge
numbeads = 4; //how many beads
extra = (radius/sqrt(2))*.1; //a way to close the channel for the wire just a little bit more

beaddiam =6;//outer diameter of the bead at widest point
beadwidth = 6; // width of a bead
clr_d = 3; //clearance to add to the length of the cutout (along diameter of bead)
clr_w = .75; //clearance to add to the width of the cutout (along width of bead)

include <parametric_involute_gear_v5.0.scad>;

module beadprofile() {
	r=wheeldiam/2-inset+beaddiam/2;
	intersection() {
		union() {
			translate([-r+beaddiam/2,0,0]) {
				difference() {
					circle(r); //outer diameter of the bead defined circle
					polygon([[r-beaddiam/2,r],[r-beaddiam/2,-r],[-r,-r],[-r,r]]);
					}
				}
			}
	polygon([[-beaddiam/2,beadwidth/2],[beaddiam/2,beadwidth/2],[beaddiam/2,-beadwidth/2],[-beaddiam/2,-beadwidth/2]]);
	}
}

module bead() {
translate([wheeldiam/2-inset,0,thickness/2]) {
	rotate([90,0,0]) {
		difference() {	
			rotate_extrude() {	beadprofile();	}
			linear_extrude(height=beadwidth, center=true){	circle(radius);}	
		}
	}
}
}

//use extra to refine the channel
//improve $fn before final render

$fn = 100;

module cutout () {
	translate([wheeldiam/2-inset,0,0]) {
	linear_extrude(height=thickness+1) {
	rotate([0,0,90]) {polygon([[(beadwidth/2+clr_w/2),(beaddiam/2+clr_d/2)],[-(beadwidth/2+clr_w/2),(beaddiam/2+clr_d/2)],[-(beadwidth/2+clr_w/2),-(beaddiam/2+clr_d/2)],[(beadwidth/2+clr_w/2),-(beaddiam/2+clr_d/2)]]); }
}
}
}

module cutouts() {
	for(i=[0:numbeads-1]) {rotate([0,0,i*360/numbeads]) {cutout();}}

}


module mainwheel() {
	linear_extrude (height=thickness) {
		circle(wheeldiam/2);
	}
}


module channel () {
	rotate_extrude(){
		translate([wheeldiam/2-inset,0,0]) {
				union() {
				circle(radius);
				polygon([[-radius/sqrt(2)+extra,thickness],[radius/sqrt(2)-extra,thickness],[radius/sqrt(2)-extra,0],[-radius/sqrt(2)+extra,0]]);}
		}
	}
}

module wheel() {
	difference() {
	difference () {
		mainwheel();
		translate([0,0,thickness/2]) {channel();}
	}
	cutouts();
}
}

difference() {
	union() {
	translate([0,0,thickness]) { linear_extrude(height=pedestal){circle(wheeldiam/2-inset-beaddiam/2-clr_d/2);}}
	translate([0,0,thickness + pedestal]) { gear (
		number_of_teeth=27,
		circular_pitch=254, diametral_pitch=false,
		pressure_angle=20,
		clearance = 0.2,
		gear_thickness=7,
		rim_thickness=7,
		rim_width=0,
		hub_thickness=7,
		hub_diameter=0,
		bore_diameter=0,
		circles=0,
		backlash=0,
		twist=0,
		involute_facets=0);}
		wheel();
	}
linear_extrude(height=100) { circle(3.4/2);}
}


for (i=[0:numbeads-1]) {
rotate([0,0,i*360/numbeads]) {bead();}
}

//rotate([90,0,0]) {translate([-wheeldiam/2+inset,thickness/2,-thickness/2]) {bead();}}