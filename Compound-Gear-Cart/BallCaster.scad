/*
 * Parametric ball caster by Sliptonic.
 * http://www.thingiverse.com/thing:13782
 * Released under the Creative Commons Attribution 3.0 License
 * http://creativecommons.org/licenses/by/3.0/legalcode
 * For the Compound Gear cart, match the BallSize to the diameter of
 * the ball bearing or marble you have available.
 * TotalHeight has been computed according to other elements of the cart.
 */

WallThickness = 2;
BallSize = 15.9;
Airgap = .5;
Mount = 5;
TotalHeight = 14+70/2 + 1; //14 from mount to wheel center. 70/2 to bottom of wheel. 1 mm for the tire.
MountScrewRad = 2;  //3.4mm screw
BallProtrude = .25; //percentage of ball radius sticking out 

MountType = 1;  //1=ears  2=center screw
ScrewSpacing = 30;

$fn = 50;

cylheight = TotalHeight;
cylrad = (BallSize/2) + WallThickness + Airgap;
echo (cylheight);
difference () {
	cylinder(r1 = cylrad , r2 = cylrad,  cylheight - (BallSize*BallProtrude));

	translate([0,0,TotalHeight - BallSize/2]) {
		cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
		}

	translate([0,0,TotalHeight - (BallSize/2)]) {
		sphere (BallSize/2+Airgap, $fa=5, $fs=0.1);
		}
	}

difference (){
	linear_extrude(height=Mount)
	hull() {
		translate([ScrewSpacing/2,0,0]) {
			circle(  MountScrewRad*3);
			}
  		translate([1-ScrewSpacing/2,0,0]) {
			circle( MountScrewRad*3);
   			}
		circle( cylrad);
		}

	translate([ScrewSpacing/2,0,0]) {
		cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2);
		}
  	translate([1-ScrewSpacing/2,0,0]) {
		cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2);
   		}
}
