///
library spectrum;

// import 'dart:collection' as collection;
import 'dart:math' as math;
import 'dart:ui' as ui;

import '../common.dart';
import '../gradients/steps.dart';

/// Receiving a potentially `null` list of [stops] and a concrete list of
/// [colorCount] (which may be empty):
/// - immediately return [stops] if non-`null`
/// - if [colorCount] is empty, return an empty list to match
/// - return an interpreted list of stops by creating a stop entry `s` for every
///   entry in [colorCount] as `s / colors.length` beginning at `s == 1`.
///   - resultant list will *not* begin with a `0` but *will* end in `1`
List<double> interpretStops(List<double>? stops, int colorCount) {
  assert(colorCount > 1);
  if (stops != null) return stops;
  // final len = colors.length;
  // var impliedStops = <double>[];
  // for (var s = 0; s < len; s++) {
  //   impliedStops.add(s / len);
  // }
  // return impliedStops;

  final separation = 1.0 / (colorCount - 1);
  return List<double>.generate(
    colorCount,
    (int index) => index * separation,
    growable: false,
  );
}

// List<double> lerpList(List<double>? a, List<double>? b, double t) {
//   a ??= <double>[];
//   b ??= <double>[];
//   final commonLength = math.min(a.length, b.length);
//   return <double>[
//     for (int i = 0; i < commonLength; i++) ui.lerpDouble(a[i], b[i], t)!,
//     // if (t < 0.5)
//     //   for (int i = commonLength; i < a.length; i++) a[i],
//     // if (t > 0.5)
//     //   for (int i = commonLength; i < b.length; i++) b[i],
//   ];
// }

/// The most basic representation of a gradient.
@immutable
class PrimitiveGradient {
  /// The most basic representation of a gradient: \
  /// `List<Color>` and `List<Stops>`.
  const PrimitiveGradient._(this.colors, this.stops);

  // /// Interpolate two `List`s of `Color` *and* `double` stops at `t`. \
  // /// Supports fewer `Color`s than the standard gradient.
  // factory PrimitiveGradient.from(Gradient gradient) => PrimitiveGradient._(
  //   gradient.colors, interpretStops(gradient.stops, gradient.colors.length));

  /// Interpolate two `List`s of `Color` *and* `double` stops at `t`. \
  /// Supports fewer `Color`s than the standard gradient.
  factory PrimitiveGradient.interpolateFrom(Gradient a, Gradient b, double t) {
    final stops = t < 0.5
        ? (a is Steps)
            ? (List<double>.from(interpretStops(a.stops, a.colors.length + 1))
              ..removeLast())
            : interpretStops(a.stops, a.colors.length)
        : (b is Steps)
            ? (List<double>.from(interpretStops(b.stops, b.colors.length + 1))
              ..removeLast())
            : interpretStops(b.stops, b.colors.length);
    final colors = t < 0.5 ? a.colors : b.colors;

    // if (aColors == null || aColors.isEmpty) {
    //   aColors = [Colors.transparent, Colors.transparent];
    // }
    // final aStops = interpretStops(a.stops, a.colors.length);

    // if (bColors == null || bColors.isEmpty) {
    //   bColors = [Colors.transparent, Colors.transparent];
    // }
    // final bStops = interpretStops(b.stops, b.colors.length);

    // final stops = collection.SplayTreeSet<double>()
    //   ..addAll(aStops)
    //   ..addAll(bStops);
    // final interpolatedStops = stops.toList(growable: false);
    // final interpolatedStops = <double>[];
    // // final interpolatedStops = stops.toList(growable: false);
    // // if (t < 0.5) {
    // if (t < 0.33) {
    //   interpolatedStops.addAll(aStops);
    //   // } else if (t < 0.4) {
    //   //   for (var i = 0; i < stops.toList().length; i++) {
    //   //     if (i.isEven) interpolatedStops.add(stops.toList()[i]);
    //   //   }
    // } else if (t < 0.66) {
    //   interpolatedStops.addAll(stops.toList());
    //   // } else if (t < 0.8) {
    //   //   for (var i = 0; i < stops.toList().length; i++) {
    //   //     if (i.isOdd) interpolatedStops.add(stops.toList()[i]);
    //   //   }
    // } else {
    //   interpolatedStops.addAll(bStops);
    // }
    // final interpolatedStops = lerpList(aStops, bStops, t);
    // final interpolatedColors = interpolatedStops
    //     .map<Color>((double stop) => Color.lerp(
    //      sample(a.colors, aStops, stop), sample(b.colors, bStops, stop), t)!)
    //     .toList(growable: false);
    // assert(
    //   interpolatedColors.length == interpolatedStops.length,
    //   '${interpolatedColors.length},${interpolatedStops.length}',
    // );
    // return PrimitiveGradient._(interpolatedColors, interpolatedStops);
    return PrimitiveGradient._(colors, stops);
  }

