class Recentworkoption {
  final String placename;
  final String subtitle;
  final String description;
  final int price;
  final String image;
  final int time;
  final String area;
  final String id;

  const Recentworkoption({
    required this.placename,
    required this.id,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.image,
    required this.time,
    required this.area,
  });
}

class Recentworkmodel {
  final String id;
  final String title;
  final String imageurl;
  final String? videoUrl;
  final String ratings;
  final int price;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> packages;
  final List<Recentworkoption> selectedoptoins;

  Recentworkmodel({
    required this.id,
    required this.title,
    required this.ratings,
    required this.imageurl,
    required this.price,
    this.videoUrl,
    this.categories = const [],
    this.packages = const [],
    this.selectedoptoins = const [],
  });

  factory Recentworkmodel.fromJson(Map<String, dynamic> json) {
    return Recentworkmodel(
      id: json['id'] as String,
      ratings: json['ratings'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      imageurl: json['imageurl'] as String,
      videoUrl: json['videoUrl'] as String?,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>() ??
          [],
      packages:
          (json['packages'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
          [],
    );
  }
}
