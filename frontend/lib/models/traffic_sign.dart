class TrafficSign {
  final String name;
  final String description;
  final String image;

  TrafficSign({
    required this.name,
    required this.description,
    required this.image,
  });

  factory TrafficSign.fromJson(Map<String, dynamic> json) {
    return TrafficSign(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}