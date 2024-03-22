class SourceModel {
  String? id;
  String name;

  SourceModel({
    required this.id,
    required this.name,
  });

  SourceModel copyWith({
    String? id,
    String? name,
  }) {
    return SourceModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SourceModel.fromMap(Map<String, dynamic> map) {
    return SourceModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
    );
  }
}
