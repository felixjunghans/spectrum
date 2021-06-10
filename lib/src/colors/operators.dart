/// Provides `Color` operators.
library spectrum;

import '../common.dart';

/// ---
/// `Operators` extends `Color`
/// - ➕ [add]: Add one `Color` to another
/// - ➕ [and]: Add, including alphas
/// - ➖ [subtract]: Subtract one `Color` from another
/// - ➖ [xor]: Subtract, including alphas
/// - [average]: Average all channels of two `Color`s
/// - [or]: Randomization by `Color` or `List<Color>`
extension Operators on Color {
  /// Returns `true` if `this Color` is "lighter" than `other` according to
  /// method [computeLuminance].
  ///
  // ignore: lines_longer_than_80_chars
  ///     bool operator >(Color other) => computeLuminance() > other.computeLuminance();
  bool operator >(Color other) => computeLuminance() > other.computeLuminance();

  /// Returns `true` if `this Color` is "darker" than `other` according to
  /// method [computeLuminance].
  ///
  // ignore: lines_longer_than_80_chars
  ///     bool operator <(Color other) => computeLuminance() < other.computeLuminance();
  bool operator <(Color other) => computeLuminance() < other.computeLuminance();

  /// Add the `red`, `green`, and `blue` channels
  /// of `other` with those of `this Color`.
  ///
  /// The resultant [alpha] is maintained from `this`.
  ///
  /// To *also add* the `alpha` from each `Color`, see [&].
  Color operator +(Color other) => Color.fromARGB(
        alpha,
        (red + other.red).restricted,
        (green + other.green).restricted,
        (blue + other.blue).restricted,
      );

  /// Add the `alpha`, `red`, `green`, and `blue` channels
  /// of `other` with those of `this Color`.
  ///
  /// To maintain [alpha] from `this`, see [+].
  Color operator &(Color other) => Color.fromARGB(
        (alpha + other.alpha).restricted,
        (red + other.red).restricted,
        (green + other.green).restricted,
        (blue + other.blue).restricted,
      );

  /// Subtract the `red`, `green`, and `blue` channels
  /// of `other` from those of `this Color`.
  ///
  /// The resultant [alpha] is maintained from `this`.
  ///
  /// To *also subtract* the `alpha` from each `Color`, see [^].
  Color operator -(Color other) => Color.fromARGB(
        alpha,
        (red - other.red).restricted,
        (green - other.green).restricted,
        (blue - other.blue).restricted,
      );

  /// Subtract the `alpha`, `red`, `green`, and `blue` channels
  /// of `other` from those of `this Color`.
  ///
  /// To maintain [alpha] from `this`, see [-].
  Color operator ^(Color other) => Color.fromARGB(
        (alpha - other.alpha).restricted,
        (red - other.red).restricted,
        (green - other.green).restricted,
        (blue - other.blue).restricted,
      );

  /// Average the `alpha`, `red`, `green`, and `blue` channels
  /// of a `Color` with another `other`.
  Color operator ~/(Color other) => Color.fromARGB(
        ((alpha + other.alpha) ~/ 2).restricted,
        ((red + other.red) ~/ 2).restricted,
        ((green + other.green) ~/ 2).restricted,
        ((blue + other.blue) ~/ 2).restricted,
      );

  /// Random `Color` access.
  ///
  /// If `others is Color`, the return value is `this` *or* `others`.
  ///
  /// If `others is List<Color>`, the return value is `this` *or* one of the
  /// entries from `others`.
  Color operator |(dynamic others) => (others is Color)
      // Expanding first enables the mingling of Color-subtype objects,
      // like MaterialColors and MaterialAccentColors.
      ? (List.from([
          [others] + [this]
        ].expand((list) => list).toList())
            ..shuffle())
          .first
      : (others is List<Color>)
          ? (List.from([
              others,
              [this]
            ].expand((list) => list).toList())
                ..shuffle())
              .first
          : this;

  /// Parameter `blendModel` is expected to be a `List<dynamic>` whose
  /// first entry is another `Color` to blend with `this` while the second
  /// entry is a double ranging `0..1` that represent the distribution of
  /// strength when blending the two colors.
  /// - `Colors.red >> [otherColor, 0]` would return a `Color` equivalent to
  ///   red.
  /// - `Colors.red >> [otherColor, 1]` returns `otherColor`.
  ///
  /// If `blendModel` does not fit the required description, `this Color`
  /// is returned as a fallback with an assert trigger when in debug mode.
  Color operator >>(List<dynamic> blendModel) {
    final isLengthed = blendModel.length == 2;
    assert(
        isLengthed,
        'blendModel is expected to be a'
        'two-entry List<dynamic> such as [Color(0xFFFFFFFF), 0.5]. \n'
        'Provided model: $blendModel.');

    final isTyped = blendModel.first is Color && blendModel.last is double;
    assert(
        isTyped,
        'blendModel is expected to be a'
        'List with a Color then a double such as [Color(0xFFFFFFFF), 0.5]. \n'
        'Provided model: $blendModel.');

    if (!isLengthed || !isTyped) return this;

    final other = blendModel.first as Color;
    final curve = blendModel.last as double;
    final inverse = 1 - curve;
    return Color.fromARGB(
      alpha,
      (red * inverse + other.red * curve).restricted,
      (green * inverse + other.green * curve).restricted,
      (blue * inverse + other.blue * curve).restricted,
    );
  }

  /// Add the `red`, `green`, and `blue` channels of `other` with
  /// those of `this Color`. The resultant [alpha] is maintained from `this`,
  /// unless a `strength` would be specified which is used instead.
  ///
  /// Exposure `method` for [+] `operator`.
  Color add(Color other, {double? strength}) {
    assert(
      (strength ?? 0) >= 0 && (strength ?? 0) <= 1.0,
      'Provide a `strength` between 0..1',
    );
    return withOpacity(strength ?? opacity) + other;
  }

  /// Consider [add] except the resultant [alpha]
  /// is the sum of both `Color`s' `alpha`.
  ///
  /// Exposure `method` for [&] `operator`.
  Color and(Color other) => this & other;

  /// Subtract the `red`, `green`, and `blue` channels of `other` from
  /// those of `this Color`. The resultant [alpha] is maintained from `this`,
  /// unless a `strength` would be specified which is used instead.
  ///
  /// Consider [xor], where the `alpha` channel is
  /// the difference of each `Color`s' `alpha`.
  ///
  /// Exposure `method` for [-] `operator`.
  Color subtract(Color other, {double? strength}) {
    assert(
      (strength ?? 0) >= 0 && (strength ?? 0) <= 1.0,
      'Provide a `strength` between 0..1',
    );
    return withOpacity(strength ?? opacity) - other;
  }

  /// Consider [subtract] except the resultant [alpha]
  /// is the difference of both `Color`s' `alpha`.
  ///
  /// Exposure `method` for [^] `operator`.
  Color xor(Color other) => this ^ other;

  /// Average the `alpha`, `red`, `green`, and `blue` channels
  /// of a `Color` with another `other`.
  ///
  /// Exposure `method` for [~/] `operator`.
  Color average(Color other) => this ~/ other;

  /// Exposure `method` for [|] `operator`: random `Color` access.
  ///
  /// If `others is Color`, the return value is `this` or `others`.
  ///
  /// If `others is List<Color>`, the return value is `this` or one of the
  /// entries from `others`.
  Color or(dynamic others) => this | others;
}
