# spectrum
## [pub.dev Listing](https://pub.dev/packages/spectrum) | [API Doc](https://pub.dev/documentation/spectrum/latest) | [GitHub](https://github.com/Zabadam/spectrum)
##### Color API References: [`Shading`](https://pub.dev/documentation/spectrum/latest/spectrum/Shading.html) | [`ColorOperators`](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators.html) | [`ColorOperatorsMethods`](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperatorsMethod.html) | [`Spectrum`](https://pub.dev/documentation/spectrum/latest/spectrum/Spectrum-class.html) | [`SpectrumUtils`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils.html)
##### Gradient API References:  [`GradientUtils`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientUtils.html) | [`GradientTween`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientTween-class.html) | [`Steps`](https://pub.dev/documentation/spectrum/latest/spectrum/Steps-class.html) | [`FooShadedSteps`](https://pub.dev/documentation/spectrum/latest/spectrum/RadialShadedSteps-class.html) | [`AnimatedGradient`](https://pub.dev/documentation/spectrum/latest/spectrum/AnimatedGradient-class.html)
###### More:  [`ColorArithmetic` `Shades`](https://pub.dev/documentation/spectrum/latest/spectrum/Shades-class.html) | [`StopsArithmetic` `Maths`](https://pub.dev/documentation/spectrum/latest/spectrum/Maths-class.html) | [`SwatchMode`](https://pub.dev/documentation/spectrum/latest/spectrum/SwatchMode-class.html) | [`GradientStoryboard`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientStoryboard.html) | [`NillGradients`](https://pub.dev/documentation/spectrum/latest/spectrum/NillGradients.html) | [`MaterialColorToList`](https://pub.dev/documentation/spectrum/latest/spectrum/MaterialColorToList.html)
##### [🐸 Zaba.app ― simple packages, simple names.](#-zabaapp--simple-packages-simple-nameshttpspubdevpublisherszabaapppackages-other-flutter-packages-published-by-zabaapp)

<br />

