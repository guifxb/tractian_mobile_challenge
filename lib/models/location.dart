class Location {
  final int id;
  final String name;
  final int parentId;

  Location({required this.id, required this.name, required this.parentId});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
