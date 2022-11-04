import 'package:assignment/src/bloc/employee_profile_bloc/employee_profile_bloc.dart';
import 'package:assignment/src/components/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/bloc/employee_list_bloc/employee_list_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => EmployeeListBloc()..add(const FetchEmployees()),
        ),
        BlocProvider(create: (context) => EmployeeProfileBloc()),
      ], child: const BottomBar()),
    );
  }
}
