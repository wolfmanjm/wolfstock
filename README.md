wolfstock
=========

__NOTE__ This is a Work In Progress

__NOTE__ The old T frame/Ostoc version of this has been deprecated and can be found in the branch [tframe](https://github.com/wolfmanjm/wolfstock/tree/tframe)


A 3d Delta printer based on the Mini-Kossel but using 2040 Makerslide for the
towers and the carriages, and accomodating larger bed and height.

* [Githubiverse page](http://wolfmanjm.github.com/wolfstock)
* [First Print](http://www.youtube.com/watch?v=khotvR7Lyf4)
* [Printing Tornado vase](http://www.youtube.com/watch?v=ChUlHnQ6QRw)
* [Printing](http://youtu.be/xLpwUxT9Mxs)
* [Swirling Urn print](http://flic.kr/p/fC9EcJ)
* [GT2 driven tower and printed carriage](http://youtu.be/qPsmmmQ1G40)

This is a Makerslide and Misumi based frame, using Spectra fishing
line drive ala original Kossel, or gt2 belts with crown pulleys.

It has a large frame made from 2040 and 2020 Misumi extrusion using
mini-kossel style printed brackets.

The default version has 1000mm high Makerslide towers, an 463.4mm triangle
sides, and arm length of 370mm, which makes for a roughly 250mm circular build
area using Traxxas joints and 400mm build height. Use the Kossel Calculator
and the lite-frame.scad to play with the exact lengths required. If you were
to use mag arms which have more degrees of movement the build area would be
around 350mm diameter for the above dimensions.

The drive system can use Spectra 60lb braided fishing line and machined spools
and 608 bearings for the idlers.

There is an alternate set of stls that make use of gt2 belt. In this case the
preferred idler is composed of two back to back 695 flanged bearings and the
`tensioner-gt2-F695zz.stl` file, but there is also a `crownedpulley.stl` that fits
over a 608 bearing and the file `tensioner_g2_608.stl` will house that. I have
found that the crowned pulleys do not seem to keep the belt aligned as they
are supposed to.

Most scad source files are parameterized so the dimensions can be
tweaked.

Some of the scad files are derived from Kossel files or other scad files, most
are original designs. The original source of the file is usually cited in the
code.

This work is licensed under the Creative Commons
Attribution-ShareAlike 3.0 Unported License. To view a copy of this
license, [visit](http://creativecommons.org/licenses/by-sa/3.0/)


## BoM

### Printed parts
Stls are in the
[STL directory](https://github.com/wolfmanjm/wolfstock/tree/master/stl)

* Print three `base-bracket-motor.stl`
* Print three `base-bracket-idler.stl`
* Print three `tensioner_608.stl` *OR* `tensioner_g2_608.stl` (also the `crownedpulley.stl` if using the latter) *OR* three `tensioner-gt2-F695zz.stl`
* Print one `effector.stl`
* Print three `carriage-new.stl` *OR* `gt2-carriage.stl` These bolt onto a carriage that has
  20mm hole paterns
  [like this](https://www.inventables.com/technologies/standard-wheel-carriage-plate),
  so check your plates and adjust the scad as necessary.
* Effector mounted extruder from http://www.thingiverse.com/thing:42112 with pg35l Stepper from http://www.ultibots.com/ (I use some aluminum stadoffs to raise the extruder about an inch.

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
  with traxas joints, or round tubing as per Kossel like these from
  [Goodwinds](http://goodwinds.com/20015.html), where the traxxas joints may slip in with some hot glue
* plenty of t nuts and M5 bolts...
  lengths M5x16 for the back 18 total, M5x12 for the sides 32 total


## Sourcing

### Common components

* Bottom side rails [Misumi][] HFS5-2040-500 $5.40 3 $16.20
* Top side rails  [Misumi][] HFS5-2020-500 $2.85 3 $8.55
* Bolts for back of towers M5 Length 16mm
* Bolts for side braces M5 Length 12mm
* T Nuts M4 100 pack  [Misumi][] HNKK5-5 $20

### Drive Mechanism

Choose one of the following...

#### Fishing Line
* Spectra 60lb braided fishing line
* [Drive spools](http://3d.grabercars.com/?product=filament-drive-reel-grooved-delrin-18mm-o-d-for-kossel) $7.95 3 $23.85
* 3x 608 bearings for idler, and use tensioner_608.stl

#### GT2 Belt
* [GT2 Belt](http://www.robotdigg.com/product/10/Open-Ended-6mm-Width-GT2-Belt) $2.00/meter approx 6.3-7 meters $14.00
* [GT2 toothed pulley 20 Teeth 5mm Bore](http://www.robotdigg.com/product/9/GT2-Pulley-20-Teeth-5mm-Bore) $2.00 3 $6.00
* 3x 608 bearings and use `tensioner_g2_608.stl` idler and `crownedpulley.stl` OR
  6x F695zz flanged bearings and use `tensioner-gt2-F695zz.stl`, the latter seems to work better, and are
  [available here](http://www.ebay.com/itm/180915657724) 10 for $9.67 free shipping
* [Grub screws for pulley](http://www.robotdigg.com/product/17/M3*4-Grub-Screw-PACK-SET-for-Timing-Pulleys) $0.35

### Makerslide based
* [Makerslide rail 1000mm](https://www.inventables.com/technologies/makerslide) 25142-03 $21.74 3 $65.52
* [Dual Bearing V-Wheel Kit](https://www.inventables.com/technologies/dual-bearing-v-wheel-kit) 25203-02 $4.85 12 $58.20
* [Eccentric Spacer](https://www.inventables.com/technologies/eccentric-spacer) 25195-01 $2.00 6 $12.00
* [Nylon Spacer pack of 10](https://www.inventables.com/technologies/nylon-natural-color-spacer) 25206-01 $2.00 1 $2.00
* [Standard Wheel Carriage Plate](https://www.inventables.com/technologies/standard-wheel-carriage-plate) 25200-01 $8.00 3 $24.00

Sub Total: $161.72

### V Slot based
* [V-Slot 20 x 40mm 1000mm](http://openbuildspartstore.com/v-slot-20-x-40mm/) $13.00 3 $39.00
* [OpenBuilds Dual V Wheel Kit - Delrin](http://openbuildspartstore.com/openbuilds-dual-v-wheel-kit-delrin/) $3.85 12 $46.20
* [V-Slot Universal Plate](http://openbuildspartstore.com/v-slot-universal-plate) $12.00 3 $36.00
* [Eccentric Spacers](http://openbuildspartstore.com/eccentric-spacers/) $2.00 6 $12.00

Sub Total: $133.20

### Open Rail Based
* 2040 1000mm  [Misumi][] HFS5-2040-1000 $10.80 3 $32.40
* [Open Rail 1000mm](http://openbuildspartstore.com/openrail-black-anodized/) $6 6 $36
* [OpenBuilds Dual V Wheel Kit - Delrin](http://openbuildspartstore.com/openbuilds-dual-v-wheel-kit-delrin/) $3.85 12 $46.20
* [OpenRail Gantry Plate 40mm](http://openbuildspartstore.com/openrail-gantry-plate-universal-mount) $8.00 3 $24.00
* [Eccentric Spacers](http://openbuildspartstore.com/eccentric-spacers/) $2.00 6 $12.00

Sub Total: $150.60

### Printed carriage for Makerslide or Open Rail
For the cheapeast solution print `carriage-plate.stl` and just buy the v wheels.
This saves having to get the expensive aluminum plates and eccentric spacers.
That saves $36 on the open rail version and a lt more on the makerslide version.

* [OpenBuilds Dual V Wheel Kit - Delrin](http://openbuildspartstore.com/openbuilds-dual-v-wheel-kit-delrin/) $3.85 12 $46.20


### Notes
You can use the printed carriage for each tower, saving about $36 or more


## Assembly

1. Bolt the side rails in first to form the triangle. Remember to put
enough tslot nuts in the tslots first, also put some in the top and
side for mounting things later.
2. Mount the motors next.
3. Insert the Makerslide into the holes, use a rubber mallet to get the corners on the makerslide, but be gentle.
4. bolt the makerslide from the back.
5. do the same for the top, but remember to put the idlers in the track first


# License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

[Misumi]: http://www.misumi-ec.com "Misumi"
