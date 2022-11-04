import 'dart:async';

import 'package:assignment/src/controllers/employee_controller.dart';
import 'package:assignment/src/models/checkin/checkin.dart';
import 'package:assignment/src/models/employee_list/employee_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_profile_event.dart';
part 'employee_profile_state.dart';

class EmployeeProfileBloc
    extends Bloc<EmployeeProfileEvent, EmployeeProfileState> {
  EmployeeProfileBloc() : super(const EmployeeProfileState()) {
    on<FetchEmployeeDetails>(_onFetchDetails);
  }

  FutureOr<void> _onFetchDetails(
      FetchEmployeeDetails event, Emitter<EmployeeProfileState> emit) async {
    try {
      emit(state.copyWith(status: ProfileStatus.initial));
      final result = await EmployeeController().fetchEmployeeProfile(event.id);
      final checkins = await EmployeeController().fetchCheckins(event.id);
      emit(state.copyWith(
          status: ProfileStatus.success,
          employee: EmployeeList.fromJson(result),
          checkins:
              checkins.map<Checkin>((e) => Checkin.fromJson(e)).toList()));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }
}
