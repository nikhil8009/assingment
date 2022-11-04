part of 'employee_profile_bloc.dart';

enum ProfileStatus { initial, success, failure }

class EmployeeProfileState extends Equatable {
  final ProfileStatus status;
  final EmployeeList employee;
  final List<Checkin> checkins;
  const EmployeeProfileState(
      {this.status = ProfileStatus.initial,
      this.employee = const EmployeeList(),
      this.checkins = const <Checkin>[]});

  EmployeeProfileState copyWith(
          {ProfileStatus? status,
          EmployeeList? employee,
          List<Checkin>? checkins}) =>
      EmployeeProfileState(
          status: status ?? this.status,
          employee: employee ?? this.employee,
          checkins: checkins ?? this.checkins);
  @override
  List<Object> get props => [status, employee, checkins];
}
