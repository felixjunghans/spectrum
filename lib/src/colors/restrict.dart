library spectrum;

///     int get restricted => clamp(0,255).truncate();
extension Restrict on num {
  ///     int get restricted => clamp(0,255).truncate();
  ///
  /// A quick getter for `num`s that returns an `int` that has been
  /// clamped between `0..255` by integer division with `1` or `0xFF`.
  ///
  /// This value is in the valid range for a component of a `Color`.
  int get restricted => clamp(0, 255).truncate();
  // int get restricted => this ~/ 0xff;
}
