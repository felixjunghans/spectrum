/// TODO
library spectrum;

import 'common.dart';
import 'models.dart';

/// Mappings from [GradientAnimation](s) -> `dynamic`,
/// where `dynamic` matches with the key:
/// - `GradientAnimation.colorArithmetic:` [ColorArithmetic]
/// - `GradientAnimation.stopsArithmetic:` [StopsArithmetic]
/// - `GradientAnimation.tweenSpec: TweenSpec`
///   - Where [TweenSpec] is a mapping from [GradientProperty](s) -> [Tween](s)
typedef GradientStoryboard = Map<GradientAnimation, dynamic>;

/// Defines the options for a variety of transformations to apply to a
/// `Gradient` in the process of making it an [AnimatedGradient].
///
/// These `GradientAnimation` choices are mapped to an appropriate value to
/// describe *how* the gradient will be modified.
///
/// [colorArithmetic] maps to a [ColorArithmetic] function and
/// [stopsArithmetic] maps to a [StopsArithmetic] function.
///
/// [tweenSpec] maps not to a function, but to a [TweenSpec] that describes
/// a further embarrassment of riches for [GradientProperty] tweening.
enum GradientAnimation {
  /// `GradientAnimation.colorArithmetic` implies a [ColorArithmetic]
  /// will be mapped.
  colorArithmetic,

  /// `GradientAnimation.stopsArithmetic` implies a [StopsArithmetic]
  /// will be mapped.
  stopsArithmetic,

  /// `GradientAnimation.tweenSpec` implies a [TweenSpec] will be mapped.
  tweenSpec,

  /// `GradientAnimation.none` implies no animation should occur.
  ///
  /// Mapping this value to any other value (such as
  /// `{GradientAnimation.none: null}`) within an [AnimatedGradient.storyboard]
  /// will disable all animation transformations.
  none,
}

/// An [AnimatedWidget] that expects to be provided an initialized [Listenable].
///
/// Breaks the mold for [AnimatedWidget]s naming schemes (except for the
/// `AnimatedWidget` itself) as most `AnimatedFoo` class objects actually extend
/// [ImplicitlyAnimatedWidget] and handle their own [AnimationController].
/// But since this `AnimatedGradient` is not intended to ever be built,
/// there is no means for managing the lifecycle of said controller.
///
/// Use a [new AnimatedGradient] and its [observe] property for [Gradient]-type
/// return, provided some `Animation<double> controller`, to drive a
/// customizable animation on the [gradientInput] by tweaking this object's
/// [storyboard] map of [GradientAnimation]s.
class AnimatedGradient extends AnimatedWidget {
  /// Use this object's [observe] property, after providing some [controller],
  /// to drive a customizable animation on the [gradientInput] by tweaking
  /// the [storyboard] map of [GradientAnimation]s.
  ///
  /// Provide a `Tween<double>().animate()` or an [AnimationController]
  /// as `controller` to drive the flow of the animation. Consider
  /// driving the [AnimationController] by `controller.repeat(reverse:true)`.
  ///
  /// Not intended to have [build] called like a true `Widget`. \
  /// Instead opt to [observe] the [Gradient]-type output.
  /// - This `build()` method will return a [DecoratedBox] \
  ///   whose gradient is set to [observe].
  ///
  /// ## Animated Gradient Storyboard `Map`
  /// A [GradientStoryboard] value provided as [storyboard] maps
  /// [GradientAnimation]s to relevant values to apply those animation
  /// transformations.
  ///
  /// The default is [defaultStoryboard] which applies [ColorArithmetic] and
  /// [StopsArithmetic] that both play nicely with standard `0..1`
  /// [AnimationController] values.
  ///
  /// Beyond these two arithmetic animation transformations,
  /// [GradientAnimation.tweenSpec] may be mapped to a [TweenSpec] to detail
  /// individual [Tween]s for each of the many potential [Gradient] sub-type
  /// properties (such as [LinearGradient.begin] or [RadialGradient.radius]).
  ///
  /// ## `GradientAnimation` Mappings
  /// If `GradientAnimation.colorArithmetic` is mapped to a [ColorArithmetic],
  /// then that function applies [Gradient.colors] animation transformations. \
  /// The default from [defaultStoryboard] uses [Shades.withOpacity] which
  /// applies the clamped animation value as each gradient color's opacity,
  /// between `0..1`. \
  /// See [Shades] for more ideas.
  ///
  /// If `GradientAnimation.stopsArithmetic` is mapped to a [StopsArithmetic],
  /// then that function applies [Gradient.stops] animation transformations. \
  /// The default from [defaultStoryboard] is [Maths.subtraction]. \
  /// See [Maths] for more ideas.
  ///
  /// If `GradientAnimation.tweenSpec` is mapped to a [TweenSpec], then *that*
  /// object allows the mapping of [Tween]s to any potential [GradientProperty].
  ///
  /// ## Custom `copyWith()` Function
  /// In order to utilize custom, bespoke [Gradient] types that would not be
  /// hard-code recognized by this package and its default `copyWith()` method,
  /// provide a [GradientCopyWith] override for [_copyWith].
  const AnimatedGradient({
    Key? key,
    required Animation<double> controller,
    required Gradient gradient,
    this.storyboard = defaultStoryboard,
    // this.style = GradientAnimation.colorArithmetic,
    // required this.style,
    // this.colorArithmetic = Shades.withOpacity,
    // this.stopsArithmetic = Maths.subtraction,
    // this.tweenSpec = const {},
    GradientCopyWith overrideCopyWith = spectrumCopyWith,
  })  : _copyWith = overrideCopyWith,
        _gradient = gradient,
        super(key: key, listenable: controller);

