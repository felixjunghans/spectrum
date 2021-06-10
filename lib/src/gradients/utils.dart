/// Provides utilities for copying `Gradient`s
/// - [GradientUtils] - 📋 `copyWith`
///   - Global getters for the properties available from every type,
///   with default fallback values if `this` gradient does not have that prop.
/// - [LinearGradientUtils] - 📋 `copyWith`
/// - [RadialGradientUtils] - 📋 `copyWith`
/// - [SweepGradientUtils] - 📋 `copyWith`
library spectrum;

import '../common.dart';
import '../gradients/interpolation.dart';
import 'steps.dart';

/// Offers [copyWith] method to make duplicate `Gradient`s.
extension LinearGradientUtils on LinearGradient {
  /// 📋 Returns a new copy of this `LinearGradient` with any provided
  /// optional parameters overriding those of `this`.
  LinearGradient copyWith({
    List<Color>? colors,
    List<double>? stops,
    GradientTransform? transform,
    TileMode? tileMode,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) =>
      LinearGradient(
        colors: colors ?? this.colors,
        stops: stops ?? this.stops,
        transform: transform ?? this.transform,
        tileMode: tileMode ?? this.tileMode,
        begin: begin ?? this.begin,
        end: end ?? this.end,
      );
}

/// Offers [copyWith] method to make duplicate `Gradient`s.
extension RadialGradientUtils on RadialGradient {
  /// 📋 Returns a new copy of this `RadialGradient` with any provided
  /// optional parameters overriding those of `this`.
  RadialGradient copyWith({
    List<Color>? colors,
    List<double>? stops,
    GradientTransform? transform,
    TileMode? tileMode,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
  }) =>
      RadialGradient(
        colors: colors ?? this.colors,
        stops: stops ?? this.stops,
        transform: transform ?? this.transform,
        tileMode: tileMode ?? this.tileMode,
        center: center ?? this.center,
        radius: radius ?? this.radius,
        focal: focal ?? this.focal,
        focalRadius: focalRadius ?? this.focalRadius,
      );
}

/// Offers [copyWith] method to make duplicate `Gradient`s.
extension SweepGradientUtils on SweepGradient {
  /// 📋 Returns a new copy of this `SweepGradient` with any provided
  /// optional parameters overriding those of `this`.
  SweepGradient copyWith({
    List<Color>? colors,
    List<double>? stops,
    GradientTransform? transform,
    TileMode? tileMode,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
  }) =>
      SweepGradient(
        colors: colors ?? this.colors,
        stops: stops ?? this.stops,
        transform: transform ?? this.transform,
        tileMode: tileMode ?? this.tileMode,
        center: center ?? this.center,
        startAngle: startAngle ?? this.startAngle,
        endAngle: endAngle ?? this.endAngle,
      );
}

// TODO: Reconsider. Check <T>?
/// Offers [copyWith] method to make duplicate `Gradient`s.
extension GradientUtils on Gradient {
  /// 📋 Returns a new copy of this `Gradient` with any appropriate
  /// optional parameters overriding those of `this`.
  ///
  /// Recognizes [LinearGradient], [RadialGradient], & [SweepGradient],
  /// as well as this package's [LinearSteps], [RadialSteps], & [SweepSteps].
  ///
  /// Defaults back to [RadialGradient] if `Type` cannot be matched.
  /// (Radial is simply a design choice.)
  ///
  /// ```dart
  /// Gradient copyWith({
  ///   // Universal
  // ignore: lines_longer_than_80_chars
  ///   List<Color>? colors, List<double>? stops, GradientTransform? transform, TileMode? tileMode,
  ///   // Linear
  ///   AlignmentGeometry? begin, AlignmentGeometry? end,
  ///   // Radial or Sweep
  ///   AlignmentGeometry? center,
  ///   // Radial
  ///   double? radius, AlignmentGeometry? focal, double? focalRadius,
  ///   // Sweep
  ///   double? startAngle, double? endAngle,
  ///   // Steps
  ///   double? softness,
  /// })
  /// ```
  Gradient copyWith({
    // Universal
    List<Color>? colors,
    List<double>? stops,
    GradientTransform? transform,
    TileMode? tileMode,
    // Linear
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    // Radial or Sweep
    AlignmentGeometry? center,
    // Radial
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    // Sweep
    double? startAngle,
    double? endAngle,
    // Steps
    double? softness,
  }) =>
      (this is IntermediateGradient)
          ? this
          : (this is PrimitiveGradient)
              ? this
              : (this is LinearGradient)
                  ? LinearGradient(
                      colors: colors ?? this.colors,
                      stops: stops ?? this.stops,
                      transform: transform ?? this.transform,
                      tileMode: tileMode ?? this.tileMode,
                      begin: begin ?? this.begin,
                      end: end ?? this.end,
                    )
                  : (this is SweepGradient)
                      ? SweepGradient(
                          colors: colors ?? this.colors,
                          stops: stops ?? this.stops,
                          transform: transform ?? this.transform,
                          tileMode: tileMode ?? this.tileMode,
                          center: center ?? this.center,
                          startAngle: startAngle ?? this.startAngle,
                          endAngle: endAngle ?? this.endAngle,
                        )
                      : (this is LinearSteps)
                          ? LinearSteps(
                              softness: softness ?? this.softness,
                              colors: colors ?? this.colors,
                              stops: stops ?? this.stops,
                              transform: transform ?? this.transform,
                              tileMode: tileMode ?? this.tileMode,
                              begin: begin ?? this.begin,
                              end: end ?? this.end,
                            )
                          : (this is RadialSteps)
                              ? RadialSteps(
                                  softness: softness ?? this.softness,
                                  colors: colors ?? this.colors,
                                  stops: stops ?? this.stops,
                                  transform: transform ?? this.transform,
                                  tileMode: tileMode ?? this.tileMode,
                                  center: center ?? this.center,
                                  radius: radius ?? this.radius,
                                  focal: focal ?? this.focal,
                                  focalRadius: focalRadius ?? this.focalRadius,
                                )
                              : (this is SweepSteps)
                                  ? SweepSteps(
                                      softness: softness ?? this.softness,
                                      colors: colors ?? this.colors,
                                      stops: stops ?? this.stops,
                                      transform: transform ?? this.transform,
                                      tileMode: tileMode ?? this.tileMode,
                                      center: center ?? this.center,
                                      startAngle: startAngle ?? this.startAngle,
                                      endAngle: endAngle ?? this.endAngle,
                                    )
                                  : RadialGradient(
                                      colors: colors ?? this.colors,
                                      stops: stops ?? this.stops,
                                      transform: transform ?? this.transform,
                                      tileMode: tileMode ?? this.tileMode,
                                      center: center ?? this.center,
                                      radius: radius ?? this.radius,
                                      focal: focal ?? this.focal,
                                      focalRadius:
                                          focalRadius ?? this.focalRadius,
                                    );
  // UNIVERSAL
  TileMode get tileMode => (this is IntermediateGradient)
      ? TileMode.clamp
      : (this is PrimitiveGradient)
          ? TileMode.clamp
          : (this is LinearGradient)
              ? (this as LinearGradient).tileMode
              : (this is SweepGradient)
                  ? (this as SweepGradient).tileMode
                  : (this is LinearSteps)
                      ? (this as LinearSteps).tileMode
                      : (this is RadialSteps)
                          ? (this as RadialSteps).tileMode
                          : (this is SweepSteps)
                              ? (this as SweepSteps).tileMode
                              : (this as RadialGradient).tileMode;

