# New Dimension

An OpenSCAD library to add dimensions onto your projects.

![](demo/demo.png)

This library is based on the work of [Canny Machines - Don Smiley](http://cannymachines.com/entries/9/openscad_dimensioned_drawings).

## Installation

1. Download the .zip or .tar.gz release file for this library.
2. Extract the archive. This will create an `openscad-new-dimensions` directory containing the library files.
3. Move the `openscad-dimensions` directory to the appropriate OpenSCAD library directory for your platform:
   - Windows: My Documents\OpenSCAD\libraries\
   - Linux: $HOME/.local/share/OpenSCAD/libraries/
   - macOS: $HOME/Documents/OpenSCAD/libraries/
4. Restart OpenSCAD.

## Documentation

### Usage

```scad
include <openscad-new-dimensions/dimensions.scad>

Label();
Dimension();
Angle();
AngleOverview();
```

### Settings

**DIMENSION_LINE_WIDTH** (default: .5)<br>
Width of dimension lines

**DIMENSION_HEIGHT** (default: .1)<br>
Height of lines (Z axis)

**DIMENSION_ARROW_WIDTH** (default: .5)<br>
Width of arrows

**DIMENSION_ARROW_LENGTH** (default: 4)<br>
Length of arrows

**DIMENSION_ARROW_HOLLOW** (default: 1)<br>
Value between .1 and 1

**DIMENSION_FONT_SIZE** (default: DIMENSION_LINE_WIDTH)<br>
Size of the font for dimensions

**DIMENSION_COLOR** (default: "black")<br>
Color of the dimensions






