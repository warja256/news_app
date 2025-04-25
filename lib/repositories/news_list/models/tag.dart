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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
    };
  }
}
