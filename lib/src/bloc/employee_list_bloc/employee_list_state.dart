part of 'employee_list_bloc.dart';

enum EmployeeListStatus { initial, success, loading, failure }

class EmployeeListState extends Equatable {
  final EmployeeListStatus status;
  final List<EmployeeList> employees;
  final int page;
  const EmployeeListState(
      {this.status = EmployeeListStatus.initial,
      this.employees = const <EmployeeList>[],
      this.page = 1});

  EmployeeListState copyWith(
          {EmployeeListStatus? status,
          List<EmployeeList>? employees,
          int? page}) =>
      EmployeeListState(
          status: status ?? this.status,
          employees: employees ?? this.employees,
          page: page ?? this.page);

  @override
  List<Object> get props => [status, employees, page];
}
