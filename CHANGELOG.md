# spectrum
## **[0.2.0]** - 03 JUL 21
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
