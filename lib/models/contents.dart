import 'dart:convert';

class Contents {
  Contents({
    required this.order,
    required this.content,
  });

  String order;
  List<Content> content;

  factory Contents.fromJson(String str) => Contents.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Contents.fromMap(Map<String, dynamic> json) => Contents(
        order: json["order"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "order": order,
        "content": List<dynamic>.from(content.map((x) => x.toMap())),
      };
}

class Content {
  Content({
    required this.name,
    required this.type,
  });

  String name;
  String type;

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
      };
}
