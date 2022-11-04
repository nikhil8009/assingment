part of 'employee_profile_bloc.dart';

abstract class EmployeeProfileEvent extends Equatable {
  const EmployeeProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployeeDetails extends EmployeeProfileEvent {
  final int? id;
  const FetchEmployeeDetails({this.id});
}
