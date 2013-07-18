wolfstock
=========

__NOTE__ This is a Work In Progress

__NOTE__ The old T frame version of this has been deprecated and can be found in the branch [tframe](https://github.com/wolfmanjm/wolfstock/tree/tframe)


A 3d Delta printer based on the Mini-Kossel but using 2040 Makerslide for the
towers and the carriages.

* [Githubiverse page](http://wolfmanjm.github.com/wolfstock)
* [First Print](http://www.youtube.com/watch?v=khotvR7Lyf4)
* [Printing Tornado vase](http://www.youtube.com/watch?v=ChUlHnQ6QRw)

This is a Makerslide and Misumi based frame, using Spectra fishing line drive
ala Kossel, and has a large frame made from 2040 and 2020 Misumi using mini-kossel style printed brackets.

The default version has 1000mm high Makerslide towers, an 463.4mm triangle sides, and 
arm length of 370mm, which makes for a roughly 250mm circular build area using Traxxas joints
and 400mm build height.

The scad source files are parameterized so the dimensions can be
tweaked.

Many of the scad files are derived from Kossel files, some are
original designs by me.

All are under the same licensing as Kossel.

## BoM


### Printed parts
Stls are in the
[STL directory](https://github.com/wolfmanjm/wolfstock/tree/master/stl)

* Print three base-bracket-motor.stl
* Print three base-bracket-idler.stl
* Print three tensioner_608.stl
* Print one effector.stl
* Print three carriage-new.stl (These bolt onto a carriage that has
  20mm hole paterns
  [like](https://www.inventables.com/technologies/standard-wheel-carriage-plate),
  so check your plates and adjust the scad as necessary.

### Extrusion and Vitamins
* 3x 1m lengths of 2040 Makerslide, OR 3x 1m lengths of Misumi 2040 and
  3x 1m lengths of open rail, OR 3x 1m lengths of 2040 V-Slot
* 3x 463.4mm lengths of 2040 for bottom rails (use the kossel
  calculator to get the length you want and add in the side offset,
  see the lite-frame.scad and play with the sizes)
* 3x 463.4mm lengths of 2020 for top rails
* 12x delrin v wheels for whatever rails you have chosen (sourcing
  below)
* Appropriate carriage for the rails and wheels, add 2x eccentric
  spacers per carriage and 3x regular spacers. (some wheels come with
  the regular ones)
* 6x 370mm 0.318" (8mm) square carbon fiber tube if using the endcaps to join
  with traxas joints, or round tubing as per Kossel
* plenty of t nuts and M5 bolts... lengths TBD


## Sourcing

### Common components

* Bottom side rails 2040 500mm Misumi ~$5 3 $15
* Top side rails 2020 500mm Misumi ~$2.50 3 $7.50
* Bolts for back of towers M4 Length? 24
* Bolts for side braces M4 Length?  24
* T Nuts M4 100 Misumi $20

### Makerslide based
* Makerslide rail 1000mm https://www.inventables.com/technologies/makerslide 25142-03 $21.74 3 $65.52
* Dual Bearing V-Wheel Kit https://www.inventables.com/technologies/dual-bearing-v-wheel-kit 25203-02 $4.85 12 $58.20
* Eccentric Spacer https://www.inventables.com/technologies/eccentric-spacer 25195-01 $2.00 6 $12.00
* Nylon Natural Color Spacer pack of 10 https://www.inventables.com/technologies/nylon-natural-color-spacer 25206-01 $2.00 1 $2.00
* Standard Wheel Carriage Plate https://www.inventables.com/technologies/standard-wheel-carriage-plate 25200-01 $8.00 3 $24.00

Sub Total: $161.72

### V Slot based
* V-Slot 20 x 40mm 1000mm http://openbuildspartstore.com/v-slot-20-x-40mm/ $13.00 3 $39.00
* OpenBuilds Dual V Wheel Kit - Delrin http://openbuildspartstore.com/openbuilds-dual-v-wheel-kit-delrin/ $3.85 12 $46.20
* V-Slot Universal Plate http://openbuildspartstore.com/v-slot-universal-plate/ $12.00 3 $36.00
* Eccentric Spacers http://openbuildspartstore.com/eccentric-spacers/ $2.00 6 $12.00

Sub Total: $133.20

### Open Rail Based
TBD

### Notes
You can use a printed carriage for each tower, saving about $30
The printed carriages do not need the eccentric spacers saving $12

## Assembly

TBD



