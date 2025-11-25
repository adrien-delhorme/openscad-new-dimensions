module Text(string, halign="left", valign="center", height) {
  height = is_undef(height) ? DIMENSION_HEIGHT : height;

  color(DIMENSION_COLOR) {
    if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_2D) {
      text(string, halign=halign, valign=valign);
    } else {
      linear_extrude(height=height) {
        text(str(string), halign=halign, valign=valign);
      }
    }
  }
}

module Label(string, bbox=[0, 0], angle=0, height) {
  color(DIMENSION_COLOR) {
    translate([bbox[0]/2, bbox[1]/2]) {
      rotate([0, 0, angle]) {
        if (is_undef(string) == true)
          Text(parent_module(2), halign="center", valign="center", height=height);
        else 
          Text(string, halign="center", valign="center", height=height);
      }
    }
  }
}