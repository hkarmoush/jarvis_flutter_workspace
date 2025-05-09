/// Utility extensions for working with Duration
extension DurationExtensions on Duration {
  /// Formats the duration as HH:mm:ss
  String toHms() {
    final h = inHours;
    final m = inMinutes.remainder(60);
    final s = inSeconds.remainder(60);
    final hh = h.toString().padLeft(2, '0');
    final mm = m.toString().padLeft(2, '0');
    final ss = s.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }

  /// Returns a human-friendly representation like "2h 3m".
  String humanFriendly() {
    final parts = <String>[];
    final h = inHours;
    final m = inMinutes.remainder(60);
    if (h > 0) parts.add('${h}h');
    if (m > 0) parts.add('${m}m');
    return parts.join(' ');
  }
}