  /// The default [GradientStoryboard] for a [new AnimatedGradient].
  // ///
  // /// This storyboard maps [GradientAnimation.colorArithmetic] to
  // /// [Shades.withOpacity] and [GradientAnimation.stopsArithmetic] to
  // /// [Maths.subtraction], providing both of these animation transformations
  // /// to the [AnimatedGradient.observe] output.
  static const GradientStoryboard defaultStoryboard = {
    // GradientAnimation.colorArithmetic: Shades.withOpacity,
    // GradientAnimation.stopsArithmetic: Maths.subtraction,
  };

  /// The provided `Animation<double>` from construction, accessed as
  /// `super.listenable`.
  Animation<double> get animation => listenable as Animation<double>;

  /// The `Gradient` provided at construction.
  Gradient get gradientInput => _gradient;

  /// The `Gradient` provided at construction.
  final Gradient _gradient;

  /// Mappings from [GradientAnimation]s -> `dynamic`, where `dynamic` matches
  /// with the key:
  /// - `GradientAnimation.colorArithmetic:` [ColorArithmetic]
  /// - `GradientAnimation.stopsArithmetic:` [StopsArithmetic]
  /// - `GradientAnimation.tweenSpec: TweenSpec`
  ///   - Where [TweenSpec] is a mapping from [GradientProperty]s -> [Tween]s
  final GradientStoryboard storyboard;

  /// Override this package's default `Gradient.copyWith()` method:
  /// [spectrumCopyWith], a wrapper for [GradientUtils] extension
  /// `Gradient.copyWith()`.
  ///
  /// ---
  /// {@macro GradientCopyWith}
  final GradientCopyWith _copyWith;

  // /// - [GradientAnimation.colorArithmetic] allows the provision of a
  // /// [ColorArithmetic] type function as [colorArithmetic]. This function
  // /// returns a `Color` and accepts a `Color color` and a `num factor`.
  // ///   - See [Shades] for some pre-built color shading functions.
  // ///   - Default is [Shades.withOpacity] as it beautifully handles default
  // ///   values ranging `0..1` from an [AnimationController].
  // /// ---
  // /// - [GradientAnimation.stopsArithmetic] allows the provision of a
  // /// [StopsArithmetic] type function as [stopsArithmetic]. This function
  // /// returns a `double` and accepts a `double stop` and a `double factor`.
  // ///   - See [Maths] for some pre-built stops math functions.
  // ///   - Default is [Maths.multiplication] as it handles default
  // ///   values ranging `0..1` from an [AnimationController] well.
  // /// ---
  // /// - [GradientAnimation.none] disables any transformations, returning the
  // /// [gradientInput] as the output from [observe].
  // final GradientAnimation style;

  // /// Only applicable if [style] is [GradientAnimation.colorArithmetic].
  // ///
  // /// See [Shades] for some pre-built [ColorArithmetic] functions.
  // ///
  // /// Default is [Shades.withOpacity].
  // final ColorArithmetic colorArithmetic;

  // /// Only applicable if [style] is [GradientAnimation.stopsArithmetic].
  // ///
  // /// See [Maths] for some pre-built [StopsArithmetic] functions.
  // ///
  // /// Default is [Maths.subtraction].
  // final StopsArithmetic stopsArithmetic;

