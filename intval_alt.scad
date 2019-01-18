include <./modules.scad>;

BODY_X = 135;
BODY_Y = 140;
BODY_Z = 68;
BOLEX_X = BODY_X;
BOLEX_Y = BODY_Y;
BOLEX_Z = BODY_Z;

STEPPER_W = 42.5;
STEPPER_VOID_D = 22.5;
STEPPER_H = 8;
STEPPER_THICKNESS = 5;
STEPPER_BOLTS = 21.6;
STEPPER_CORNER = 60.1;
STEPPER_BOTTOM = 6;

PANEL_Z = 3;
PANEL_X = BOLEX_X;
PANEL_Y = 96;

PANEL_OFFSET_Z = 42;
PANEL_OFFSET_X = 0;
PANEL_OFFSET_Y = 20;

FRONT_SPACING_Z = 64;

SHAFT_POSITION_X = (BOLEX_X / 2) - 25.5;
SHAFT_POSITION_Y = (BOLEX_Y / 2) - 47.6;

module panel () {
    $fn = 60;
    difference () {
        rounded_cube([PANEL_X, PANEL_Y, PANEL_Z], d = 8, center = true);
        //stepper void
        translate([0 , -PANEL_OFFSET_Y, 0]) {
            translate([SHAFT_POSITION_X, SHAFT_POSITION_Y, 0]) stepper_void();
        }
        //center mount void
        translate([0 , -PANEL_OFFSET_Y, 0]) {
            translate([SHAFT_POSITION_X - 32 + 1, SHAFT_POSITION_Y + 24 - 5, 0]) cylinder(r = 7 /2, h = 20, center = true);
        }
        //arduino void
        translate([0 , -PANEL_OFFSET_Y, 0]) translate([-20 - 14, 15, 20]) arduino();
        //window for frame counter
        translate([(PANEL_X / 2) - 32, (PANEL_Y / 2) - 8, 0]) cube([16, 16, 4], center = true);
        //front  supports
        translate([56.8, (FRONT_SPACING_Z / 2) + 2.1, 0]) cylinder(r = 5 / 2, h = 16, center = true);
        translate([56.8, (FRONT_SPACING_Z / 2) + 2 - FRONT_SPACING_Z, 0]) cylinder(r = 5 / 2, h = 16, center = true);
        //back supports
        //translate([-56.8 -2.25, (50 / 2) , 0]) cylinder(r = 5 / 2, h = 16, center = true);
        //translate([-56.8 -2.25, (50 / 2)  - 50, 0]) cylinder(r = 5 / 2, h = 16, center = true);
        //center standoff void
        //translate([0, -PANEL_OFFSET_Y, 0]) translate([17, -6, 25]) cylinder(r = 8 / 2, h = 50, center = true);
  }
}


//mothballed, mount stepper directly to board
/*module stepper_mount () {
  	$fn = 60;
	difference () {
    	rounded_cube([STEPPER_W + (STEPPER_THICKNESS * 2), STEPPER_W + (STEPPER_THICKNESS * 2), STEPPER_H + STEPPER_BOTTOM], d = 8, center = true);
		translate([0, 0, STEPPER_BOTTOM / 2 + 0.1]) {
      		difference() {
      			cube([STEPPER_W, STEPPER_W, STEPPER_H], center = true);
                for (i = [0:4]) {
    				rotate([0, 0, 45 + (i * (360 / 4))]) {
            			translate([STEPPER_CORNER / 2, 0, 0]) cube([3, 3, STEPPER_H * 2], center = true);
            		}
    			}
        	}
      	}
        for (i = [0:4]) {
    		rotate([0, 0, 45 + (i * (360 / 4))]) {
        		translate([STEPPER_BOLTS, 0, 0]) {
          			cylinder(r = 1.5, h = 20, center = true);
          			translate([0, 0, -6]) cylinder(r = 5.6 / 2, h = 3, center = true);
          		}
        	}
    	}
        //disk void
        translate([0, 0, -1.9]) cylinder(r = STEPPER_VOID_D/ 2, h = 2, center  = true, fn = 200);
  	    cylinder(r = 5.5 / 2, h = 20, center = true);
  }
    
}*/