<!-- [![Header image](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/_small.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/.gif 'Click for full size') -->

A rainbow of `Color` and `Gradient` utilities such as [`GradientTween`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientTween-class.html),
gradient [`copyWith()`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientUtils/copyWith.html)
any potential parameters for the many types, [`Steps`-type gradients](#-steps),
[`generateComplements()`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/generateComplements.html)
for colors, [`AnimatedGradient`](https://pub.dev/documentation/spectrum/latest/spectrum/AnimatedGradient-class.html),
[`MaterialColor` generation](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/materialColor.html),
and more!

## 📚 Table of Contents

[spectrum](#spectrum)

  1. 🌊 [Gradients](#-gradients 'Part I')
     1. 💫 [Interpolation](#-interpolation 'GradientTweens & bespoke IntermediateGradients')
     2. 🌈 [Steps](#-steps 'Hard-stepping "gradients" that intrinsically duplicate colors and stops lists')
        1. 🧹 [Softness](#-softness 'Controls the aliasing and may return Steps back into a Gradient')
        2. 🕶️ [Shaded Steps](#️-shaded-steps 'Evolves the concept of duplicating colors and stops to add color shading functionality')
     3. ⏰ [Animation](#-animation 'Feed an animation to an AnimatedGradient defined by a GradientStoryboard')
        1. 📖 [Gradient Storyboard](#-gradient-storyboard 'Lay out how the gradient will utilize its controller')
     4. 📋 [Override Copy With](#-override-copy-with 'Use this package with your own custom Gradient Types')
   
  2. 🎨 [Colors](#-colors 'Part II')
     1. ➗ [Operators](#-operators 'Although there is currently no division operator')
     2. 🗜️ [Spectrum](#️-spectrum 'Quick tools that would otherwise be floating functions, instead anchored to abstract class')
     3. 🤝 [Complementary Colors](#-complementary-colors 'Rapidly produce Lists of Colors with varying degrees of complement')
   
  3. 🛣️ [Roadmap](#️-roadmap 'The current TODO list')

<br />

## 🌊 Gradients

### 💫 Interpolation

Smooth `Gradient` tweening not just by `Gradient.lerp()`... oh no,
that is not enough.

This package provides full bespoke [`IntermediateGradient`](https://pub.dev/documentation/spectrum/latest/spectrum/IntermediateGradient-class.html)s
for truly smooth and eye-popping gradient animations between dissimilar gradient
types!

[![Incredibly beautiful GradientTweens with IntermediateGradients](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/tween_small.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/tween.gif 'Click for full size | Incredibly beautiful GradientTweens with IntermediateGradients')

The interpolated `Gradient` is obtained via [`GradientTween.evaluate(Animation animation)`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientTween-class.html)
or `transform(double t)`.

Until better `List` interpolation is implemented, feel free to experiment with
`isAgressive`.

<div style='text-align:right'><a href='#-table-of-contents' title='Table of Contents'>📚</a></div>

### 🌈 Steps

Spectrum also adds entirely new gradient types called [`Steps`](https://pub.dev/documentation/spectrum/latest/spectrum/Steps-class.html),
as well as shaded varieties named [`FooShadedSteps`](https://pub.dev/documentation/spectrum/latest/spectrum/RadialShadedSteps-class.html).
Imagine a gradient that somewhat defeats the idea of a gradient and, instead of
smoothly transitioning between colors, creates a series of hard steps.

[![New Steps-type Gradients; three variety for Radial, Linear, and Sweep](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/steps.png)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/steps.png 'Click for full size | New Steps-type Gradients; three variety for Radial, Linear, and Sweep')

This is achieved by intrinsically duplicating both the `List<Color>` of `colors`
as well as the (interpreted or explicit) `List<double>` of `stops`. As a product
of this process, any explicitly initalized list of `stops` ought to not end in
`1.0` lest that stop get eaten. For example, a three-color `Steps` could have 
`stops: [0.0, 0.3, 0.8]`.

#### 🧹 Softness

A `softness` may be increased or zeroed out depending on preference or user
device display density. A high-DPI screen would look just fine with an aliased,
hard edge between colors. A low-DPI screen would benefit from a (still,
incredibly small) `softness` to provide as an additive for each second entry
when duplicating stops.

A larger  `softness` has the effect of making `Steps` more like their original
`Gradient` counterpart.

[![Animation showing transition from Steps.softness == 0 to some greater value then transitioning back](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/softness_small.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/softness.gif 'Click for full size | Animation showing transition from Steps.softness == 0 to some greater value then transitioning back')

Imagine `Steps.stops` is `[0.0, 0.3, 0.8]`. Providing a `softness` of `0.001`,
the effective, resolved stops for this gradient is now:
`[0.0, 0.001, 0.3, 0.3001, 0.8, 0.8001]`.

#### 🕶️ Shaded Steps

Now imagine *more* intrinsic color and stops math for a variety of
self-elaborating gradients... something like `FooShadedSteps` may be born.

Each of [`Linear`](https://pub.dev/documentation/spectrum/latest/spectrum/LinearShadedSteps-class.html),
[`Radial`](https://pub.dev/documentation/spectrum/latest/spectrum/RadialShadedSteps-class.html),
and [`Sweep`](https://pub.dev/documentation/spectrum/latest/spectrum/SweepShadedSteps-class.html)
extends from the original `Steps` counterpart and overrides its [`steppedColors`](https://pub.dev/documentation/spectrum/latest/spectrum/Steps/steppedColors.html)
& [`steppedStops`](https://pub.dev/documentation/spectrum/latest/spectrum/Steps/steppedColors.html)
properties to actually *"quadruplicate"* these lists, optionally with a variety
of customizable parameters (including the [function to perform the color shading](https://pub.dev/documentation/spectrum/latest/spectrum/LinearShadedSteps/shadeFunction.html)).

[![LinearShadedSteps transitioning from a negative value to a positive value with \`LinearShadedSteps.shadeFunction\` defaulting with \`Shades.withWhite\`](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/shaded_steps_small.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/shaded_steps.gif 'Click for full size | LinearShadedSteps transitioning from a negative value to a positive value with \`LinearShadedSteps.shadeFunction\` defaulting with \`Shades.withWhite\`')

<div style='text-align:right'><a href='#-table-of-contents' title='Table of Contents'>📚</a></div>

### ⏰ Animation

Provide an animation, like an `AnimationController` or an `animate()`d `Tween`,
to an [`AnimatedGradient`](https://pub.dev/documentation/spectrum/latest/spectrum/AnimatedGradient-class.html)
along with a gradient for which to alter the properties.

| ![A Gradient, then supplied to a AnimatedGradient]() | Obtain the actual `Gradient`-type output by calling [`AnimatedGradient.observe`](https://pub.dev/documentation/spectrum/latest/spectrum/AnimatedGradient/observe.html) or by using the [`Gradient.animate(...)`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientUtils/animate.html) convenience method, which inherently returns `observe`. |
| :--------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |

Of course you may provide a number of `Tween`s for properties like [`Gradient.center`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientUtils/center.html)
or [`Gradient.begin`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientUtils/begin.html),
and these are provided with a [`TweenSpec`](https://pub.dev/documentation/spectrum/latest/spectrum/TweenSpec.html);
but consider other specialized functionalities: [`GradientAnimation.colorArithmetic`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientAnimation-class.html)
& [`GradientAnimation.stopsArithmetic`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientAnimation-class.html).

> ❓ *A `TweenSpec` is a new form of `typedef` wherein the definition is for a
> type of `Map` and not a type of `Function`.*

#### 📖 Gradient Storyboard

All the animatable descriptions fit snugly into a [`GradientStoryboard`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientStoryboard.html).
The `storyboard` maps one or more [`GradientAnimation`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientAnimation-class.html)
enum constants to a description object that correlates.

The above [softness](#-softness) and [ShadedSteps](#️-shaded-steps) example gifs
are made by an `AnimatedGradient`.

> *(Expect potential changes in functionality here in the future.)*

| `GradientAnimation` (storyboard `key`) | Description Object (storyboard `value`) |                    Literal                    |
| :------------------------------------: | :-------------------------------------: | :-------------------------------------------: |
|           `colorArithmetic`            |            `ColorArithmetic`            | `Color Function(Color color, double factor)`  |
|           `stopsArithmetic`            |            `StopsArithmetic`            | `double Function(double stop, double factor)` |
|              `tweenSpec`               |               `TweenSpec`               |    `Map<GradientProperty, Tween<dynamic>>`    |
|                 `none`                 |            `null` / anything            |               `null` / anything               |

In terms of [`GradientProperty`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientProperty-class.html)s,
the mapping is what would be expected. A property like `GradientProperty.center`
is mapped to a `Tween<AlignmentGeometry?>`, and one like `GradientProperty.radius`
expects a value of a `Tween<double>`.

```dart
final animatedGradient = AnimatedGradient(
  controller: _controller,
  gradient: RadialSteps(colors: Colors.red.complementTriad),
  storyboard: {
    // GradientAnimation.none: null, // disables any animations

    /// "colorArithmetic" expects a [ColorArithmetic].
    GradientAnimation.colorArithmetic: Shades.withOpacity,

    /// "stopsArithmetic" expects a [StopsArithmetic].
    GradientAnimation.stopsArithmetic: Maths.subtraction,
    // GradientAnimation.stopsArithmetic:Maths.addition,
    // GradientAnimation.stopsArithmetic:Maths.division,

    /// "tweenSpec" expects a [TweenSpec], which itself is a
    /// `Map<GradientProperty, Tween<dynamic>>`.
    GradientAnimation.tweenSpec: {
      GradientProperty.center: Tween<AlignmentGeometry>(
          begin: const Alignment(1, 1), end: const Alignment(-1, -1)),
      GradientProperty.focal: Tween<AlignmentGeometry>(
          begin: const Alignment(3, -1), end: const Alignment(-3, -1)),
      GradientProperty.radius: Tween<double>(begin: 0.5, end: 0),
      GradientProperty.focalRadius: Tween<double>(begin: 2, end: 0),
      GradientProperty.startAngle:
          Tween<double>(begin: -1.0 * 3.1415927, end: 0.0 * 3.1415927),
      GradientProperty.endAngle:
          Tween<double>(begin: 2.0 * 3.1415927, end: 4.0 * 3.1415927),
      GradientProperty.shadeFactor: StepTween(begin: -200, end: 0),
      GradientProperty.softness: Tween<double>(begin: 0, end: 0.14),
      . . .
    },
  },
);
```

> Any properties that do not apply to the provided `Gradient` type are ignored.

<div style='text-align:right'><a href='#-table-of-contents' title='Table of Contents'>📚</a></div>

### 📋 Override Copy With

As an advanced feature, if you are operating with bespoke `Gradient` types that
would not be hard-code recognized by this package, feel free to override the
[`GradientCopyWith`](https://pub.dev/documentation/spectrum/latest/spectrum/GradientCopyWith.html)
function in either a `GradientTween` or an `AnimatedGradient`.

This overriding function, which is expected to accept a large number of
potential parameters, can be programmed to return your bespoke type.

Provide this `GradientCopyWith` function as `GradientTween.overrideCopyWith`,
for example.

<br />

<div style='text-align:right'><a href='#-table-of-contents' title='Table of Contents'>📚</a></div>

## 🎨 Colors

### ➗ Operators

[`ColorOperators`](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators.html)
are on deck as well as some nice methods to go along.

Aside from operators for objectives such as [color inversion](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators/operator_unary_minus.html),
[averaging](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators/operator_truncate_divide.html)
two colors, [adding](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators/operator_plus.html)
or [subtracting](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators/operator_minus.html)
them from one another, [randomly making a choice](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators/operator_bitwise_or.html)
of one amongst several options, or [comparing the](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators/operator_greater.html)
[luminance](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperators/operator_less.html)
of two colors...

[`ColorOperatorsMethods`](https://pub.dev/documentation/spectrum/latest/spectrum/ColorOperatorsMethods.html)
exist for exposure of these extensions as well. These methods allow a 
convenience pass for a value denoted `strength` that may represent an "opacity"
at values ranging `0.0 .. 1.0` or represent an "alpha" component when greater
than or equal to `2` (clamped to `255`).

```dart
/// - [-], to invert a `Color`
///
/// - [>] & [<], to compare the luminance of `Color`s
///
/// - [+] & [-], to add/subtract the RGB components to/from one another,
/// maintaining the [alpha] from the original color `this`
///
/// - [~/], to average all components of two colors together, including [alpha]
///
/// - [|], to randomly choose a `Color`, either `this` or `Color other`;
/// unless the operand on the right is a `List<Color>`, then the random choice
/// may come from the list or `this`.
extension ColorOperators on Color { . . . }

/// - [inverted], for returning `-this`
/// - [compareLuminance], for returning the brighter or darker `Color`
///   utilizing [>]
/// - [or], for randomization by `Color` [|] `List<Color>`
///
/// The following methods resemble the operator counterparts but they have a
/// slot for provision of a `strength` or alpha/opacity override
/// (see [Spectrum.alphaChannel] for details):
/// - [add], to [+] one `Color` to another
/// - [subtract], to [-] one `Color` from another
/// - [average], to [~/] all channels of two `Color`s
extension ColorOperatorsMethods on Color { . . . }
```

<div style='text-align:right'><a href='#-table-of-contents' title='Table of Contents'>📚</a></div>

### 🗜️ Spectrum

An abstract class called [`Spectrum`](https://pub.dev/documentation/spectrum/latest/spectrum/Spectrum-class.html)
provides a few helper functions for `Color`s, such as [`Spectrum.alphaChannel()`](https://pub.dev/documentation/spectrum/latest/spectrum/Spectrum/alphaChannel.html)
that performs the same function as described by the parameter `strength` above.

Another static function [`Spectrum.materialColor()`](https://pub.dev/documentation/spectrum/latest/spectrum/Spectrum/materialColor.html)
allows the generation of an entire `MaterialColor` swatch from a single `Color`
value with customizable options. Many color generation modes are available: [`SwatchMode.shade`](https://pub.dev/documentation/spectrum/latest/spectrum/SwatchMode-class.html)
or [`SwatchMode.desaturate`](https://pub.dev/documentation/spectrum/latest/spectrum/SwatchMode-class.html),
as well as more specialized modes [`SwatchMode.complements`](https://pub.dev/documentation/spectrum/latest/spectrum/SwatchMode-class.html)
and [`SwatchMode.fade`](https://pub.dev/documentation/spectrum/latest/spectrum/SwatchMode-class.html).

To generate a `MaterialAccentColor` instead, check out [`Spectrum.materialAccent()`](https://pub.dev/documentation/spectrum/latest/spectrum/Spectrum/materialAccent.html).

[![Spectrum.materialColor generated palettes with SwatchMode descriptions](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/materialColor_small.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/materialColor.gif 'Click for full size | Spectrum.materialColor generated palettes with SwatchMode descriptions')

```dart
final color0 = Spectrum.materialColor(
    color,
    mode: SwatchMode.shade,
    factor: 200,
);
// 💡 The above has a shorthand: `color.asMaterialColor`, using shade @ 200
final color0a = Spectrum.materialAccent(
    color,
    mode: SwatchMode.shade,
    factor: 200,
);
// 💡 The above has a shorthand: `color.asMaterialAccent`, using shade @ 200

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
    // factor: 100 // TODO: provide same shading spread as SwatchMode.shade,
    // (currently only performs .withWhite(factor) on the provided color)
);
final color2a = Spectrum.materialAccent(
    color,
    mode: SwatchMode.fade,
);

final color3 = Spectrum.materialColor(
    color,
    mode: SwatchMode.complements,
    // This SwatchMode does not consider any factor.
    // (TODO: Allow tweaking the distance of the complements on the color wheel)
);
final color3a = Spectrum.materialAccent(
    color,
    mode: SwatchMode.complements,
);
```

> 💡 \
> With extensions on `MaterialColor` and `MaterialAccentColor`, employ getter
> `asList` and method `toList()` to convert these palettes into boiled-down
> `List<Color>`, such as:
> 
> ```dart
> // The getter does not insert the "primary" color at the beginning of the list.
> // (This value is typically mapped as `shade500` anyway.)
> final List<Color> shadesColor0 = color0.asList;
> 
> // The method has a flag to insert the "primary" at the beginning of the list.
> // Default is `true` to differentiate versatility with `asList`.
> final List<Color> shadesColor3a = color3a.toList(includePrimary: false);
> ```
> 
> This makes a `MaterialColor` or accent color a great candidate for feeding
> `Gradient.colors`.
> 
> ```dart
> final matColorGradient = LinearGradient(colors: shadesColor0);
> ```

Another extension adds a number of convenient getters and methods to any
instantiated `Color`. These utilities, called [`SpectrumUtils`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils.html)
offer two "categories" of functionality: the first currently has one method,
[`a.blend(b,t)`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/blend.html)
which is shorthand for `Color.lerp(a,b,t)`; the second category deals with the
generation of complementary colors.

<div style='text-align:right'><a href='#-table-of-contents' title='Table of Contents'>📚</a></div>

### 🤝 Complementary Colors

[`Color.generateComplements()`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/generateComplements.html)
is a method for turning a single `Color` into a `List` containing the original
and a quantity of complements that you specify.

> 💡 *Use `Color.generateComplements()` to create `Gradient.colors` in a cinch!*

An example would be `red.generateComplements(3)`, which actually has a more
efficient getter dubbed [`Color.complementTriad`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/complementTriad.html),
that would return `[red, green, blue]`.

`red.generateComplements(2)`, more efficiently gotten as [`red.complementPair`](https://pub.dev/documentation/spectrum/latest/spectrum/SpectrumUtils/complementPair.html)
would return red and its inversion: `[red, cyan]`.

[![Color, Color.complementPair, Color.complementTriad](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/complements/123.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/complements/123.gif 'Click for full size | Color, Color.complementPair, Color.complementTriad')

A call like `red.generateComplements(36)` returns a list beginning with red and
progressing through another 35 colors that, on the whole, resemble a gently
transitioning rainbow of colors.

[![Color.generateComplements(36) presents a rainbow where each color is 10 degrees apart on the color wheel](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/complements/36.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/complements/36.gif 'Click for full size | Color.generateComplements(36) presents a rainbow where each color is 10 degrees apart on the color wheel')

|                                                                                                                                                                                                                                                                                                                                                                                           |                                                                                                                                                           |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![Color.generateComplements(4), Color.generateComplements(5), Color.generateComplements(6)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/complements/456.gif)](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/complements/456.gif 'Click for full size \| Color.generateComplements(4), Color.generateComplements(5), Color.generateComplements(6)') | Consider `Color.generateComplements(4)`, `Color.generateComplements(5)` or `Color.generateComplements(6)` for a nice assortment of pairings to pick from. |

> The red color is `Color(0xFFFF0000)` and the pink color is `Color(0xFFFF61ED)`.

<br />

<div style='text-align:right'><a href='#-table-of-contents' title='Table of Contents'>📚</a></div>

## 🛣️ Roadmap

More to come. Package in progress. \
🐞 Bug reports very welcome!

 - ~~Flesh out README and documentation with example images and code snippets;~~
   full comments pass for maintained accuracy and increased clarity.
 - Improve different methods for `GradientTween`, ~~especially when considering
   new `Steps` type gradients~~ (see flag `isAgressive`) & tweening
   `IntermediateGradient`s themselves. Offer options for tween "mode".
   Support tweening `AnimatedGradient`.
 - Provide options for `Color.generateComplements()` such that the "distance"
   in color-wheel degrees could be customized, etc.
 - New `Color` utilities.
 - Self-animating variety of `AnimatedGradient`, which currently requires an
   `Animation<double>` parameter such as an `AnimationController`.
 - Provide true gradient storyboarding with multiple gradients and keyframes.
 - Brand new `Gradient` types? Consider expanding upon "shaded" concept.

<br />

---

## 🐸 [Zaba.app ― simple packages, simple names.](https://pub.dev/publishers/zaba.app/packages 'Other Flutter packages published by Zaba.app')

<details>
<summary>More by Zaba</summary>

### Widgets to wrap other widgets
- ## 🕹️ [xl](https://pub.dev/packages/xl 'Implement accelerometer-fueled interactions with a layering paradigm')
- ## 🌈 [foil](https://pub.dev/packages/foil 'Implement accelerometer-reactive gradients in a cinch, easily wrapping an existing Widget')
- ## 📜 [curtains](https://pub.dev/packages/curtains 'Provide animated shadow decorations for a scrollable to allude to unrevealed content')
---
### Container widget that wraps many functionalities
- ## 🌟 [surface](https://pub.dev/packages/surface 'Animated, morphing container with specs for Shape, Appearance, Filter, Tactility')
---
### Side-kick companions, work great alone or employed above
- ## 🆕 [neu](https://pub.dev/packages/neu 'Easily create neumorphic, or "clay-like" decorations, shadows, gradients, containers, and more')
- ## 🙋‍♂️ [img](https://pub.dev/packages/img 'An extended Image \"Too\" and DecorationImageToo that support an expanded \`Repeat.mirror\` painting mode')
- ## 🙋‍♂️ [icon](https://pub.dev/packages/icon 'An extended Icon \"Too\" for those that are not actually square, plus shadows support + IconUtils')
- ## 🏓 [ball](https://pub.dev/packages/ball 'A bouncy, position-mirroring splash factory that\'s totally customizable')
- ## 👥 [shadows](https://pub.dev/packages/shadows 'Convert a double-based \`elevation\` + BoxShadow and List\<BoxShadow\> extensions')
- ## 🎨 [spectrum](https://pub.dev/packages/spectrum 'Color and Gradient utilities such as GradientTween, copyWith, generateComplements for colors, AnimatedGradient, MaterialColor generation, and more')
</details>
