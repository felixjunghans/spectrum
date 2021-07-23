import 'package:flutter/material.dart';

import 'package:foil/foil.dart';
import 'package:spectrum/spectrum.dart';

import 'palette.dart';

// ignore_for_file: public_member_api_docs

// const color = Color(0xFFBB3399);
// const color = Color(0xFFFF0000);
const color = Color(0xFFFF61ED);
// const color = Color(0xFF00AA33);
// const color = Color(0xFF3F82D3);
// const color = Color(0x72A46565);
// const color = Color(0xFFFC5C74);

void main() => runApp(const ExampleFrame());

/// [MaterialApp] frame.
class ExampleFrame extends StatelessWidget {
  /// [MaterialApp] frame.
  const ExampleFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Example(),
        // home: const Palette(),
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Spectrum.materialColor(
            color.withOpacity(1),
            mode: SwatchMode.shade,
          ),
        ),
      );
}

/// Construct a [new Example] `Widget` to fill an [ExampleFrame].
class Example extends StatefulWidget {
  /// Fill an [ExampleFrame] with a [Scaffold] and [AppBar] whose body is a
  /// [PageView].
  ///
  /// Also constructs the `final gradient`s to provide to other demo objects.
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    // final gradient = LinearGradient(
    final gradient = RadialGradient(
      // final gradient = SweepGradient(
      // final gradient = LinearSteps(
      // final gradient = RadialSteps(
      // final gradient = SweepSteps(
      // final gradient = LinearShadedSteps(
      // final gradient = RadialShadedSteps(
      // final gradient = SweepShadedSteps(
      //
      center: const Alignment(0.5, -0.75),
      // tileMode: TileMode.decal,
      // stops: const [0.15, 0.25, 0.3, 0.75, 0.85],
      // colors: color.asMaterialColor.asList,
      colors: Spectrum.materialColor(color, mode: SwatchMode.shade, factor: 450)
          .asList,
      // colors: color.generateComplements(5),
      // colors: color.generateComplements(18),
      // colors: color.generateComplements(36),
    );

    final gradient2 = SweepShadedSteps(
      center: const Alignment(-0.3, -1.25),
      colors: color.generateComplements(18),
      // shadeFunction: Shades.withAlpha,
      // softness: 0.005,
      // shadeFactor: 175,
      shadeFactor: -150,
    );

    final radialSteps = RadialSteps(colors: color.generateComplements(18));
    final linearSteps =
        LinearSteps(colors: (const Color(0xFF4BFF6F)).generateComplements(5));
    final sweepSteps =
        SweepSteps(colors: (const Color(0xFF71F2F0)).generateComplements(4));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('spectrum')),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        children: [
          // /// Fast shading
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: RadialShadedSteps(
          //       colors: color.asMaterialColor.asList, // fast shading
          //       radius: 1.0,
          //     ),
          //   ),
          // ),

          /// Header "spectrum"
          const Header(),

          /// Full-page `Foil`-based `GradientTween` when tapped.
          /// See [Foil] to understand why there should at least be a black
          /// rectangle (`Container`) onto which to mask the `Foil`'s gradient.
          TestFoilTween(
            gradient,
            gradient2,
            isAgressive: true,
            isSlow: false,
            child: Container(color: Colors.black),
          ),
          TestFoilTween(
            gradient,
            gradient2,
            isAgressive: true,
            isSlow: true,
            child: Container(color: Colors.black),
          ),

          /// Same as above, one fast and one slow, but flag `isAgressive` is disabled. //
          // TestFoilTween(gradient0, gradient1, isAgressive: false, isSlow: false, child: Container(color: Colors.black),), //
          // TestFoilTween(gradient0, gradient1, isAgressive: false, isSlow: true, child: Container(color: Colors.black),), //

          /// Steps.softness demonstration
          Column(
            children: <Widget>[
              Flexible(
                child: AnimatedFoilDemo(
                  radialSteps,
                  isSlow: false,
                  isAgressive: true,
                  storyboard: _defaultStoryboard,
                ),
              ),
              Flexible(
                child: AnimatedFoilDemo(
                  linearSteps,
                  isSlow: false,
                  isAgressive: true,
                  storyboard: _defaultStoryboard,
                ),
              ),
              Flexible(
                child: AnimatedFoilDemo(
                  sweepSteps,
                  isSlow: false,
                  isAgressive: true,
                  storyboard: _defaultStoryboard,
                ),
              ),
            ],
          ),

          /// FooShadedSteps.shadeFactor demonstration
          AnimatedFoilDemo(
            LinearShadedSteps(
              colors: (const Color(0xFF4BFF6F)).generateComplements(4),
            ),
            isSlow: false,
            isAgressive: true,
            storyboard: {
              /// "tweenSpec" expects a [TweenSpec], which itself is a
              /// `Map<GradientProperty, Tween<dynamic>>`.
              GradientAnimation.tweenSpec: {
                GradientProperty.shadeFactor: StepTween(begin: -200, end: 200),
              },
            },
          ),

          /// A column of color squares demonstrating the
          /// `Color.generateComplements()` method.
          const Palette(),

          /// A column of color squares demonstrating the
          /// `Color.generateComplements()` method.
          ///
          /// Also consider getters such as `Color.complementPair` or
          /// `Color.complementTetrad`.
          SingleChildScrollView(
              child: Column(children: const [
            SizedBox(height: 25),
            GenerateComplements(color, 1),
            GenerateComplements(color, 2),
            GenerateComplements(color, 3),
            SizedBox(height: 25),
            GenerateComplements(color, 4),
            GenerateComplements(color, 5),
            GenerateComplements(color, 6),
            SizedBox(height: 25),
            GenerateComplements(color, 36),
          ])),

          /// A `GradientTween` frozen in time for granular keyframe inspection.
          // Lerping(gradient, unwrappedGradient),
        ],
      ),
    );
  }
}

