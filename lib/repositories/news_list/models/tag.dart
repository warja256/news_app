class Tag {
  final String name;
  final String color;

  Tag({required this.name, required this.color});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      color: json['color'],
    );
  }
}
