/// Provides `GradientTween` which specializes the interpolation
/// of [Tween<Gradient>] to use [Gradient.lerp] and bespoke
/// [IntermediateGradient]s.
library spectrum;

import '../common.dart';

import 'interpolation.dart';

/// An interpolation between two `Gradient`s.
///
/// This class specializes the interpolation of [Tween<Gradient>]
/// to use [Gradient.lerp] and bespoke [IntermediateGradient]s.
///
/// See [Tween] for a discussion on how to use interpolation objects.
class GradientTween extends Tween<Gradient?> {
  /// An interpolation between two `Gradient`s.
  ///
  /// This class specializes the interpolation of [Tween<Gradient>]
  /// to use [Gradient.lerp] and bespoke [IntermediateGradient]s.
  ///
  /// See [Tween] for a discussion on how to use interpolation objects.
  GradientTween({Gradient? begin, Gradient? end})
      : super(begin: begin, end: end);

  /// Return the value this variable has at the given animation clock value [t].
  ///
  /// If [begin] and [end] are gradients of the same type or if either is
  /// `null`, employs [Gradient.lerp]; which itself is a step up from the
  /// standard behavior.
  /// - [Gradient.lerp] will fade to `null` between gradients of dissimilar
  ///   types which gives a fad-out/fade-in tween
  ///
  /// In all other circumstances, however, this method can generated an
  /// [IntermediateGradient].
  ///
  /// This is done by comparing the [runtimeType] of [begin] & [end]
  /// against [t], providing the first type before `0.5` and the second after;
  /// creating a [GradientPacket] containing both gradients and passing [t]
  /// which can provide *any requested potential* gradient property using lerp;
  /// and interpolating the colors and stops of [begin] & [end] by creating
  /// and passing along a [PrimitiveGradient].
  @override
  Gradient lerp(double t) {
    return begin.runtimeType == end.runtimeType ||
            (begin == null || end == null)
        ? Gradient.lerp(begin, end, t)!
        : IntermediateGradient(
            t < 0.5 ? begin.runtimeType : end.runtimeType,
            GradientPacket(begin!, end!, t),
            PrimitiveGradient.interpolateFrom(begin!, end!, t),
            // t < 0.5
            //     ? PrimitiveGradient.from(begin!)
            //     : PrimitiveGradient.from(end!),
          );
  }
}
