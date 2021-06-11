import 'package:flutter/material.dart';

import 'package:foil/foil.dart';
import 'package:spectrum/spectrum.dart';

final color = Color(0xFFBB3399);

void main() => runApp(const ExampleFrame());

/// [MaterialApp] frame.
class ExampleFrame extends StatelessWidget {
  /// [MaterialApp] frame.
  const ExampleFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Example(),
        themeMode: ThemeMode.light,
        theme: ThemeData(
            primarySwatch: Spectrum.materialColor(
          color,
          mode: Blend.range,
        )),
      );
}

/// Construct a [new Example] `Widget` to fill an [ExampleFrame].
class Example extends StatelessWidget {
  /// Fill an [ExampleFrame] with a [Scaffold] and [AppBar] whose body is a
  /// [PageView]. The `children` of this swiping page view are each built by
  /// [buildView].
  const Example({Key? key}) : super(key: key);

  /// One entire page for a [PageView]. Comprised of a [SingleChildScrollView]
  /// and a [Column].
  Widget buildView({
    required MaterialColor color,
    required MaterialColor color2,
    required MaterialColor color3,
    required String subtitle,
  }) =>
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Text(
              'Spectrum.',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(height: 25),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 25),
            const Text(
              'Blend.range',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Container(width: 500, height: 25, color: color),
            Wrap(children: <Widget>[
              for (var box in List.generate(
                  10,
                  (index) => Container(
                        width: 75,
                        height: 75,
                        margin: const EdgeInsets.all(15.0),
                        color: index == 0 ? color[50] : color[100 * index],
                      )))
                box,
            ]),
            const SizedBox(height: 25),
            const Text(
              'Blend.shaded',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Container(width: 500, height: 25, color: color2),
            Wrap(children: <Widget>[
              for (var box in List.generate(
                  10,
                  (index) => Container(
                        width: 75,
                        height: 75,
                        margin: const EdgeInsets.all(15.0),
                        color: index == 0 ? color2[50] : color2[100 * index],
                      )))
                box,
            ]),
            const SizedBox(height: 25),
            const Text(
              'Blend.fade',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Container(width: 500, height: 25, color: color3),
            Wrap(children: <Widget>[
              for (var box in List.generate(
                  10,
                  (index) => Container(
                        width: 75,
                        height: 75,
                        margin: const EdgeInsets.all(15.0),
                        color: index == 0 ? color3[50] : color3[100 * index],
                      )))
                box,
            ]),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    const steps = LinearSteps(
      // begin: Alignment.topLeft,
      // end: Alignment.bottomRight,
      // softness: 0.001,
      colors: [Colors.cyan, Colors.pink, Colors.lightGreen, Colors.amber],
      stops: [0.15, 0.75, 0.85, 1.0],
    );

    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      // backgroundColor: Color.fromARGB(
      //     Spectrum.alphaFromStrength(20) ?? color.alpha,
      //     color.red,
      //     color.green,
      //     color.blue),
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('spectrum')),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        children: [
          const TestFoil(),
          buildView(
            color: Spectrum.materialColor(
              color,
              mode: Blend.range,
              // factor: 350,
            ),
            color2: Spectrum.materialColor(
              color,
              mode: Blend.shade,
              // factor: 0.75,
            ),
            color3: Spectrum.materialColor(
              color,
              mode: Blend.fade,
              // factor: -50,
            ),
            subtitle: 'materialColor',
          ),
        ],
      ),
    );
  }
}

class TestFoil extends StatefulWidget {
  const TestFoil({Key? key}) : super(key: key);

  @override
  _TestFoilState createState() => _TestFoilState();
}

class _TestFoilState extends State<TestFoil> {
  bool isUnwrapped = false;

  @override
  Widget build(BuildContext context) {
    // final gradient = LinearSteps(
    final gradient = RadialSteps(
      center: Alignment.topLeft,
      // softness: 0.05,
      colors: [
        Colors.cyan,
        Colors.blue[900]!,
        Colors.pink,
        Colors.red[900]!,
        Colors.lightGreen,
        Colors.green[900]!,
        Colors.amber,
        Colors.red[300]!,
      ],
      // begin: Alignment.topLeft,
      // end: Alignment.bottomLeft,

      // focal: Alignment.center,
      // stops: [0, 0.15, 0.75, 0.85],
    );
    final unwrappedGradient =
        //
        // LinearGradient(
        SweepGradient(
      // RadialGradient(
      // softness: 0.1,
      center: Alignment.topCenter,
      colors: [
        Colors.red[300]!,
        Colors.amber,
        Colors.green[900]!,
        Colors.lightGreen,
        Colors.cyan,
        Colors.blue[900]!,
        Colors.pink,
        Colors.red[900]!,
      ],
      // stops: [0.15, 0.75, 0.85, 1.0],
    );

    // final gradient = RadialSteps(
    //   center: Alignment.topCenter,
    //   colors: [
    //     Colors.cyan,
    //     Colors.blue[900]!,
    //     Colors.pink,
    //     Colors.red[900]!,
    //     Colors.lightGreen,
    //     Colors.green[900]!,
    //     Colors.amber,
    //     Colors.red[300]!,
    //   ],
    // );
    // final unwrappedGradient = IntermediateGradient(
    //     gradient.runtimeType,
    //     GradientPacket(gradient, gradient, 0),
    //     PrimitiveGradient.from(gradient));

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GestureDetector(
        onTap: () => setState(() => isUnwrapped = !isUnwrapped),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Foil(
              isUnwrapped: isUnwrapped,
              duration: const Duration(milliseconds: 1500),
              speed: const Duration(milliseconds: 2500),
              curve: Curves.elasticOut,
              gradient: gradient,
              // gradient: unwrappedGradient,
              unwrappedGradient: unwrappedGradient,
              child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white)),
            ),
            // Row(
            //   children: [
            //     Flexible(
            //       child: Text('gradient.stops: ${gradient.stops}',
            //           style: const TextStyle(fontSize: 36)),
            //     ),
            //     Flexible(
            //       child: Text(
            //           'unwrappedGradient.stops: ${unwrappedGradient.stops}',
            //           style: const TextStyle(fontSize: 36)),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