  // /// A `TweenSpec` is a `Map` of [GradientProperty]s to respective [Tween]s.
  // ///
  // /// `GradientProperty`s are potential gradient properties for tweenage,
  // /// notably excluding `colors`, `stops`, `transform`, & `tileMode`,
  // /// as well as `shadeFunction` for `FooShadedSteps`.
  // final TweenSpec tweenSpec;

  /// Observe the output `Gradient` which applies modifications to the
  /// [gradientInput] based on the [animation] and other provided properties,
  /// considering [storyboard] and the relevant mappings from \
  /// [GradientAnimation]s -> `dynamic`, where `dynamic` matches with the key:
  /// - `GradientAnimation.colorArithmetic:` [ColorArithmetic]
  /// - `GradientAnimation.stopsArithmetic:` [StopsArithmetic]
  /// - `GradientAnimation.tweenSpec: TweenSpec`
  ///   - Where [TweenSpec] is a mapping from [GradientProperty]s -> [Tween]s
  Gradient get observe {
    if (storyboard.isEmpty || storyboard.containsKey(GradientAnimation.none)) {
      return _gradient;
    }
    var observation = _gradient;
    _makeAssertations();

    if (storyboard.containsKey(GradientAnimation.colorArithmetic)) {
      observation = _copyWith(observation,
          colors: _gradient.colors
              .map<Color>(
                (c) => (storyboard[GradientAnimation.colorArithmetic]
                        as ColorArithmetic)
                    .call(c, animation.value),
              )
              .toList());
    }

    if (storyboard.containsKey(GradientAnimation.stopsArithmetic)) {
      observation = _copyWith(observation,
          stops: interpretStops(_gradient)
              .map<double>(
                (s) => (storyboard[GradientAnimation.stopsArithmetic]
                        as StopsArithmetic)
                    .call(s, animation.value),
              )
              .toList());
    }

    if (!storyboard.containsKey(GradientAnimation.tweenSpec)) {
      return observation;
    }

    final spec = storyboard[GradientAnimation.tweenSpec] as TweenSpec;
    return _copyWith(
      observation,
      begin: spec.containsKey(GradientProperty.begin)
          ? spec[GradientProperty.begin]!.evaluate(animation)
          : observation.begin,
      end: spec.containsKey(GradientProperty.end)
          ? spec[GradientProperty.end]!.evaluate(animation)
          : observation.end,
      center: spec.containsKey(GradientProperty.center)
          ? spec[GradientProperty.center]!.evaluate(animation)
          : observation.center,
      radius: spec.containsKey(GradientProperty.radius)
          ? spec[GradientProperty.radius]!.evaluate(animation)
          : observation.radius,
      focal: spec.containsKey(GradientProperty.focal)
          ? spec[GradientProperty.focal]!.evaluate(animation)
          : observation.focal,
      focalRadius: spec.containsKey(GradientProperty.focalRadius)
          ? spec[GradientProperty.focalRadius]!.evaluate(animation)
          : observation.focalRadius,
      startAngle: spec.containsKey(GradientProperty.startAngle)
          ? spec[GradientProperty.startAngle]!.evaluate(animation)
          : observation.startAngle,
      endAngle: spec.containsKey(GradientProperty.endAngle)
          ? spec[GradientProperty.endAngle]!.evaluate(animation)
          : observation.endAngle,
      softness: spec.containsKey(GradientProperty.softness)
          ? spec[GradientProperty.softness]!.evaluate(animation)
          : observation.softness,
      shadeFactor: spec.containsKey(GradientProperty.shadeFactor)
          ? spec[GradientProperty.shadeFactor]!.evaluate(animation)
          : observation.shadeFactor,
      distance: spec.containsKey(GradientProperty.distance)
          ? spec[GradientProperty.distance]!.evaluate(animation)
          : observation.distance,
    );
  }

  /// An [AnimatedGradient] is not intended to be built directly like a
  /// true `Widget`. Instead opt to [observe] for the direct [Gradient]-
  /// type output.
  ///
  /// This `build()` method will return a [DecoratedBox]
  /// whose gradient is set to [observe].
  @override
  Widget build(BuildContext context) {
    // assert(
    //   false,
    //   'An [AnimatedGradient] is not intended to be built directly '
    //   'like a true Widget. \nInstead opt to [AnimatedGradient.observe] '
    //   'for the direct [Gradient]-type output.',
    // );
    return DecoratedBox(decoration: BoxDecoration(gradient: observe));
  }

