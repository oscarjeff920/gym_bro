class MovementTable {
  final int? id;
  final String name;

  MovementTable({this.id, required this.name});

  factory MovementTable.fromMap(Map<String, dynamic> map) {
    return MovementTable(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }
}