Animatable<Color?> colors = TweenSequence<Color?>([
  TweenSequenceItem<Color?>(
    weight: 1.0,
    tween: ColorTween(begin: Colors.red, end: Colors.blue),
    // tween: Tween<Color>(begin: Colors.red, end: Colors.blue),
  ),
  TweenSequenceItem<Color?>(
    weight: 1.0,
    tween: ColorTween(begin: Colors.blue, end: Colors.green),
    // tween: Tween<Color>(begin: Colors.blue, end: Colors.green),
  ),
  TweenSequenceItem<Color?>(
    weight: 1.0,
    tween: ColorTween(begin: Colors.green, end: Colors.yellow),
    // tween: Tween<Color>(begin: Colors.green, end: Colors.yellow),
  ),
  TweenSequenceItem<Color?>(
    weight: 1.0,
    tween: ColorTween(begin: Colors.lightBlue, end: Colors.purple),
    // tween: Tween<Color>(begin: Colors.blue, end: Colors.green),
  ),
  TweenSequenceItem<Color?>(
    weight: 1.0,
    tween: ColorTween(begin: Colors.purple, end: Colors.amber),
    // tween: Tween<Color>(begin: Colors.green, end: Colors.yellow),
  ),
  TweenSequenceItem<Color?>(
    weight: 1.0,
    tween: ColorTween(begin: Colors.amber, end: Colors.red),
    // tween: Tween<Color>(begin: Colors.yellow, end: Colors.red),
  ),
]);

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..repeat(reverse: true);

    _color = colors.animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ShaderMask(
        // shaderCallback: (bounds) => GradientTween(
        //   begin: RadialShadedSteps(
        //     // colors: _color.value!.generateComplements(10),
        //     colors: _color.value!.asMaterialColor.asList,
        //     radius: 4,
        //     shadeFactor: 200,
        //   ),
        //   end: LinearGradient(
        //     colors: _color.value!.withWhite(50).generateComplements(6),
        //   ),
        //   isAgressive: false,
        // ).evaluate(_controller)!.createShader(bounds),
        shaderCallback: (bounds) => AnimatedGradient(
          controller: _controller,
          gradient: GradientTween(
            begin: RadialShadedSteps(
              // colors: _color.value!.generateComplements(10),
              colors: _color.value!.asMaterialColor.asList,
              radius: 4,
              shadeFactor: 200,
            ),
            end: LinearGradient(
              colors: _color.value!.withWhite(50).generateComplements(6),
            ),
            isAgressive: false,
          ).evaluate(_controller)!,
          storyboard: {
            // GradientAnimation.colorArithmetic: Shades.withOpacity,
            // GradientAnimation.stopsArithmetic: Maths.addition,
            GradientAnimation.tweenSpec: {
              GradientProperty.center: Tween<AlignmentGeometry?>(
                begin: const Alignment(-0.75, -0.75),
                end: const Alignment(5.75, 5.75),
              ),
              // GradientProperty.distance: Tween<double>(
              //   begin: 0,
              //   end: 1,
              // ),
            }
          },
        ).observe.createShader(bounds),
        child: const Text(
          ' spectrum ',
          style: TextStyle(
            fontSize: 400,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

final _defaultStoryboard = {
  // GradientAnimation.none: null,

  /// "colorArithmetic" expects a [ColorArithmetic].
  // GradientAnimation.colorArithmetic: Shades.withOpacity,

  /// "stopsArithmetic" expects a [StopsArithmetic].
  // GradientAnimation.stopsArithmetic: Maths.subtraction,
  // GradientAnimation.stopsArithmetic:Maths.addition,
  // GradientAnimation.stopsArithmetic:Maths.division,

  /// "tweenSpec" expects a [TweenSpec], which itself is a
  /// `Map<GradientProperty, Tween<dynamic>>`.
  GradientAnimation.tweenSpec: {
    // GradientProperty.center: Tween<AlignmentGeometry>(
    //     begin: const Alignment(1, 1),
    //     end: const Alignment(-1, -1)),
    // GradientProperty.focal: Tween<AlignmentGeometry>(
    //     begin: const Alignment(3, -1),
    //     end: const Alignment(-3, -1)),
    // GradientProperty.radius:
    //Tween<double>(begin: 0.5, end: 0),
    // GradientProperty.focalRadius:
    // Tween<double>(begin:2,end:0),
    // // GradientProperty.startAngle: Tween<double>(
    // // begin: -1.0 * 3.1415927, end: 0.0 * 3.1415927),
    // // GradientProperty.endAngle:
    // // Tween<double>(begin: 2.0 * 3.1415927,end: 4.0 * 3.1415927),
    // GradientProperty.shadeFactor:
    //StepTween(begin: -200,end:0),
    GradientProperty.softness: Tween<double>(begin: 0, end: 0.14),
  },
};

class AnimatedFoilDemo extends StatefulWidget {
  const AnimatedFoilDemo(
    this.gradient, {
    Key? key,
    this.storyboard,
    required this.isSlow,
    required this.isAgressive,
    this.duration = const Duration(seconds: 2),
    this.interval = const Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
    this.child,
  }) : super(key: key);

  final Gradient gradient;
  final GradientStoryboard? storyboard;
  final Duration duration;
  final Interval interval;
  final bool isSlow, isAgressive;
  final Widget? child;

  @override
  _AnimatedFoilDemoState createState() => _AnimatedFoilDemoState();
}

class _AnimatedFoilDemoState extends State<AnimatedFoilDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isUnwrapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _controller.reverse();
        if (status == AnimationStatus.dismissed) _controller.forward();
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = CurvedAnimation(
      // Default duration is 2 seconds
      parent: _controller,
      // Default interval will hold state at initial position for
      // 30% of the duration as `Interval(0.3, 1.0, curve...)`
      curve: widget.interval,
    );

    return Foil(
      isUnwrapped: isUnwrapped,
      isAgressive: widget.isAgressive,
      useSensor: false,
      duration: widget.isSlow
          ? const Duration(milliseconds: 3000)
          : const Duration(milliseconds: 1500),
      curve: widget.isSlow ? Curves.linear : Curves.elasticOut,
      speed: widget.isSlow
          ? const Duration(milliseconds: 200)
          : const Duration(milliseconds: 1500),
      gradient: widget.gradient.animate(
        controller: controller,

        /// A [GradientStoryboard] is a
        /// `Map<GradientAnimation, dynamic>` where dynamic values are
        /// description objects that are type-checked according to
        /// their key.
        storyboard: widget.storyboard ?? _defaultStoryboard,
      ),
      unwrappedGradient:
          widget.gradient.reversed.copyWith(radius: 0.025).animate(
                controller: controller,
                storyboard: widget.storyboard ?? _defaultStoryboard,
              ),
      child: GestureDetector(
        onTap: () => setState(() => isUnwrapped = !isUnwrapped),
        child: Center(
          child: widget.child ??
              Container(color: Colors.white), // White for Foil masking
        ),
      ),
    );
  }
}

class TestFoilTween extends StatefulWidget {
  const TestFoilTween(
    this.gradient,
    this.unwrappedGradient, {
    Key? key,
    required this.isSlow,
    required this.isAgressive,
    this.child,
  }) : super(key: key);

  final Gradient gradient, unwrappedGradient;
  final bool isSlow, isAgressive;
  final Widget? child;

  @override
  _TestFoilTweenState createState() => _TestFoilTweenState();
}

class _TestFoilTweenState extends State<TestFoilTween> {
  bool isUnwrapped = false;

  @override
  Widget build(BuildContext context) {
    var foil = Foil(
      isUnwrapped: isUnwrapped,
      isAgressive: widget.isAgressive,
      gradient: widget.gradient,
      unwrappedGradient: widget.unwrappedGradient,
      blendMode: BlendMode.plus,
      speed: widget.isSlow
          ? const Duration(milliseconds: 200)
          : const Duration(milliseconds: 1500),
      duration: widget.isSlow
          ? const Duration(milliseconds: 3000)
          : const Duration(milliseconds: 1500),
      curve: widget.isSlow ? Curves.linear : Curves.elasticOut,
      child: widget.child ??
          const DecoratedBox(
            decoration: BoxDecoration(color: Colors.white),
          ),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GestureDetector(
        onTap: () => setState(() => isUnwrapped = !isUnwrapped),
        child: Stack(fit: StackFit.expand, children: [foil]),
      ),
    );
  }
}

class Lerping extends StatelessWidget {
  const Lerping(this.gradient1, this.gradient2, {Key? key}) : super(key: key);

  final Gradient gradient1, gradient2;

  @override
  Widget build(BuildContext context) {
    // final test = gradient;
    // final test = gradient.asGradient;
    // final test = unwrappedGradient.asGradient;

    const t = 0.0;
    // ignore: unused_local_variable
    final interpolated =
        PrimitiveGradient.fromStretchLerp(gradient1, gradient2, t);

    // ignore: unused_local_variable
    final intermediate = IntermediateGradient(
      PrimitiveGradient.fromStretchLerp(gradient1, gradient2, t),
      // PrimitiveGradient.interpolateFrom(gradient, unwrappedGradient, 1.0),
      GradientPacket(gradient1, gradient2, t),
      // GradientPacket(gradient, unwrappedGradient, 1.0),
      // PrimitiveGradient.interpolateFrom(test, unwrappedGradient, 0.0),
      // GradientPacket(test, unwrappedGradient, 0.0),
    );

    final tween = GradientTween(
      begin: gradient1,
      // begin: intermediate,
      // begin: test,
      // end: const LinearGradient(colors: [Colors.green, Colors.blue]),
      end: gradient2,
      // isAgressive: false,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Center(
        //   child: Container(
        //     width: 1460,
        //     height: 825 / 5,
        //     decoration: BoxDecoration(gradient: gradient),
        //   ),
        // ),
        Center(
          child: Container(
            width: 1460,
            height: 825 / 3,
            // height: 825 / 5,
            decoration: BoxDecoration(gradient: gradient1),
          ),
        ),
        Center(
          child: Container(
            width: 1460,
            height: 825 / 3,
            // height: 825 / 5,
            // decoration:
            //   BoxDecoration(gradient: unwrappedGradient.asGradient),
            decoration: BoxDecoration(gradient: gradient2),
          ),
        ),
        Center(
          child: Container(
            width: 1460,
            height: 825 / 3,
            // height: 825 / 5,
            decoration: BoxDecoration(gradient: tween.lerp(0)),
          ),
        ),
        // Center(
        //   child: Container(
        //     width: 1460,
        //     height: 825 / 5,
        //     decoration: BoxDecoration(gradient: tween.lerp(0.0)),
        //     // decoration: BoxDecoration(
        //     //     gradient: Gradient.lerp(gradient, unwrappedGradient, 0)),
        //     // gradient.asGradient, unwrappedGradient.asGradient, 0)),
        //   ),
        // ),
      ],
    );
  }
}