  void _makeAssertations() {
    assert(
        storyboard.containsKey(GradientAnimation.colorArithmetic)
            ? storyboard[GradientAnimation.colorArithmetic]! is ColorArithmetic
            : true,
        'If [GradientAnimation.colorArithmetic] is employed, '
        'ensure the function value is a [ColorArithmetic].');
    assert(
        storyboard.containsKey(GradientAnimation.stopsArithmetic)
            ? storyboard[GradientAnimation.stopsArithmetic]! is StopsArithmetic
            : true,
        'If [GradientAnimation.stopsArithmetic] is employed, '
        'ensure the function value is a [StopsArithmetic].');
    assert(
        storyboard.containsKey(GradientAnimation.tweenSpec)
            ? storyboard[GradientAnimation.tweenSpec]! is TweenSpec
            : true,
        'If [GradientAnimation.tweenSpec] is employed, '
        'ensure the map value is a [TweenSpec].');

    if (storyboard.containsKey(GradientAnimation.tweenSpec)) {
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.begin)
              ? (storyboard[GradientAnimation.tweenSpec]
                      as TweenSpec)[GradientProperty.begin]!
                  is Tween<AlignmentGeometry?>
              : true,
          'If [GradientProperty.begin] is employed, '
          'ensure the [tween] is a [Tween<AlignmentGeometry?>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.end)
              ? (storyboard[GradientAnimation.tweenSpec]
                      as TweenSpec)[GradientProperty.end]!
                  is Tween<AlignmentGeometry?>
              : true,
          'If [GradientProperty.end] is employed, '
          'ensure the [tween] is a [Tween<AlignmentGeometry?>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.center)
              ? (storyboard[GradientAnimation.tweenSpec]
                      as TweenSpec)[GradientProperty.center]!
                  is Tween<AlignmentGeometry?>
              : true,
          'If [GradientProperty.center] is employed, '
          'ensure the [tween] is a [Tween<AlignmentGeometry?>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.radius)
              ? (storyboard[GradientAnimation.tweenSpec]
                  as TweenSpec)[GradientProperty.radius]! is Tween<double>
              : true,
          'If [GradientProperty.radius] is employed, '
          'ensure the [tween] is a [Tween<double>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.focal)
              ? (storyboard[GradientAnimation.tweenSpec]
                      as TweenSpec)[GradientProperty.focal]!
                  is Tween<AlignmentGeometry?>
              : true,
          'If [GradientProperty.focal] is employed, '
          'ensure the [tween] is a [Tween<AlignmentGeometry?>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.focalRadius)
              ? (storyboard[GradientAnimation.tweenSpec]
                  as TweenSpec)[GradientProperty.focalRadius]! is Tween<double>
              : true,
          'If [GradientProperty.focalRadius] is employed, '
          'ensure the [tween] is a [Tween<double>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.startAngle)
              ? (storyboard[GradientAnimation.tweenSpec]
                  as TweenSpec)[GradientProperty.startAngle]! is Tween<double>
              : true,
          'If [GradientProperty.startAngle] is employed, '
          'ensure the [tween] is a [Tween<double>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.endAngle)
              ? (storyboard[GradientAnimation.tweenSpec]
                  as TweenSpec)[GradientProperty.endAngle]! is Tween<double>
              : true,
          'If [GradientProperty.endAngle] is employed, '
          'ensure the [tween] is a [Tween<double>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.softness)
              ? (storyboard[GradientAnimation.tweenSpec]
                  as TweenSpec)[GradientProperty.softness]! is Tween<double>
              : true,
          'If [GradientProperty.softness] is employed, '
          'ensure the [tween] is a [Tween<double>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.shadeFactor)
              ? (storyboard[GradientAnimation.tweenSpec]
                  as TweenSpec)[GradientProperty.shadeFactor]! is Tween<num>
              : true,
          'If [GradientProperty.shadeFactor] is employed, '
          'ensure the [tween] is a [Tween<num>].');
      assert(
          (storyboard[GradientAnimation.tweenSpec] as TweenSpec)
                  .containsKey(GradientProperty.distance)
              ? (storyboard[GradientAnimation.tweenSpec]
                  as TweenSpec)[GradientProperty.distance]! is Tween<double>
              : true,
          'If [GradientProperty.distance] is employed, '
          'ensure the [tween] is a [Tween<double>].');
    }
  }
}