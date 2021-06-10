/// - 🔦⬛⬜ [Shading] `extension on Color`
library spectrum;

import '../common.dart';

/// ---
/// 🔦 `WithShading` extends `Color`
/// - ⬛ [withBlack]: Subtract a single value from all RGB channels
/// - ⬜ [withWhite]: Add a single value to all RGB channels
extension Shading on Color {
  /// The value `add` is added to each RGB channel of `this`
  /// and clamped to be `255` or less.
  ///
  /// Alpha channel of the returned color is maintained from `this` unless
  /// a convenience pass is made for `dynamic` [strength], which may be a
  /// double ranging `0..1` to represent opacity or an int ranging `2..255`
  /// to represent alpha.
  ///
  /// This method is equal and opposite to [withBlack]. A negative value
  /// provided here is equivalent to the positive version of that value given
  /// to [withBlack].
  Color withWhite(int add, [dynamic strength]) => Color.fromARGB(
        distinguishTransparency(strength) ?? alpha,
        (red + add).restricted,
        (green + add).restricted,
        (blue + add).restricted,
      );

  /// The value `subtract` is subtracted from each RGB channel of `this`
  /// and clamped to be non-negative.
  ///
  /// Alpha channel of the returned color is maintained from `this` unless
  /// a convenience pass is made for `dynamic` [strength], which may be a
  /// double ranging `0..1` to represent opacity or an int ranging `2..255`
  /// to represent alpha.
  ///
  /// This method is equal and opposite to [withWhite]. A negative value
  /// provided here is equivalent to the positive version of that value given
  /// to [withWhite].
  Color withBlack(int subtract, [dynamic strength]) => Color.fromARGB(
        distinguishTransparency(strength) ?? alpha,
        (red - subtract).restricted,
        (green - subtract).restricted,
        (blue - subtract).restricted,
      );
}
