OUTER_SIZE=[36,36,1];
HOLES=3.5;
SPACE_BETWEEN_HOLES=30.5;


// Internal
OFFSET = (OUTER_SIZE[0] - SPACE_BETWEEN_HOLES) / 2;
$fn=127;


// Model
difference() {
  cube(OUTER_SIZE);
  
  translate([OFFSET,OFFSET,-5]) {
    cylinder(r=HOLES/2, h=10);
  }
  translate([OFFSET+SPACE_BETWEEN_HOLES,OFFSET,-5]) {
    cylinder(r=HOLES/2, h=10);
  }
  translate([OFFSET+SPACE_BETWEEN_HOLES,OFFSET+SPACE_BETWEEN_HOLES,-5]) {
    cylinder(r=HOLES/2, h=10);
  }
  
  translate([OFFSET,OFFSET+SPACE_BETWEEN_HOLES,-5]) {
    cylinder(r=HOLES/2, h=10);
  }
}