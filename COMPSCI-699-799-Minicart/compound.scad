include <parametric_involute_gear_v5.0.scad>;

gear_height1=5;
gear_height2=5;
r_nail = (3.13+.5)/2; //original, 3.4mm
$fn=75;
dpitch = 54/60; //this should match the dpitch for the big wheel. choose that based on how many gear teeth you can fit without running into alignment and resolution problems.

difference (){
union(){
		gear (
		number_of_teeth=45,
		diametral_pitch=dpitch,
		pressure_angle=20,
		clearance = 0.2,
		gear_thickness=gear_height2,
		rim_thickness=gear_height2,
		rim_width=0,
		hub_thickness=gear_height2,
		hub_diameter=0,
		bore_diameter=0,
		circles=0,
		backlash=0,
		twist=0,
		involute_facets=0);
	translate([0,0,gear_height1]){
		gear (
		number_of_teeth=9,
		diametral_pitch=dpitch,
		pressure_angle=20,
		clearance = 0.2,
		gear_thickness=gear_height1,
		rim_thickness=gear_height1,
		rim_width=0,
		hub_thickness=gear_height1,
		hub_diameter=0,
		bore_diameter=0,
		circles=0,
		backlash=0,
		twist=0,
		involute_facets=0); }
}
	linear_extrude(center=false, height=50) {circle(r_nail);}
}