# New Dimensions

An OpenSCAD library to add dimensions onto your projects.

![](demo/demo.svg)

This library is based on the projects [dimensional-drawings](https://github.com/pwpearson/dimensional-drawings) and [Canny Machines (Don Smiley)](http://cannymachines.com/entries/9/openscad_dimensioned_drawings).

## Installation

1. Download the .zip or .tar.gz release file for this library.
2. Extract the archive. This will create an `openscad-new-dimensions` directory containing the library files.
3. Move the `openscad-new-dimensions` directory to the appropriate OpenSCAD library directory for your platform:
   - Windows: My Documents\OpenSCAD\libraries\
   - Linux: $HOME/.local/share/OpenSCAD/libraries/
   - macOS: $HOME/Documents/OpenSCAD/libraries/
4. Restart OpenSCAD.

## Documentation

You can create labels, linear dimensions, angular dimensions, and angle overviews that represent the angles required to cut your material.
You can use these elements in 2D or 3D projects by setting `DIMENSION_RENDER_MODE`.

### Include library

```scad
include <openscad-new-dimensions/constants.scad>;
include <openscad-new-dimensions/dimensions.scad>
```

### Label
```scad
Label(string, bbox=[0, 0], angle=0, height);
```

- `string`: the text to display. If `Label` is wrapped inside a module and `string` is not defined, the parent module's name will be used. Default: `undefined`.
- `bbox`: centres the label within this bounding box. Default: `[0, 0]`.
- `angle`: rotates the label by the given angle. Default: `0`.
- `height`: extrudes the label along the Z axis by the given height. Default: `undefined`.


### Dimension
```scad
Dimension(length, line_width=DIMENSION_LINE_WIDTH, loc=DIMENSION_CENTER);
```

- `length`: the length of the dimension line. Default: `undefined`.
- `line_width`: the width of the dimension line. Default: `DIMENSION_LINE_WIDTH`.
- `loc`: the location of the dimension label. Choices: `DIMENSION_CENTER`, `DIMENSION_LEFT`, `DIMENSION_RIGHT`, `DIMENSION_OUTSIDE`, `DIMENSION_ABOVE`, `DIMENSION_UNDER`. Default: `DIMENSION_CENTER`.

### Angle
```scad
Angle(angle, radius=10, label_angle=0, label_offset=10, show_spokes=false, spokes_overflow=2);
```

- `angle`: the angle value. Default: `undefined`.
- `radius`: the radius of the arc representing the angle. Default: `10`.
- `label_angle`: rotates the label by the given angle. Default: `0`.
- `label_offset`: offsets the label by the given value. Default: `10`.
- `show_spokes`: if true, the angle is represented by an arc and two spokes. Default: `false`.
- `spokes_overflow`: the spokes exceed the arc's radius by the given value. Default: `2`.

### Angle overview

This module displays a representation of the angle needed to cut your material. This is useful on a blueprint where all items are viewed from above.

```scad
AngleOverview(angle, height, label="", zoom=2, max_width=20);
```

- `angle`: the angle to show. Default: `undefined`.
- `height`: the height of the polygon representing a side cut of your material. Default: `undefined`.
- `label`: a label to show. Default: `""`.
- `zoom`: scales the whole angle overview. Default: `2`.
- `max_width`: the maximum width of the polygon representing a side cut of your material. Default: `20`.

### Settings

**DIMENSION_LINE_WIDTH** (default: .5)<br>
Width of dimension lines.

**DIMENSION_HEIGHT** (default: .1)<br>
Height of lines (Z axis).

**DIMENSION_ARROW_WIDTH** (default: .5)<br>
Width of arrows.

**DIMENSION_ARROW_LENGTH** (default: 4)<br>
Length of arrows.

**DIMENSION_ARROW_HOLLOW** (default: 1)<br>
Value between .1 and 1.

**DIMENSION_FONT_SIZE** (default: DIMENSION_LINE_WIDTH)<br>
Font size for dimensions.

**DIMENSION_COLOR** (default: `black`)<br>
Color of the dimensions.

**DIMENSION_RENDER_MODE** (default: `DIMENSION_RENDER_MODE_2D`)<br>
Rendering mode of dimensions. Can be `DIMENSION_RENDER_MODE_2D` or `DIMENSION_RENDER_MODE_3D`.
