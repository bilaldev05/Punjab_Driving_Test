class TrafficSign {
  final String name;
  final String description;
  final String image;

  // Urdu fields
  final String nameUr;
  final String descriptionUr;

  TrafficSign({
    required this.name,
    required this.description,
    required this.image,
    required this.nameUr,
    required this.descriptionUr,
  });

  factory TrafficSign.fromJson(Map<String, dynamic> json) => TrafficSign(
        name: json['name'],
        description: json['description'],
        image: json['image'],
        nameUr: json['nameUr'] ?? json['name'],
        descriptionUr: json['descriptionUr'] ?? json['description'],
      );
}