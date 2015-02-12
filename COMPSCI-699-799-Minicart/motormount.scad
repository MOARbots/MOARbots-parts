$fn = 50;

//add ~0.5mm factor to hole diameters for 3d printing
r_motor = (19.8)/2; //radius of circular part
flat_part = (14.8)/2; //center to flat line distance
r_dowel = (4.8)/2; //original, 3.4mm
r_nail = (2.4)/2;
wirehole = 1.7;
border = 2;

//NOTE THIS SEEMS GOOD, PRINT A GOOD PAIR AND TEST
gear_distance1 = 30.5;
gear_distance2 = 35.5;
padding = 14; //controls how much material you want on the bottom (under motor) needs to be adjusted so it is flat bottom at padding=0

rect1 = gear_distance1+gear_distance2 + r_nail + border;

module motorshape () {
	intersection() {
		polygon([[-100,-flat_part],[100,-flat_part],[100,flat_part],[-100,flat_part]]);
		circle(r_motor);
	}
}

module motorshapeborder () {
	intersection() {
		polygon([[-100,-(flat_part+border)],[100,-(flat_part+border)],[100,(flat_part+border)],[-100,(flat_part+border)]]);
		circle(r_motor+border);
	}
}

module innerholes () {
	motorshape();
	translate([gear_distance1,0,0]) {circle(r_dowel);}
	translate([-5,-11,0]) {circle(wirehole);}
	translate([5,-11,0]) {circle(wirehole);}
	translate([gear_distance2+gear_distance1,0,0]) { circle(r_nail); }
}


		difference() {
			hull() {
				union () {
					motorshapeborder();
					translate([gear_distance1+gear_distance2,0,0]) { circle(r_nail+border); }

					polygon([[-(r_motor+border),-padding],[-(r_motor+border),0],[rect1,0],[rect1,-padding]]);
				}
			}
			innerholes();	
		}
	


