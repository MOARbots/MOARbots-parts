include <parametric_involute_gear_v5.0.scad>;

$fn = 75;
gear_height = 4;
wheel_height = 6;
pedestal = 1.5;
wOD = 70;
hubdiam = 60;
numteeth=54;
clearance=0.2;
f=3;//get those gear teeth on the pedestal
dpitch = numteeth/(hubdiam);

module wheel()
{
	linear_extrude(center = false, height = wheel_height) {
		//Create the OD of the wheel
		circle(wOD/2);
	}
}

module hub()
{
	//linear_extrude(center = false, height = wheel_height) {
		//Create the OD of the hub (keep it simple, stupid)
		//circle((hubdiam+f)/2);
	//}
}

module spiralSpokes( diameter, wheelWidth, number, spokeWidth, curvature, reverse ) {
	echo( "Spiral Style..." ); 
	intersection() {
		cylinder( h=wheelWidth, r=diameter/2, center = true ); 

		for (step = [0:number-1]) {
		    rotate( a = step*(360/number), v=[0, 0, 1])
			spiralSpoke( wheelWidth, spokeWidth, (diameter/4) * 1/curvature, reverse );
		}
	}
}
module spiralSpoke( wheelWidth, spokeWidth, spokeRadius, reverse=false ) {
	render() 
	intersection() {	
		translate ( [-spokeRadius, 0, 0] ) {
			difference() {
				cylinder( r=spokeRadius, h=wheelWidth, center=true ); 
				cylinder( r=spokeRadius-(spokeWidth/2), h=wheelWidth+1, center=true ); 
			}
		}
		if ( reverse ) 
			translate ( [-spokeRadius, -spokeRadius/2, 0] ) 
				cube( [spokeRadius*2,spokeRadius,wheelWidth+1], center=true ); 
		else 
			translate ( [-spokeRadius, spokeRadius/2, 0] ) 
				cube( [spokeRadius*2,spokeRadius,wheelWidth+1], center=true ); 
	}
}

module solidwheel() {
difference() {
	union() {
		wheel();
		hub();
		translate([0,0,wheel_height]){linear_extrude(height=pedestal,center=false) {circle((hubdiam+f)/2);}}
		translate([0,0,wheel_height+pedestal]) {
 			gear (
				number_of_teeth=numteeth,
				 diametral_pitch=dpitch,
			pressure_angle=20,
			clearance = clearance,
			gear_thickness=gear_height,
			rim_thickness=gear_height,
			rim_width=0,
			hub_thickness=gear_height,
			hub_diameter=0,
			bore_diameter=0,
			circles=0,
			backlash=0,
			twist=0,
			involute_facets=0);
		}
	}
	linear_extrude(center = false, height = wheel_height+gear_height+pedestal) {
		circle((2.37+.25)/2);
	}
}

}

module spokecutout(){
	difference() {
		linear_extrude(height=30,center=true){circle((wOD-1-15)/2);}
		spiralSpokes(wOD-15,30,6,9,.66,false);
	}	
}
difference() {
	solidwheel();
	spokecutout();
}