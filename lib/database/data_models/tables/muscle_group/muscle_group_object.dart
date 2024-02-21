class MuscleGroup {
  final int? id;
  final String name;

  MuscleGroup({this.id, required this.name});

  factory MuscleGroup.fromMap(Map<String, dynamic> map) {
    return MuscleGroup(
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