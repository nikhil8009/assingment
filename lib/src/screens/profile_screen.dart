import 'package:assignment/src/bloc/employee_profile_bloc/employee_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: BlocBuilder<EmployeeProfileBloc, EmployeeProfileState>(
          builder: (context, state) {
        if (state.status == ProfileStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ProfileStatus.failure) {
          return const Center(
            child: Text("No data here"),
          );
        }

        return Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  state.employee.avatar!,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                state.employee.name!,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(state.employee.email!),
                  Text(state.employee.phone!),
                  Text(state.employee.country!)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Checkins",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  )),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.checkins[index].purpose!),
                ),
                itemCount: state.checkins.length,
              )
            ],
          ),
        );
      }),
    );
  }
}
