/*
MIT License

Copyright (c) 2013 Don Smiley

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
include <constants.scad>;

module Arrow(arr_points, arr_length) {
  width = DIMENSION_ARROW_WIDTH;

  // arrow points to the left
  polygon(
    points = [[0, 0],
            [arr_points, arr_points * width],
            [arr_length, 0],
            [arr_points, -arr_points * width]],
    paths = [[0, 1, 2, 3]], convexity=2);
}

module Line(length, width=DIMENSION_LINE_WIDTH, height=DIMENSION_HEIGHT, left_arrow=false, right_arrow=false) {
  /* This module draws a line that can have an arrow on either end.
    *
    * You can control the shape of the arrow with DIMENSION_ARROW_WIDTH,
    * DIMENSION_ARROW_LENGTH and DIMENSION_ARROW_HOLLOW.
    */

  arr_points = width * DIMENSION_ARROW_LENGTH;
  arr_length = arr_points * DIMENSION_ARROW_HOLLOW;

  color(DIMENSION_COLOR) {
    union() {
      if (left_arrow && right_arrow) {
        translate([arr_length, -width / 2, 0])
          square([length - arr_length * 2, width], center=false);
      } else {
        if (left_arrow) {
          translate([arr_length, -width / 2, 0])
            square([length - arr_length, width], center=false);
        } else {
          if (right_arrow) {
            translate([0, -width / 2, 0])
              square([length - arr_length, width], center=false);
          } else {
            translate([0, -width / 2, 0])
              square([length, width], center=false);
          }
        }
      }

      if (left_arrow) {
        Arrow(arr_points, arr_length);
      }

      if (right_arrow) {
        translate([length, 0, 0])
          rotate([0, 0, 180])
            Arrow(arr_points, arr_length);
      }
    }
  }
}

module Dimension(length, line_width=DIMENSION_LINE_WIDTH, loc=DIMENSION_CENTER) {
  module FlatDimension() {
    text = str(length);
    space = len(text) * DIMENSION_FONTSIZE * 7;
    margin = 3;

    if (loc == DIMENSION_CENTER) {
      Line(
        length=length / 2 - space / 2 - margin,
        width=line_width,
        height=DIMENSION_HEIGHT,
        left_arrow=true,
        right_arrow=false
      );
      translate([length / 2 - space / 2, -DIMENSION_FONTSIZE * 4, 0])
        scale([DIMENSION_FONTSIZE, DIMENSION_FONTSIZE, DIMENSION_FONTSIZE])
          text(text);

      translate([length / 2 + space / 2 + margin, 0, 0])
        Line(
          length=length / 2 - space / 2 - margin,
          width=line_width,
          height=DIMENSION_HEIGHT,
          left_arrow=false,
          right_arrow=true
        );
    } else if (loc == DIMENSION_LEFT) {
      Line(
        length=length,
        width=line_width,
        height=DIMENSION_HEIGHT,
        left_arrow=true,
        right_arrow=true
      );

      translate([-space * 2, -DIMENSION_FONTSIZE * 3, 0])
        scale([DIMENSION_FONTSIZE, DIMENSION_FONTSIZE, DIMENSION_FONTSIZE])
          text(text);
    } else if (loc == DIMENSION_RIGHT) {
      Line(
        length=length,
        width=line_width,
        height=DIMENSION_HEIGHT,
        left_arrow=true,
        right_arrow=true
      );

      translate([length + space, -DIMENSION_FONTSIZE * 3, 0])
        scale([DIMENSION_FONTSIZE, DIMENSION_FONTSIZE, DIMENSION_FONTSIZE])
          text(text);
    } else if (loc == DIMENSION_OUTSIDE) {
      rotate([0, 180, 0])
        Line(
          length=length / 2,
          width=line_width,
          height=DIMENSION_HEIGHT,
          left_arrow=true,
          right_arrow=false
        );

      translate([(length) / 2 - space / 2 * .9, -DIMENSION_FONTSIZE * 3, 0])
        scale([DIMENSION_FONTSIZE, DIMENSION_FONTSIZE, DIMENSION_FONTSIZE])
          text(text);

      translate([length, 0, 0])
        Line(
          length=length / 2,
          width=line_width,
          height=DIMENSION_HEIGHT,
          left_arrow=true,
          right_arrow=false
        );
    } else if (loc == DIMENSION_ABOVE) {
      Line(
        length=length,
        width=line_width,
        height=DIMENSION_HEIGHT,
        left_arrow=true,
        right_arrow=true
      );

      translate([length / 2 - space / 2, DIMENSION_FONTSIZE * 4, 0])
        scale([DIMENSION_FONTSIZE, DIMENSION_FONTSIZE, DIMENSION_FONTSIZE])
          text(text);
    } else if (loc == DIMENSION_UNDER) {
      Line(
        length=length,
        width=line_width,
        height=DIMENSION_HEIGHT,
        left_arrow=true,
        right_arrow=true
      );

      translate([length / 2 - space / 2, -DIMENSION_FONTSIZE * 15, 0])
        scale([DIMENSION_FONTSIZE, DIMENSION_FONTSIZE, DIMENSION_FONTSIZE])
          text(text);
    }
  }

  color(DIMENSION_COLOR) {
    if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_2D) {
      FlatDimension();
    } else if (DIMENSION_RENDER_MODE == DIMENSION_RENDER_MODE_3D) {
      linear_extrude(height=DIMENSION_HEIGHT) {
        FlatDimension();
      }
    }
  }
}