  /// The colors of the true [Gradient] this `PrimitiveGradient` represents.
  final List<Color> colors;

  /// The stops of the true [Gradient] this `PrimitiveGradient` represents.
  final List<double> stops;

  // /// Calculate the color at position [t] of the gradient
  // /// defined by [colors] and [stops]. \
  // /// Modified from vanilla [Gradient] `_sample()` to support fewer `Color`s.
  // ///
  // /// This abstracts the color selection process from the gradient type itself.
  // static Color sample(List<Color> colors, List<double> stops, double t) {
  //   assert(colors.length == stops.length);

  //   /// Colors at beginning and ending of stops/gradient
  //   if (t <= stops.first) return colors.first;
  //   if (t >= stops.last) return colors.last;

  //   final index = stops.lastIndexWhere((double s) => s <= t);
  //   assert(index != -1);
  //   return Color.lerp(
  //     colors[index],
  //     colors[index + 1],
  //     (t - stops[index]) / (stops[index + 1] - stops[index]), // normalize 0..1
  //   )!;
  // }

  /// "Scaling" this gradient represents reducing the opacity of all its colors
  /// by [Color.lerp] with `null` using [factor] as the keyframe `t`.
  PrimitiveGradient scale(double factor) {
    final scaledColors = colors
        .map<Color>((Color color) => Color.lerp(null, color, factor)!)
        .toList(growable: false);
    return PrimitiveGradient._(scaledColors, stops);
  }
}

/// If a list of colors and list of stops makes a [PrimitiveGradient],
/// does this [GradientPacket] constitute a supergradient?
@immutable
class GradientPacket {
  /// If a list of colors and list of stops makes a [PrimitiveGradient],
  /// does this [GradientPacket] constitute a supergradient?
  ///
  /// {@template gradientpacket}
  /// This `Packet` holds onto two `Gradient`s and a `t` keyframe.
  ///
  /// When requesting any potential `Gradient` property other than colors or
  /// stops, this `Packet` may be called upon and will provide the relevant
  /// lerp at [t].
  ///
  /// If either gradient does not have the requested property, a default value
  /// is provided as per [GradientUtils].
  /// {@endtemplate}
  const GradientPacket(this.a, this.b, this.t);

  /// A [Gradient] that this `GradientPacket` stores and represents.
  ///
  /// This packet's getters will consider [t] and use an appropriate `lerp()`
  /// method to interpolate between gradient `a` and gradient `b`.
  final Gradient a, b;

  /// The keyframe for this `GradientPacket` for retrieving the properties
  /// of these respective [a] & [b] `Gradient`s using an appropriate `lerp()`
  /// method.
  ///
  /// A value of `t == 0` means this packet will return the properties of
  /// `Gradient` [a], while `t == 1` has this packet return the properties
  /// of `Gradient` [b].
  ///
  /// A `t` somewhere between `0..1` returns properties via this
  /// `GradientPacket`'s getters that represent the mixture of the respective
  /// property from [a] & [b] at a ratio that interprets `t` as a percentage
  /// between `a..b`.
  final double t;

  // UNIVERSAL
  /// {@template gradientpacket_getter}
  /// Returns the interpolation of this [Gradient] or [Gradient]-subclass
  /// property at keyframe [t] for gradients [a] and [b].
  ///
  /// See [GradientUtils] to understand how fallbacks are determined for
  /// subclasses that do not contain this property.
  /// {@endtemplate}
  GradientTransform? get transform => t < 0.5 ? b.transform : a.transform;

  /// {@macro gradientpacket_getter}
  TileMode get tileMode => t < 0.5 ? b.tileMode : a.tileMode;

  // LINEAR
  /// {@macro gradientpacket_getter}
  AlignmentGeometry get begin => AlignmentGeometry.lerp(a.begin, b.begin, t)!;

  /// {@macro gradientpacket_getter}
  AlignmentGeometry get end => AlignmentGeometry.lerp(a.end, b.end, t)!;

  // RADIAL or SWEEP
  /// {@macro gradientpacket_getter}
  AlignmentGeometry get center =>
      AlignmentGeometry.lerp(a.center, b.center, t)!;

  // RADIAL
  /// {@macro gradientpacket_getter}
  double get radius => ui.lerpDouble(a.radius, b.radius, t) ?? 0.0;

  /// {@macro gradientpacket_getter}
  AlignmentGeometry? get focal => AlignmentGeometry.lerp(a.focal, b.focal, t);

