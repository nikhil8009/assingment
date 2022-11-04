import 'package:assignment/src/core/core.dart';

class EmployeeController extends Core {
  //Employee List
  Future<dynamic> fetchEmployeeList(Map<String, Object> jsonData) async =>
      await requestGET(path: 'employee', parameters: jsonData);

//Employee Profile
  Future<dynamic> fetchEmployeeProfile(int? id) async => await requestGET(
        path: 'employee/$id',
      );

//Checkins
  Future<dynamic> fetchCheckins(int? id) async =>
      await requestGET(path: 'employee/$id/checkin');
}
