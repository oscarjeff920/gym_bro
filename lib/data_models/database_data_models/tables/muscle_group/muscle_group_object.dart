class MuscleGroupTable {
  final int? id;
  final String name;

  MuscleGroupTable({this.id, required this.name});

  factory MuscleGroupTable.fromMap(Map<String, dynamic> map) {
    return MuscleGroupTable(
        id: map['id'],
        name: map['name']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name
    };
  }
}