include <openscad-new-dimensions/constants.scad>;
include <openscad-new-dimensions/dimensions.scad>

module Cube(side=100) {
    cube([side, side, side]);

    translate([0, -10, 0])
        Dimension(length=side);
        
    translate([-10, 100, 0])
        rotate([0, 0, -90])
            Dimension(length=side);

    translate([-10, -10, 100])
        rotate([0, 90, 0])
            Dimension(length=side);

    Label(width=side, height=side, z_height=side);
}

Cube();

module Pyramid(side=100) {
    translate([0, side/2, 0])
        rotate([0, 0, 45]) {
            $fn = 4;
            cylinder(h=side, d1=side * sqrt(2), d2=0);
        }

    translate([-side/2, 0, 0])
        rotate([atan(side/(side/2)), 0, 0]) {
            angle = atan(sqrt(side^2 + (side/2)^2) / (side / 2));
            Angle(angle=angle, radius=side/4);
        }

    translate([side/2, 0, 0]) {
        angle = atan(sqrt(side^2 + (side/2)^2) / (side / 2));
        rotate([-atan(side/(side/2)), 0, 180]) {
            $fn = 100;
            Angle(angle=-angle, radius=side/4, label_angle=180, show_spokes=true);
        }
    }

    translate([100, 0, 0]) {
        AngleOverview(angle=45, height=10, label="Angle overview", zoom=2, max_width=20);
    }
}

translate([200, 0, 0])
    Pyramid();