  // LINEAR
  AlignmentGeometry get begin => (this is IntermediateGradient)
      ? Alignment.center
      : (this is PrimitiveGradient)
          ? Alignment.center
          : (this is LinearGradient)
              ? (this as LinearGradient).begin
              : (this is SweepGradient)
                  ? Alignment.center
                  : (this is LinearSteps)
                      ? (this as LinearSteps).begin
                      : (this is RadialSteps)
                          ? Alignment.center
                          : (this is SweepSteps)
                              ? Alignment.center
                              : Alignment.center;

  AlignmentGeometry get end => (this is IntermediateGradient)
      ? Alignment.center
      : (this is PrimitiveGradient)
          ? Alignment.center
          : (this is LinearGradient)
              ? (this as LinearGradient).end
              : (this is SweepGradient)
                  ? Alignment.center
                  : (this is LinearSteps)
                      ? (this as LinearSteps).end
                      : (this is RadialSteps)
                          ? Alignment.center
                          : (this is SweepSteps)
                              ? Alignment.center
                              : Alignment.center;

  // RADIAL or SWEEP
  AlignmentGeometry get center => (this is IntermediateGradient)
      ? Alignment.center
      : (this is PrimitiveGradient)
          ? Alignment.center
          : (this is LinearGradient)
              ? Alignment.center
              : (this is SweepGradient)
                  ? (this as SweepGradient).center
                  : (this is LinearSteps)
                      ? Alignment.center
                      : (this is RadialSteps)
                          ? (this as RadialSteps).center
                          : (this is SweepSteps)
                              ? (this as SweepSteps).center
                              : (this as RadialGradient).center;

