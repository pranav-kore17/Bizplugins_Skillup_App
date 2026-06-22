class VideoModel {
  final String title;
  final String thumbnail;
  final String url;
  final String description;
  final String category;

  bool isCompleted;
  Duration lastPosition;
  Duration totalDuration;

  VideoModel({
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.description,
    this.category = "Sales Videos",
    this.isCompleted = false,
    this.lastPosition = Duration.zero,
    this.totalDuration = Duration.zero,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'],
      url: json['url'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      category: json['category'] ?? "Sales Videos",
    );
  }
}