module stepper_void (H = 10) {
    //$fn = 50;
        for (i = [0:4]) {
    		rotate([0, 0, 45 + (i * (360 / 4))]) {
        		translate([STEPPER_BOLTS, 0, 0]) {
          			cylinder(r = 1.5, h = 20, center = true);
          			//translate([0, 0, -6]) cylinder(r = 5.6 / 2, h = H, center = true);
          		}
        	}
    	}
        //disk void
        translate([0, 0, -1.9]) cylinder(r = STEPPER_VOID_D/ 2, h = H, center  = true, fn = 200);
  	    cylinder(r = 5.5 / 2, h = 20, center = true, $fn = 100);
}

module mount_base () {
	rounded_cube([STEPPER_W + (STEPPER_THICKNESS * 2), STEPPER_W + (STEPPER_THICKNESS * 2), 6], d = 8, center = true);
    //stepper mount
}

module one_to_eight_shaft () {
	//$fn = 60;
	H = 4;
	BAR = 4.98 - 3.66;
	BAR_W = 1.34;
  	difference () {
		cylinder(r = 9.11 / 2, h = H, center = true);
		cylinder(r = 7.16 / 2, h = H + 1, center = true);
    }
	cylinder(r = 3 / 2, h = H, center = true);
	rotate([0, 90, 0]) cylinder(r = BAR_W / 2, h = H, center = true);
}

module key () {
    $fn = 60;
    BODY = 16;
	OD = 7.16 - .15;
	ID = 3.2;
    H = 5;
  	BAR = 4.98 - 3.66;
	BAR_W = 1.34;
    BEARING_ID = 8;
	PAD = BODY;
    SHAFT_D = 5;
    SHAFT_H = 18;
    
  	difference () {
		cylinder(r = OD / 2, h = H, center = true);
		cylinder(r = ID / 2, h = H, center = true);
		translate([OD / 2, 0, -(5 / 2) + ((BAR + .15) / 2)]) cube([OD + 1, BAR_W + .15, BAR + .15], center = true);
    }

    translate([0, 0, 4]) cylinder(r2 = PAD / 2, r1 = BEARING_ID / 2, h = 4, center = true);
    
  	translate([0, 0, 14 - 0.02]) {
    	difference() {
    		cylinder(r = BODY / 2, h = BODY, center = true);
            
      		translate([0, 0, 1.5]) difference(){
                cylinder(r = SHAFT_D / 2 , h = SHAFT_H, center = true);
        		translate([0, (SHAFT_D / 2) + (4.6 / 2), 0]) cube([SHAFT_D, SHAFT_D, SHAFT_H + 1], center = true);
      		}
        	translate([0, 5, 2])  {
                rotate([90, 0, 0]) {
                    cylinder(r = 2.6 /2, h = 10, center = true);
                    translate([0, 0, -2.5]) cylinder(r = 5.75 / 2, h = 4, center =true);
                }
			}
    	}
  }
  //outside
  translate([0, 0, 2]) difference () {
    cylinder(r = 12 / 2, h = 6, center = true);
    cylinder(r = 9.1 / 2, h = 6 + 1, center = true);
  }
  
}

module bolex () {
	cube([BODY_X, BODY_Y, BODY_Z], center = true);
    //1:8 shaft
    color("red") translate([SHAFT_POSITION_X, SHAFT_POSITION_Y, (BOLEX_Z / 2) + 2]) one_to_eight_shaft();
    //translate([0, 0, 50]) key();
}

module arduino () {
	X = 53.5;
    Y = 68.75;
    Z = 22.5;
    cube([X, Y, Z], center = true);
    translate ([-27, -39, 0]) {
		 translate([  2.54, 15.24 , 0]) cylinder(r = 3.5 / 2, h = 100, center = true);
		 translate([  17.78, 66.04 , 0]) cylinder(r = 3.5 / 2, h = 100, center = true);
		 translate([  45.72, 66.04 ,0]) cylinder(r = 3.5 / 2, h = 100, center = true);
		 translate([  50.8, 13.97  ,0]) cylinder(r = 3.5 / 2, h = 100, center = true);

  	     //cylinder(r = 3.5 / 2, h = 100, center = true);
    }
}

module stepper () {
	    SHAFT_D = 5;
    SHAFT_H = 22.5;
  H = 32.76;

  cube([STEPPER_W, STEPPER_W, H], center = true);
  for (i = [0:4]) {
          rotate([0, 0, 45 + (i * (360 / 4))]) {
              translate([STEPPER_BOLTS, 0, 0]) {
                  cylinder(r = 1.5, h = 20, center = true);
                  translate([0, 0, -6]) cylinder(r = 5.6 / 2, h = H, center = true);
              }
          }
      }
      //disk void
      translate([0, 0, -1.9]) cylinder(r = STEPPER_VOID_D/ 2, h = H, center  = true, fn = 200);
      cylinder(r = 5.5 / 2, h = 20, center = true, $fn = 100);
     translate([0,0,-(H / 2) - (SHAFT_H / 2) - 1.9]) difference(){
                cylinder(r = SHAFT_D / 2 , h = SHAFT_H, center = true);
        		translate([0, (SHAFT_D / 2) + (4.6 / 2), 0]) cube([SHAFT_D, SHAFT_D, SHAFT_H + 1], center = true);
      		}
}

