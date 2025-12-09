class WatchProgress {
  final String profileId;
  final String contentId;
  final String contentType; // movie / episode
  final Duration position;
  final Duration duration;
  final bool completed;
  final DateTime watchedAt;
  final String? parentSeriesId;

  const WatchProgress({
    required this.profileId,
    required this.contentId,
    required this.contentType,
    required this.position,
    required this.duration,
    required this.completed,
    required this.watchedAt,
    this.parentSeriesId,
  });
}

