part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployees extends EmployeeListEvent {
  final int? page;

  const FetchEmployees({
    this.page,
  });
}

class SearchEmployees extends EmployeeListEvent {
  final String? searchText, sortBy;
  const SearchEmployees({this.searchText, this.sortBy});
}
