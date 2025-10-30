include <constants.scad>;

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

module FlatAngle(angle, radius=10, label_angle=0, label_offset=10, show_spokes=false, spokes_overflow=2) {
  Arc(angle, radius);

  // Spokes
  if (show_spokes) {
    Line(radius + spokes_overflow);
    rotate([0, 0, angle])
      Line(radius + spokes_overflow);
  }

    // Label
    rotate([0, 0, angle/2])
      translate([radius + label_offset, 0, 0])
        scale(DIMENSION_FONTSIZE)
          rotate([0, 0, label_angle])
            text(str(round(angle), "°"), halign="center", valign="center");
}

module Angle(angle, radius=10, label_angle=0, label_offset=10, show_spokes=false, spokes_overflow=2) {
  color(DIMENSION_COLOR) {
    if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_2D) {
      FlatAngle(angle, radius, label_angle, label_offset, show_spokes, spokes_overflow);
    } else if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_3D) {
      linear_extrude(height=DIMENSION_HEIGHT) {
        FlatAngle(angle, radius, label_angle, label_offset, show_spokes, spokes_overflow);
      }
    }
  }
}

module AngleOverview(angle, height, label="", zoom=2, max_width=20) {
  module FlatAngleOverview() {
    y = height / tan(angle);

    // Shape
    polygon([[0, 0], [max_width * zoom, 0], [max_width * zoom, height * zoom], [y * zoom, height * zoom]]);

    // Label
    translate([max_width * zoom + 10, 0, 0]) scale(DIMENSION_FONTSIZE) text(label);

    // Angle label
    rotate([0, 0, angle])
      FlatAngle(90 - angle, radius=20 * zoom, show_spokes=true);
  }

  color(DIMENSION_COLOR) {
    if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_2D) {
      FlatAngleOverview();
    } else if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_3D) {
      linear_extrude(height=DIMENSION_HEIGHT) {
        FlatAngleOverview();
      }
    }
  }
}
