$fn=90;

BASE_PLATE_SIZE = [40.90, 132.75, 4.25];
POST_R=5.45/2;
POST_H=35;
// Posts are addressed with the copter facing you with the bottom left corner being 0,0
POST_0_0_POSITION =[5.7, 5, BASE_PLATE_SIZE[2]];
POST_1_0_POSITION = POST_0_0_POSITION + [30, 0, 0];
POST_0_1_POSITION = POST_0_0_POSITION + [0, 30.5, 0];
POST_1_1_POSITION = POST_0_1_POSITION + [30, 0, 0];

RUNCAM_BODY_SIZE = [22.3,14.4, 22];
RUNCAM_LENS_R = 12.5/2;
RUNCAM_LENS_H = 15.5;
RUNCAM_ANGLE=20;
RUNCAM_POSITION = [
  BASE_PLATE_SIZE[0]/2-RUNCAM_BODY_SIZE[0]/2,
  1,
  BASE_PLATE_SIZE[2]+12.5
 ];
 
CAM_HOLE_0_POSITION = [13.72,10.45,BASE_PLATE_SIZE[2]];
CAM_HOLE_1_POSITION = CAM_HOLE_0_POSITION + [10.5,0,0];
CAM_HOLE_SIZE = [2.35, 2.1, 10];

module post() {
  cylinder(r=POST_R, h=POST_H);
}

module frame() {
  // top plate
  translate([0,0,POST_H+BASE_PLATE_SIZE[2]]) {
    cube([40.8, 41.82, 2]);
  }
  // BASE_PLATE_SIZE
  cube(BASE_PLATE_SIZE);
  
  translate(POST_0_0_POSITION) {
    post();
  }
  translate(POST_0_1_POSITION) {
    post();
  }
  
  translate(POST_1_0_POSITION) {
    post();
  } 

  translate(POST_1_1_POSITION) {
    post();
  }   
}

module runcam() {
  translate(RUNCAM_POSITION) {
  rotate([-RUNCAM_ANGLE,0,0]) {
  // lens
  translate([22.3/2,15.5,22/2]) {
  rotate([90,0,0]) {
    cylinder(r=RUNCAM_LENS_R, h=RUNCAM_LENS_H);
  }}
  // body
  translate([0,15.5,0]) {
    cube(RUNCAM_BODY_SIZE);
  }
  // screw holes
  translate([-15,RUNCAM_LENS_H+RUNCAM_BODY_SIZE[1]-10,RUNCAM_BODY_SIZE[2]/2]) {
  rotate([0,90,0]) {
    cylinder(r=2.1/2, h=RUNCAM_BODY_SIZE[0]+30);
  }}
 }}}

module camholes() {
   
  translate(CAM_HOLE_0_POSITION) {
    camhole();
  }
  
  translate(CAM_HOLE_1_POSITION) {
    camhole();
  }
}
module camhole() {
  cube(CAM_HOLE_SIZE);
}


module cammount() {
  WALL=2;
  GAP=POST_1_0_POSITION[0]-POST_0_0_POSITION[0]-POST_R*2 - 2;
  WIDTH=GAP;
  POSITION=[
    POST_0_0_POSITION[0]+POST_R+0.6, 
    6, 
    BASE_PLATE_SIZE[2]
  ];
  difference() {
    union() {
      rotate([-RUNCAM_ANGLE,0,0])
      translate(POSITION)
        cube([WIDTH, WALL, POST_H-1]);
  
      translate(POSITION + [0,4,0])
        cube([WIDTH, GAP, WALL]);
      
      rotate([0,0,0])
      translate(POSITION + [0,4,1.9])
        cube([WIDTH, WALL, 3.5]);
      
    }
    runcam();
    frame();
  }
}
// Main
frame();
runcam();
cammount();