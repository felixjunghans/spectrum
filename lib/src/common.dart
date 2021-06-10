import 'colors/restrict.dart';

export 'package:flutter/material.dart';

export 'colors/restrict.dart';
export 'colors/shading.dart';
export 'gradients/interpolation.dart';
export 'gradients/nill.dart';
export 'gradients/utils.dart';
export 'models/blend.dart';

/// Considers the provided number(?) [strength].
///
/// If this number is a [double] between `0..1`, the return is
/// `0xFF * strength`.
///
/// After that check, if `strength` is an [int], the return is `strength`.
///
/// Else returns `null`.
int? distinguishTransparency(num? strength) =>
    strength is double && (strength >= 0 && strength <= 1)
        ? (0xFF * strength).restricted
        : strength is int
            ? strength.restricted
            : null;
