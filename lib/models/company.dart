import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id;
  final String name;

  const Company({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
    );
  }
}

