import 'dart:async';

import 'package:assignment/src/controllers/employee_controller.dart';
import 'package:assignment/src/models/employee_list/employee_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc() : super(const EmployeeListState()) {
    on<FetchEmployees>(_onFetch);
    on<SearchEmployees>(_onSearch);
  }

  FutureOr<void> _onFetch(
      FetchEmployees event, Emitter<EmployeeListState> emit) async {
    try {
      if (state.status != EmployeeListStatus.initial) {
        emit(state.copyWith(status: EmployeeListStatus.loading));
      }

      if (state.status == EmployeeListStatus.initial) {
        Map<String, Object> jsonData = {
          "page": "${state.page}",
          "limit": "10",
        };
        final employees =
            await EmployeeController().fetchEmployeeList(jsonData);
        return emit(state.copyWith(
            status: EmployeeListStatus.success,
            page: state.page,
            employees: employees
                .map<EmployeeList>((e) => EmployeeList.fromJson(e))
                .toList()));
      }
      Map<String, Object> jsonData = {
        "page": "${event.page}",
        "limit": "10",
      };
      final employees = await EmployeeController().fetchEmployeeList(jsonData);

      emit(state.copyWith(
          status: EmployeeListStatus.success,
          page: event.page,
          employees: List.of(state.employees)
            ..addAll(employees
                .map<EmployeeList>((e) => EmployeeList.fromJson(e))
                .toList())));
    } catch (e) {
      emit(state.copyWith(status: EmployeeListStatus.failure));
    }
  }

  FutureOr<void> _onSearch(
      SearchEmployees event, Emitter<EmployeeListState> emit) async {
    try {
      Map<String, Object> jsonData = {
        "page": "${state.page}",
        "limit": "10",
        "search": event.searchText ?? "",
        "sortBy": (event.sortBy == null || event.sortBy == "none")
            ? ""
            : event.sortBy!
      };
      final employees = await EmployeeController().fetchEmployeeList(jsonData);
      return emit(state.copyWith(
          status: EmployeeListStatus.success,
          page: state.page,
          employees: employees
              .map<EmployeeList>((e) => EmployeeList.fromJson(e))
              .toList()));
    } catch (e) {
      emit(state.copyWith(status: EmployeeListStatus.failure));
    }
  }
}
