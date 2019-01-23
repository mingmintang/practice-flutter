import 'dart:convert';

class Practice {
  final String title;
  final String route;

  Practice({this.title, this.route});

  factory Practice.fromJson(Map<String, dynamic> json) {
    return Practice(
      title: json['title'] as String,
      route: json['route'] as String
    );
  }

  static List<Practice> createList() {
    final parsed = json.decode(contentJson).cast<Map<String, dynamic>>();
    return parsed.map<Practice>((json) => Practice.fromJson(json)).toList();
  }

  static final String contentJson = '''
  [
    {"title": "Baby Names", "route": "/babynames"},
    {"title": "Shrine", "route": "/shrine"}
  ]
  ''';
}