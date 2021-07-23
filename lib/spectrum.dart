// # spectrum
/// # ![spectrum header image](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/spectrum_15.gif)
/// ## [pub.dev Listing](https://pub.dev/packages/spectrum) | [API Doc](https://pub.dev/documentation/spectrum/latest) | [GitHub](https://github.com/Zabadam/spectrum)
/// ##### Color API References: [`Shading`](https://pub.dev/documentation/spectrum/latest/spectrum/Shading.html) | [`ColorOperators`](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators.html) | [`ColorOperatorsMethods`](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperatorsMethod.html) | [`Spectrum`](https://pub.dev/documentation/spectrum/latest/spectrum/Spectrum-class.html) | [`SpectrumUtils`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils.html)
/// ##### Gradient API References:  [`GradientUtils`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientUtils.html) | [`GradientTween`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientTween-class.html) | [`Steps`](https://pub.dev/documentation/spectrum/latest/spectrum/Steps-class.html) | [`FooShadedSteps`](https://pub.dev/documentation/spectrum/latest/spectrum/RadialShadedSteps-class.html) | [`AnimatedGradient`](https://pub.dev/documentation/spectrum/latest/spectrum/AnimatedGradient-class.html)
///
/// A rainbow of `Color` and `Gradient` utilities such as [`GradientTween`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientTween-class.html),
/// gradient [`copyWith()`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientUtils/copyWith.html)
/// any potential parameters for the many types, [`generateComplements()`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/generateComplements.html)
/// for colors, [`AnimatedGradient`](https://pub.dev/documentation/spectrum/latest/spectrum/AnimatedGradient-class.html),
/// [`MaterialColor` generation](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/materialColor.html),
/// and more!
///
/// ###### More:  [`ColorArithmetic` `Shades`](https://pub.dev/documentation/spectrum/latest/spectrum/Shades-class.html) | [`StopsArithmetic` `Maths`](https://pub.dev/documentation/spectrum/latest/spectrum/Maths-class.html) | [`SwatchMode`](https://pub.dev/documentation/spectrum/latest/spectrum/SwatchMode-class.html) | [`GradientStoryboard`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientStoryboard.html) | [`NillGradients`](https://pub.dev/documentation/spectrum/latest/spectrum/NillGradients.html)
/// ##### [🐸 Zaba.app ― simple packages, simple names.](https://pub.dev/publishers/zaba.app/packages)
library spectrum;

export 'src/colors/operators.dart';
export 'src/colors/shading.dart';
export 'src/colors/spectrum.dart';

export 'src/gradients/animation.dart';
export 'src/gradients/interpolation.dart'; // testing
export 'src/gradients/models.dart';
export 'src/gradients/nill.dart';
export 'src/gradients/steps.dart';
export 'src/gradients/steps_shaded.dart';
export 'src/gradients/tween.dart';
export 'src/gradients/utils.dart';