module cross_bar () {
    W = 170;
	cube([7, W, 40], center = true);
}

module back_support () {
    $fn = 60;
  A = 27;
  B = 33;
  difference() {
  	translate([2, 0, 0]) rotate([90, 0, 0]) {
      //rounded_cube([32 , 57, 18], d = 6, center = true);
      union () {
        translate([0, -(57 / 2) + (A / 2), 0]) rounded_cube([32, A, 18], d = 6, center = true);
        translate([(32 / 2) - 8, (57 / 2) - (B / 2) , 0]) rounded_cube([18, B, 18], d = 6, center = true);
      }
    }
  	//void for panel
    translate([15, 0, 23.5]) cube([20, 40, 3.1], center = true);
    translate([13, 0, -37]) cube([32 , 18 + 1, 57], center = true);
    translate([25, 0, -10]) cube([32 , 18 + 1, 57], center = true);
    translate([.3, 0, -18.5]) rotate([0, 90, 0]) {
      cylinder(r = 12.2 / 2, h = 20, center = true);
      cylinder(r = 5 / 2, h = 50, center = true);
      translate([0, 0, -11]) cylinder(r = 8.9 / 2, h = 3.5, center = true, $fn = 6);
    }
    //top bolt
    translate([13.5, 0, 29]) cylinder(r = 5 / 2, h = 25, center = true);
  } 
  
}

module back_clamp () {
    $fn = 60;
    difference () {
        intersection () {
            cube([20, 75, 8], center = true);
            union () {
                cube([20, 65, 10], center = true);
                translate([0, 65 / 2, 3.5]) rotate([0, 90, 0]) cylinder(r = 7.5, h =20, center = true, $fn = 60);
                translate([0, -65 / 2, 3.5]) rotate([0, 90, 0]) cylinder(r = 7.5, h =20, center = true, $fn = 60);
            }
        }
    }
  	translate([0, 50 / 2, 6]) {
    	difference() {
    		cylinder(r = 12 / 2, h = 10, center = true);
      		cylinder(r = 5 / 2, h = 10 + 1, center = true);
      }
    }

    translate([0, -50 / 2, 6]) {
    	difference () {
    		cylinder(r = 12 / 2, h = 10, center = true);
      		cylinder(r = 5 / 2, h = 10 + 1, center = true);
      	}
    }

}

module front_support() {
  $fn = 60;
  difference () {
   	translate([-2.50, 0, 0]) rotate([90, 0, 0]) union() {
      //rounded_cube([45, 70, 18], d = 6, center = true);
      translate([0, -(70 / 2) + (42 / 2), 0])rounded_cube([45, 42, 18], d = 6, center = true);
      translate([0, (70 / 2) - (35 / 2), 0])rounded_cube([45, 35, 18], d = 6, center = true);
    }
    translate([-12.5, 0, -11]) rotate([90, 0, 0]) {
        difference() {
           cube([40, 70, 25], center = true);
           translate([0, 43, 0]) cube([40, 70, 25], center = true);
        }
    }
    //void for panel
    translate([-15, 0, 29]) cube([20, 40, 3.1], center = true);
    //top bolt
    translate([-16, 0, 29]) cylinder(r = 5 / 2, h = 25, center = true);
    //bolt shaft and hex
    translate([10, 0, -25 + 3]) rotate([0, 90, 0]) {
    	cylinder(r = 5 / 2, h = 26, center = true);
         translate([0, 0, 0]) cylinder(r = 12.2 / 2, h = 10, center =true);
        translate([0, 0, 6.5])  cylinder(r = 8.9 / 2, h = 3.5, center = true, $fn = 6);
    }
    //void for shelf
    translate([17, 0, 25]) rotate([90, 0, 0]) rounded_cube([30, 35, 19], d = 6,  center = true);
  	translate([-25, 0, 5]) rotate([90, 0, 0]) rounded_cube([30, 35, 19], d = 6,  center = true);
  }
  
  

