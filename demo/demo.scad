include <openscad-new-dimensions/constants.scad>;
include <openscad-new-dimensions/dimensions.scad>;

/* [Parameters] */
// Choose the rendering mode
DIMENSION_RENDER_MODE = "3D"; // [3D, 2D]

// Choose the color
DIMENSION_COLOR = "white"; // [white, black, red, green, blue, yellow, purple, orange, brown, gray, pink, lime, teal, cyan, magenta]

// Width of dimension lines
DIMENSION_LINE_WIDTH = .5;

// Height of dimensions in 3D mode
DIMENSION_HEIGHT = 1;

// Width of arrows
DIMENSION_ARROW_WIDTH = .3;

// Length of arrows
DIMENSION_ARROW_LENGTH = 8;

// Hollow of arrows
DIMENSION_ARROW_HOLLOW = 1; // [.1:0.1:1]

/* [Hidden] */
eps = .01;

/* Dimensions */
Text("Dimensions");
locations = [DIMENSION_CENTER, DIMENSION_LEFT, DIMENSION_RIGHT, DIMENSION_OUTSIDE, DIMENSION_ABOVE, DIMENSION_UNDER];
for (i = [0 : len(locations) - 1]) {
  translate([0, -(i + 1) * 30, 0])
    Dimension(length=100, loc=locations[i]);
}


/* Angles */
translate([200, 0, 0]) {
  Text("Angles");

  translate([0, -50, 0])
    Angle(angle=45, radius=25);

  translate([0, -100, 0])
    Angle(angle=33, radius=35, show_spokes=true, spokes_overflow=0);

  translate([0, -150, 0])
    Angle(angle=22, radius=45, show_spokes=true, spokes_overflow=6, label_offset=-10, label_angle=-90);
}

/* Labels */
module LabelExample() {
  if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_2D) {
    difference() {
      square([100, 100]);
      Label(bbox=[100, 100]);
    }
  } else {
    difference() {
      cube([100, 100, 50]);
      translate([0, 0, -eps])
        Label(bbox=[100, 100], height=50 + 2 *eps);
    }
  }
}

translate([300, 0, 0]) {
  Text("Labels");

  translate([0, -120, 0]) {
    LabelExample();
  }
}

/* Angle overview */
translate([450, 0, 0]) {
  Text("Angle overview");

  translate([0, -80, 0]) {
    AngleOverview(angle=45, height=10, label="Angle overview", zoom=2, max_width=20);
  }
}