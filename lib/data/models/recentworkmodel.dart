class Recentworkmodel {
  final String id;
  final String title;
  final String imageurl;
  final String? videoUrl;
  final String ratings;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> packages;

  Recentworkmodel({
    required this.id,
    required this.title,
    required this.ratings,
    required this.imageurl,
    this.videoUrl,
    this.categories = const [],
    this.packages = const [],
  });

  factory Recentworkmodel.fromJson(Map<String, dynamic> json) {
    return Recentworkmodel(
      id: json['id'] as String,
      ratings: json['ratings'] as String,
      title: json['title'] as String,
      imageurl: json['imageurl'] as String,
      videoUrl: json['videoUrl'] as String?,
      categories: (json['categories'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
      packages: (json['packages'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
    );
  }
}