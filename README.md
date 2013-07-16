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

BoM
---

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

### Extrusion
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
* 6x 370mm square carbon fiber tubing if using the endcaps to join
  with traxas joints, or round tubing as per Kossel
* plenty of t nuts and M5 bolts... lengths TBD


Sourcing
--------

TBD

Assembly
--------

TBD



