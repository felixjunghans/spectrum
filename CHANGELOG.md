# ![spectrum header image](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/spectrum_50.gif)
## **[0.2.2]** - 27 JUL 21
Corrects a [`NillGradients`](https://pub.dev/documentation/spectrum/latest/gradients/NillGradients.html)
bug where `Sweep`-styled nill gradients had both a `startAngle` and `endAngle`
of `0.0`, throwing an "optimized out" error.
- The end angle on these nill sweep gradients is now `0.01`.

## **[0.2.1+1]** - 26 JUL 21
Fixes README links and finishes documentation.

## **[0.2.1]** - 25 JUL 21
Modularizes package into `colors` & `gradients` mini-libraries.
- Import all-in-one as `import 'package:spectrum/spectrum.dart';`
- Or seperately such as `import 'package:spectrum/colors.dart';`

Reverts usage of Dart @ 2.13 non-function type aliases (AKA `typedef`s) as they
were throwing `dartdoc`.
- "`failed: Bad state: typedef GradientStoryboard = Map<GradientAnimation, dynamic> cannot have parameters`"

Simplifies name of `Color.generateComplements(5)` -> `Color.complementary(5)`.

## **[0.2.0]** - 23 JUL 21
Massive "fleshing out" of the project, establishing remaining goals.

- Added `FooShadedSteps`
- Added `AnimatedGradient`
  - See also: `GradientStoryboard`, `GradientAnimation`, `GradientProperty`,
  `TweenSpec`, & more
- Added `GradientCopyWith` template
  - Used to override the return type for the `Gradient.copyWith` method used
  from within either a `GradientTween` or `AnimatedGradient`
- Introduced `Gradient` getter `reversed` and convenience method `animate()`
- Introduced `isAgressive` flag for `GradientTween`
- For the generation of `MaterialColor`s via `Spectrum.materialColor`:
  - `Blend` -> `SwatchMode` with an additional value, `SwatchMode.complements`
  - Consider `Spectrum.materialAccent` to create a `MaterialAccentColor`
- Color complements are obtained by new `SpectrumUtils.generateComplements`
  - Which drives the `List<Color>` getter extensions on instantiated `Color`s,
  too; `Color.complementTriad`, for example

## **[0.1.0]** - 11 JUN 21
- Initial release.
