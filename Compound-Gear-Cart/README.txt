Compound Gear Cart
See the photo "Example.JPG" to view an example of this cart assembled.

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.

Individual parts pulled into this project may have different licensing terms.
See the end of this file for details on licenses of different components.

Review:
* This design should be used if you need the following things:
  (a) 3d printable design
  (b) "130-size" motors

To-do: Update motor mount from 2x plate system to a single 3d printed assembly.
       The 2x plate system has too much play and is hard to assemble just right.

Additional hardware and parts:
* 2x "130-sized" DC motors
* 2x nails to serve as axles for the wheels
* 1x marble or ball bearing for the caster
* 2x short pins for the compound gear, with 2x matching hollow cylinder.
* 2x rubber bands for the tires
* Optional, 4 small disc magnets for mounting tags. Glue the magnets to the
  main body and build a tag with matching magnetic legs (steel roll pins,
  for example. Suggested coating with liquid electrical tape).

How to use:

1. Cut the main body plate, mainplate.pdf
   Choose some reasonable choice of material. I use .2" acrylic.

2. 3d Print 2x small gears, small_gear.scad
   These go on the motor output shaft. Use a rubber mallet or similar
   to carefully press fit these onto a "130" size motor. You can dab
   a bit of super glue to help with the fit. It is recommended that
   you print the center hole on the small size, then bore it out with
   a drill bit. You may find that these gears often mount crooked. To
   remove, melt with a heat gun and pull with pliers.

3. 3d print 2x wheels, wheel.scad
   The wheel center hole should match your axle diameter. A nail
   makes a good axle. Make sure the length of the nail is appropriate.

4. 3d print 2x compound gears, compound.scad
   The center hole should match a short pin or other part. The pin
   will spin in the motor mount plate. It helps if you can find a
   hollow cylinder, like a standoff, that matches your pin, to hold
   it more securely but allow it to freely spin.

5. 3d print the battery holders, small- and largebatteryholder.scad
   Match the sizes to your batteries. Glue the holders on the frame.
   I put the large battery underneath the robot along the center.
   I put the small battery to the side of the breadboard.

6. Cut 4x of the motormound.scad
   I used .2" laser cut acrylic. These hold the motors, compound gear
   pin, and wheel axle together. Assemble these, check the mesh of the
   gears, adjust, then use hot glue to secure.

7. 3d print the ball caster, BallCaster.scad
   Measure your marble or ball bearing and enter the diameter in BallSize.
   Glue to the front of the robot.
    

Other license information:

BallCaster.scad
	Parametric ball caster by Sliptonic.
	http://www.thingiverse.com/thing:13782
	Released under the Creative Commons Attribution 3.0 License
	http://creativecommons.org/licenses/by/3.0/legalcode

parametric_involute_gear_v5.0.scad
	Parametric Involute Bevel and Spur Gears by GregFrost
	It is licensed under the Creative Commons - GNU GPL license.
	© 2010 by GregFrost
	http://www.thingiverse.com/thing:3575