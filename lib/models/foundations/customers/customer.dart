import 'package:hello_world/models/base_entity.dart';
import 'package:equatable/equatable.dart';

class Customer extends Equatable implements BaseEntity {
  @override
  final String id;
  final String name;
  final String email;
  final DateTime createdDate;
  final DateTime updatedDate;

  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.createdDate,
    required this.updatedDate,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  @override
  List<Object?> get props => [id, name, email, createdDate, updatedDate];
}