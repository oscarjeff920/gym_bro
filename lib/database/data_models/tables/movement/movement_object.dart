class Movement {
  final int? id;
  final String name;

  Movement({this.id, required this.name});

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }
}