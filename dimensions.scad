include <line.scad>;

LABEL_COLOR = "black";

eps = 0.01;


module Arc(angle, radius) {
  color(DIMENSION_COLOR)
    intersection() {
      difference() { // the line
        circle(r=radius);
        circle(r=radius-DIMENSION_LINE_WIDTH);
      }
      // the "mask" that removes all parts of the line outside of the angle
      scale(radius * 2) polygon([[0, 0], [1, 0], [cos(angle), sin(angle)]]);
    }
}

module Angle(angle, radius=10, label_angle=0, label_offset=10, show_spokes=false) {
  spoke_overflow = 2;
  Arc(angle, radius);

  // Spokes
  if (show_spokes) {
    Line(radius + spoke_overflow);
    rotate([0, 0, angle])
      Line(radius + spoke_overflow);
  }

  // Label
  rotate(angle/2)
    translate([radius + label_offset, 0, 0])
      scale(DIMENSION_FONTSIZE)
        rotate([0, 0, label_angle])
          color(DIMENSION_COLOR)
            text(str(round(angle), "°"), halign="center", valign="center");
}

module AngleOverview(angle, height, label="", zoom=2, max_width=20) {
  y = height / tan(angle);

  // Shape
  linear_extrude(height=eps) polygon([[0, 0], [max_width * zoom, 0], [max_width * zoom, height * zoom], [y * zoom, height * zoom]]);

  // Label
  translate([max_width * zoom + 10, 0, 0]) scale(DIMENSION_FONTSIZE) color(DIMENSION_COLOR) text(label);

  // Angle label
  rotate([0, 0, angle])
    Angle(90 - angle, radius=20 * zoom, show_spokes=true);
}

module Label(width=0, height=0, z_height=0, string, angle=0) {
  color(LABEL_COLOR) {
    linear_extrude(z_height + eps) {
      translate([width/2, height/2]) {
        rotate([0, 0, angle]) {
          if (is_undef(string) == true)
            text(parent_module(1), halign="center", valign="center");
          else 
            text(string, halign="center", valign="center");
        }
      }
    }
  }
}
