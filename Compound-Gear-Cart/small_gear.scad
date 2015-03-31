include <parametric_involute_gear_v5.0.scad>;

gear_height=7;
$fn=75;
dpitch = 54/60; //this should match the dpitch for the big wheel. choose that based on how many gear teeth you can fit without running into alignment and resolution problems.

difference() {
	union () {
		//translate([0,0,gear_height]) { linear_extrude(center = false, height = 7.5, scale=0.6) { circle(2.65); } }

		gear (
		number_of_teeth=9,
		diametral_pitch=dpitch,
		pressure_angle=20,
		clearance = 0.2,
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
	union() {
		translate([0,0,3.5]) {linear_extrude(center = false, height = gear_height) { circle(1.8/2); }}
		//translate([0,0,1.5+gear_height]) {linear_extrude(center = false, height = 5) { circle(2/2); }}
	}
}