  /// {@macro gradientpacket_getter}
  double get focalRadius =>
      ui.lerpDouble(a.focalRadius, b.focalRadius, t) ?? 0.0;

  // SWEEP
  /// {@macro gradientpacket_getter}
  double get startAngle => ui.lerpDouble(a.startAngle, b.startAngle, t) ?? 0.0;

  /// {@macro gradientpacket_getter}
  double get endAngle => ui.lerpDouble(a.endAngle, b.endAngle, t) ?? 0.0;

  // STEPS
  /// {@macro gradientpacket_getter}
  double get softness => ui.lerpDouble(a.softness, b.softness, t) ?? 0.0;
}

/// Use a [new IntermediateGradient] as a stand-in between discrete forms
/// of [Gradient]s during tweens.
class IntermediateGradient extends Gradient {
  /// Considering the [type] to output, [packet] of potential properties
  /// from both of two gradients, and the [primitiveGradient] of colors and
  /// stops formed from those same two gradients: provide dynamic [createShader]
  /// method that considers all the above to create a [Shader] that best
  /// represents a mix of these two gradients.
  IntermediateGradient(
    this.type,
    this.packet,
    this.primitiveGradient,
  ) : super(
          colors: primitiveGradient.colors,
          stops: primitiveGradient.stops,
        );

  /// This determines the return type of the generated [Shader] from
  /// [createShader]. Interpreted within constructor by a `lerp()` method
  /// that provides a beginning gradient's type when that method's
  /// `t < 0.5` and providing the ending gradient's type after that.
  final Type type;

  /// The most basic representation of a [Gradient]: a list of colors and a
  /// list of stops.
  ///
  /// This object is created by factory [PrimitiveGradient.interpolateFrom]
  /// two lists of colors and two lists of stops that considers a keyframe `t`
  /// for interpolating between them.
  final PrimitiveGradient primitiveGradient;

  /// {@macro gradientpacket}
  final GradientPacket packet;

  @override
  Shader createShader(Rect rect, {TextDirection? textDirection}) {
    /// The lists should already be same length by this point, but something
    /// may have happened along the way through lerping or hot restarting
    /// that leaves a few cycles with dissimilar values.
    /// Secure their lengths here.
    assert(
      colors.length == stops?.length,
      'colors length: ${colors.length}, stops length: ${stops?.length}',
    );
    final commonLength =
        math.min(colors.length, stops?.length ?? colors.length);
    final securedStops = <double>[
      for (int i = 0; i < commonLength; i++) stops![i]
    ];

    return (type == RadialGradient
            ? RadialGradient(colors: colors)
            : type == SweepGradient
                ? SweepGradient(colors: colors)
                : type == LinearSteps
                    ? LinearSteps(colors: colors)
                    : type == RadialSteps
                        ? RadialSteps(colors: colors)
                        : type == SweepSteps
                            ? SweepSteps(colors: colors)
                            : LinearGradient(colors: colors))
        .copyWith(
          stops: securedStops,
          transform: packet.transform,
          tileMode: packet.tileMode,
          begin: packet.begin,
          end: packet.end,
          center: packet.center,
          radius: packet.radius,
          focal: packet.focal,
          focalRadius: packet.focalRadius,
          startAngle: packet.startAngle,
          endAngle: packet.endAngle,
          softness: packet.softness,
        )
        .createShader(rect, textDirection: textDirection);
  }

  @override
  IntermediateGradient scale(double factor) =>
      IntermediateGradient(type, packet, primitiveGradient.scale(factor));

  @override
  Gradient? lerpFrom(Gradient? a, double t) =>
      (a == null || (a is IntermediateGradient))
          ? IntermediateGradient.lerp(a as IntermediateGradient?, this, t)
          : super.lerpFrom(a, t);

  @override
  Gradient? lerpTo(Gradient? b, double t) =>
      (b == null || (b is IntermediateGradient))
          ? IntermediateGradient.lerp(this, b as IntermediateGradient?, t)
          : super.lerpTo(b, t);

  /// If both are `null`, returns `null`. \
  /// If `a == null`, returns `b!.scale(t)`. \
  /// If `b == null`, returns `a.scale(1.0 - t)`. \
  /// Else returns `a` before `t == 0.5` and `b` after halfway.
  ///
  /// The [scale] method forwards the `factor` to the `IntermediateGradient`'s
  /// [primitiveGradient] by [PrimitiveGradient.scale].
  static IntermediateGradient? lerp(
      IntermediateGradient? a, IntermediateGradient? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b!.scale(t);
    if (b == null) return a.scale(1.0 - t);
    return t < 0.5 ? a : b;
  }
}