  // RADIAL
  double get radius => (this is IntermediateGradient)
      ? 0.0
      : (this is PrimitiveGradient)
          ? 0.0
          : (this is LinearGradient)
              ? 0.0
              : (this is SweepGradient)
                  ? 0.0
                  : (this is LinearSteps)
                      ? 0.0
                      : (this is RadialSteps)
                          ? (this as RadialSteps).radius
                          : (this is SweepSteps)
                              ? 0.0
                              : (this as RadialGradient).radius;

  AlignmentGeometry? get focal => (this is IntermediateGradient)
      ? null
      : (this is PrimitiveGradient)
          ? null
          : (this is LinearGradient)
              ? null
              : (this is SweepGradient)
                  ? null
                  : (this is LinearSteps)
                      ? null
                      : (this is RadialSteps)
                          ? (this as RadialSteps).focal
                          : (this is SweepSteps)
                              ? null
                              : (this as RadialGradient).focal;

  double get focalRadius => (this is IntermediateGradient)
      ? 0.0
      : (this is PrimitiveGradient)
          ? 0.0
          : (this is LinearGradient)
              ? 0.0
              : (this is SweepGradient)
                  ? 0.0
                  : (this is LinearSteps)
                      ? 0.0
                      : (this is RadialSteps)
                          ? (this as RadialSteps).focalRadius
                          : (this is SweepSteps)
                              ? 0.0
                              : (this as RadialGradient).focalRadius;

  // SWEEP
  double get startAngle => (this is IntermediateGradient)
      ? 0.0
      : (this is PrimitiveGradient)
          ? 0.0
          : (this is LinearGradient)
              ? 0.0
              : (this is SweepGradient)
                  ? (this as SweepGradient).startAngle
                  : (this is LinearSteps)
                      ? 0.0
                      : (this is RadialSteps)
                          ? 0.0
                          : (this is SweepSteps)
                              ? (this as SweepSteps).startAngle
                              : 0.0;

  double get endAngle => (this is IntermediateGradient)
      ? 0.0
      : (this is PrimitiveGradient)
          ? 0.0
          : (this is LinearGradient)
              ? 0.0
              : (this is SweepGradient)
                  ? (this as SweepGradient).endAngle
                  : (this is LinearSteps)
                      ? 0.0
                      : (this is RadialSteps)
                          ? 0.0
                          : (this is SweepSteps)
                              ? (this as SweepSteps).endAngle
                              : 0.0;

  // STEPS
  double get softness => (this is IntermediateGradient)
      ? 0.0
      : (this is PrimitiveGradient)
          ? 0.0
          : (this is LinearGradient)
              ? 0.0
              : (this is SweepGradient)
                  ? 0.0
                  : (this is LinearSteps)
                      ? (this as LinearSteps).softness
                      : (this is RadialSteps)
                          ? (this as RadialSteps).softness
                          : (this is SweepSteps)
                              ? (this as SweepSteps).softness
                              : 0.0;
}
