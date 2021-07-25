import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spectrum/spectrum.dart';

/// Create a [new GenerateComplements] and provide a required [color] and
/// [count] to return a [SingleChildScrollView] with [Wrap]ped containers
/// that are padded and progress in color through the `List<Color>` formed
/// by `color.complementary(count)`.
class GenerateComplements extends StatelessWidget {
  /// A column of color squares demonstrating the
  /// `Color.complementary()` method.
  ///
  /// Also consider getters such as `Color.complementPair` or
  /// `Color.complementTetrad`.
  const GenerateComplements(this.color, this.count, {Key? key})
      : super(key: key);
  final Color color;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(children: [
        for (var c in color.complementary(count))
          Container(
            width: 60,
            height: 60,
            // width: 120,
            // height: 120,
            margin: const EdgeInsets.all(7),
            color: c,
          )
      ]),
    );
  }
}

/// Create a [new Palette] as a self-contained and -defined array of color
/// squares that show each [SwatchMode] option. Furthermore, an intrinsic
/// [Timer.periodic] triggers a rebuild so that a new random color may be
/// demonstrated every 1.5s.
class Palette extends StatefulWidget {
  /// A full page demonstrating the various [SwatchMode] options for use in
  /// the generation of [MaterialColor]s by spectrum.
  ///
  /// The color is randomly obtained in the build method by `var color`
  /// utilizing [ColorOperators] "or" operator. This "or" is triggered with
  /// every rebuild by `timer`.
  const Palette({Key? key}) : super(key: key);

  @override
  _PaletteState createState() => _PaletteState();
}

class _PaletteState extends State<Palette> {
  late Timer timer;

  Center? labelOr(int index) => index == 0 || index == 5 || index == 9
      ? Center(
          child: Text(
            index == 0
                ? '50'
                : index == 5
                    ? '500'
                    : '900',
            style: TextStyle(
                color: index == 0 ? Colors.grey : Colors.white, fontSize: 26),
          ),
        )
      : null;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1500),
        (timer) => timer.isActive ? setState(() {}) : null);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Colors.red |
        [
          Colors.blue,
          Colors.green,
          Colors.purple,
          Colors.amber,
          const Color(0xFFFF00AA)
        ];

    final color0 = Spectrum.materialColor(
      color,
      mode: SwatchMode.shade,
      factor: 200,
    );
    final color0a = Spectrum.materialAccent(
      color,
      mode: SwatchMode.shade,
      factor: 200,
    );
    final color1 = Spectrum.materialColor(
      color,
      mode: SwatchMode.desaturate,
      // factor: 0.2, // override opacity/alpha
    );
    final color1a = Spectrum.materialAccent(
      color,
      mode: SwatchMode.desaturate,
      // factor: 0.2, // override opacity/alpha
    );
    final color2 = Spectrum.materialColor(
      color,
      mode: SwatchMode.fade,
    );
    final color2a = Spectrum.materialAccent(
      color,
      mode: SwatchMode.fade,
    );
    final color3 = Spectrum.materialColor(
      color,
      mode: SwatchMode.complements,
    );
    final color3a = Spectrum.materialAccent(
      color,
      mode: SwatchMode.complements,
    );

    List<Widget> buildPalette(List<Color> colors) {
      return <Widget>[
        for (var box in List.generate(
            colors.length,
            (index) => Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(5.0),
                  color: colors[index],
                  child: labelOr(index),
                )))
          box,
      ];
    }

    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const Text(
                  'MaterialColors',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                // const SizedBox(height: 25),
                // const Text(
                //   'materialColor()',
                //   style: TextStyle(fontSize: 20, color: Colors.white),
                // ),

                ///
                const SizedBox(height: 25),
                const Text(
                  'SwatchMode.shade\nfactor: 200',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 290,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color0.asList)),
                ),
                Wrap(children: buildPalette(color0.asList)),

                ///
                const SizedBox(height: 25),
                const Text(
                  'SwatchMode.desaturate',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Container(
                  width: 290,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color1.asList)),
                ),
                Wrap(children: buildPalette(color1.asList)),

                ///
                const SizedBox(height: 25),
                const Text(
                  'SwatchMode.fade',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Container(
                  width: 290,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color2.asList)),
                ),
                Wrap(children: buildPalette(color2.asList)),

                ///
                const SizedBox(height: 25),
                const Text(
                  'SwatchMode.complements',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Container(
                  width: 290,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color3.asList)),
                ),
                Wrap(children: buildPalette(color3.asList)),
              ],
            ),
          ),

          ///
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///
                const SizedBox(height: 28),
                const Text(
                  'MaterialAccentColors',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),

                ///
                const SizedBox(height: 30),
                const Text(
                  'SwatchMode.shade\nfactor: 200',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 170,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color0a.asList)),
                ),
                Wrap(children: buildPalette(color0a.asList)),

                ///
                const SizedBox(height: 30),
                const Text(
                  'SwatchMode.desaturate',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Container(
                  width: 170,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color1a.asList)),
                ),
                Wrap(children: buildPalette(color1a.asList)),

                ///
                const SizedBox(height: 30),
                const Text(
                  'SwatchMode.fade',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Container(
                  width: 170,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color2a.asList)),
                ),
                Wrap(children: buildPalette(color2a.asList)),

                ///
                const SizedBox(height: 25),
                const Text(
                  'SwatchMode.complements',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Container(
                  width: 170,
                  height: 25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: color3a.asList)),
                ),
                Wrap(children: buildPalette(color3a.asList)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
