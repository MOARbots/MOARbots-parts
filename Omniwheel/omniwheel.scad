/* Main module for omniwheel by Shira Epstein
 * This work is licensed under the Creative Commons Attribution 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
 */

include <bead.scad>;
include <hub.scad>;

//Variables
w_r = 30; //Radius of the wheel
b_n_rad = 2.5/2; //Size of the radius of the central bead hole, loose fit for the nail.
nail_length = 32; //Length of the nail tip to head
nail_support = 2; //At each end, length of the nail that will be supported
wiggle_room = 0.25; //Allow the bead to wiggle a small amount along the nail to reduce friction

//Computed variables
b_l = nail_length - nail_support*2 - wiggle_room*2;

//Code

$fn = 50;

bead(b_l, w_r, b_n_rad);
