import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_list.g.dart';

@JsonSerializable()
class EmployeeList extends Equatable {
  final DateTime? createdAt;
  final String? name;
  final String? avatar;
  final String? email;
  final String? phone;
  final List<String>? department;
  final DateTime? birthday;
  final String? country;
  final String? id;

  const EmployeeList({
    this.createdAt,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.department,
    this.birthday,
    this.country,
    this.id,
  });

  factory EmployeeList.fromJson(Map<String, dynamic> json) {
    return _$EmployeeListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmployeeListToJson(this);

  EmployeeList copyWith({
    DateTime? createdAt,
    String? name,
    String? avatar,
    String? email,
    String? phone,
    List<String>? department,
    DateTime? birthday,
    String? country,
    String? id,
  }) {
    return EmployeeList(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      birthday: birthday ?? this.birthday,
      country: country ?? this.country,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props {
    return [
      createdAt,
      name,
      avatar,
      email,
      phone,
      department,
      birthday,
      country,
      id,
    ];
  }
}