   //translate([-12, 0, 29]) cylinder(r = 5 / 2, h = 25, center = true);
  translate([10, 0, -20]) rotate([0, 90, 0]) {
       //cylinder(r = 5 / 2, h = 26, center = true);
       //translate([0, 0, 0]) cylinder(r = 12 / 2, h = 10, center =true);
       //translate([0, 0, 5])  cylinder(r = 8.9 / 2, h = 3.5, center = true, $fn = 6);
    }
}

module front_clamp () {
    $fn = 60;
	D = 24 + (2.16-1.53);
	H = 3;
	D2 = 30;
    H2 = 6;
  	difference () {
    	union () {
			cylinder(r = D / 2, h = H, center = true);
			translate([0, 0, -(H / 2) - (H2 / 2)]) cylinder(r = D2 / 2, h = H2, center = true);
    	}
    	translate([0, 0, -1.5 - 6]) cylinder(r = 5 / 2, h = 6, center = true);

    }
  	translate([0, 0, -10]) {
    	difference () {
			cylinder(r = 12 / 2, h = 10, center =true);

            translate([0, 0, 0]) cylinder(r = 5 / 2, h = 16, center = true);
      	}
    }
}

module center_stand () {
  $fn = 60;
  H = 31 + 5;
  difference () {
	  union () {
      cylinder(r = 10 / 2, h = H, center = true);
	    translate([0, 0, (H / 2) + 2]) cylinder(r = 7 / 2, h = 4, center = true);
      translate([0, 0, (H / 2) - 2]) cylinder(r = 16 / 2, h = 4, center = true);
      translate([0, 0, -(H / 2) + 2]) cylinder(r = 16 / 2, h = 4, center = true);
    }
    cylinder(r = 5 / 2, h = H + 10, center = true);
    translate([0, 0, -(H / 2) + (2 / 2)]) cylinder(r = 8 / 2, h = 2, center = true); 
  }

}

//translate([17, -6, 25]) center_stand();
//translate([SHAFT_POSITION_X - 32 + 1, SHAFT_POSITION_Y + 24 - 5, 25 - 2.5]) center_stand();

//translate([0, 0, -24]) bolex();
translate([(170 / 2) - (147.3 - 135), (BOLEX_Y / 2) - 47.8, -12 + 3]) {
	//translate([0, FRONT_SPACING_Z / 2, 0]) rotate([0, -90, 0]) front_clamp();
	//translate([0, -FRONT_SPACING_Z / 2, 0]) rotate([0, -90, 0]) front_clamp();
}
//front_clamp();
//translate([0, 0, 10]) rotate([0, 90, 0]) cross_bar();

translate([SHAFT_POSITION_X, SHAFT_POSITION_Y, 12]) difference() {
    //key();
    //translate([50, 0, 0]) cube([100, 100, 100], center = true);
}
//translate([PANEL_OFFSET_X, PANEL_OFFSET_Y, PANEL_OFFSET_Z]) panel();
//projection() panel();
//translate([SHAFT_POSITION_X, SHAFT_POSITION_Y, 60]) stepper();
//mount_base();
//translate([-20, 15, 55]) arduino();
/*translate([-5, 20, 63]) color([0, 0, 1], 0.2) difference () {
  cube([96, 96, 40], center = true);
  translate([0, 0, -3]) cube([96 - 6, 96 - 6, 40 - 3], center = true);
}*/
translate([(170 / 2) - (147.3 - 135), -10, 13]) {
  //difference () {
  	//front_support();
    //translate([0, 50, 0]) cube([100, 100, 200], center = true);
  //}
}
//translate([30, 0, -35]) rotate([180, 0, 0]) 
rotate([90, 90, 0]) front_support();
//translate([30 + 18, 0, -35 - 18]) rotate([180, 0, 0]) front_support();
//translate([(170 / 2) - (147.3 - 135), -10 + FRONT_SPACING_Z , 13]) front_support();
//translate([0, 20, 50],) cylinder(r = 5, h = 28, center = true);

//translate([-(170 / 2) + (147.3 - 135) + 1.5, 20, 0]) rotate([0, -90, 0]) back_clamp();
//translate([-(170 / 2) + (147.3 - 135), (BODY_Y / 2) - 25 , 18.5]) 
 //back_support();
//translate([15, 0, -15]) back_support();
translate([-(170 / 2) + (147.3 - 135), (BODY_Y / 2) - 25 - 50 , 18.5]){
  //difference () {
  	//back_support();
    //translate([0, 50, 0]) cube([100, 100, 200], center = true);
  //}
}