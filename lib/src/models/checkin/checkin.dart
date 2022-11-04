import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checkin.g.dart';

@JsonSerializable()
class Checkin extends Equatable {
  final DateTime? checkin;
  final String? location;
  final String? purpose;
  final String? id;
  final String? employeeId;

  const Checkin({
    this.checkin,
    this.location,
    this.purpose,
    this.id,
    this.employeeId,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) {
    return _$CheckinFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckinToJson(this);

  Checkin copyWith({
    DateTime? checkin,
    String? location,
    String? purpose,
    String? id,
    String? employeeId,
  }) {
    return Checkin(
      checkin: checkin ?? this.checkin,
      location: location ?? this.location,
      purpose: purpose ?? this.purpose,
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  @override
  List<Object?> get props => [checkin, location, purpose, id, employeeId];
}
