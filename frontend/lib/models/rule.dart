class Rule {
  String title;
  List<String> content;

  String? titleUr;
  List<String>? contentUr;

  Rule({
    required this.title,
    required this.content,
    this.titleUr,
    this.contentUr,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      title: json['title'] ?? "",

      // ✅ Handle BOTH 'content' and 'sections'
      content: _convertToList(
        json['content'] ?? json['sections'],
      ),

      // ✅ Handle Urdu title (support both naming styles)
      titleUr: json['title_ur'] ?? json['titleUr'],

      // ✅ Handle BOTH 'content_ur' and 'sections_ur'
      contentUr: json['content_ur'] != null
          ? _convertToList(json['content_ur'])
          : json['sections_ur'] != null
              ? _convertToList(json['sections_ur'])
              : null,
    );
  }

  /// 🔥 Handles BOTH String and List safely
  static List<String> _convertToList(dynamic data) {
    if (data == null) return [];

    // If already a list
    if (data is List) {
      return data.map((e) => e.toString()).toList();
    }

    // If it's a string → split into lines
    if (data is String) {
      return data
          .split("\n")
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    return [];
  }
}