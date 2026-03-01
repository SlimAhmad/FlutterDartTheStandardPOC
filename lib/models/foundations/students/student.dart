import 'package:equatable/equatable.dart';
import 'package:hello_world/models/base_entity.dart';

class Student extends Equatable implements BaseEntity {
  @override
  final String id;

  final String name;
  final String email;
  final DateTime createdDate;
  final DateTime updatedDate;

  const Student({
    required this.id,
    required this.name,
    required this.email,
    required this.createdDate,
    required this.updatedDate,
  });

  Student copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  @override
  List<Object?> get props => [id, name, email, createdDate, updatedDate];

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    createdDate: DateTime.parse(json['createdDate'] as String),
    updatedDate: DateTime.parse(json['updatedDate'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'createdDate': createdDate,
    'updatedDate': updatedDate,
  };
}
