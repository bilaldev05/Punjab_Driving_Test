class Rule {
  final String title;
  final List<String> content;
  final int? chapterNumber;

  final String? titleUr;
  final List<String>? contentUr;

  final List<dynamic>? sections;

  Rule({
    required this.title,
    required this.content,
    this.chapterNumber,
    this.titleUr,
    this.contentUr,
    this.sections,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      title: json['title']?.toString() ?? "",
      chapterNumber: _toInt(json['chapter'] ?? json['chapter_number']),
      content: _convertToList(json['content'] ?? []),
      titleUr: json['title_ur']?.toString(),
      contentUr: _convertToList(json['content_ur'] ?? json['sections_ur'] ?? []),
      sections: json['sections'] ?? [],
    );
  }

  static List<String> _convertToList(dynamic data) {
    if (data == null) return [];
    if (data is List) return data.map((e) => e.toString()).toList();
    if (data is String) {
      return data
          .split("\n")
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [];
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}