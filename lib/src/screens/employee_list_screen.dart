import 'package:assignment/src/bloc/employee_list_bloc/employee_list_bloc.dart';
import 'package:assignment/src/bloc/employee_profile_bloc/employee_profile_bloc.dart';
import 'package:assignment/src/models/employee_list/employee_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../components/bottom_bar.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  static final BottomNavigationBar navigationBar =
      globalKey.currentWidget as BottomNavigationBar;

  static final List<String> sortOptions = [
    "none",
    "name",
    "email",
    "createdAt",
    "birthday"
  ];

  static final ValueNotifier<String> _selectedSortOption =
      ValueNotifier("none");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee List")),
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
          builder: (context, state) {
        if (state.status == EmployeeListStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final source = TableRow(data: state.employees);
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    decoration: const InputDecoration(hintText: "search here"),
                    onChanged: (value) => context.read<EmployeeListBloc>().add(
                        SearchEmployees(
                            searchText: value.trim(),
                            sortBy: _selectedSortOption.value)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Sort",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                ValueListenableBuilder(
                    valueListenable: _selectedSortOption,
                    builder: (context, value, widget) {
                      return SizedBox(
                          width: 150,
                          child: DropdownButtonFormField(
                              value: value,
                              items: sortOptions
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                _selectedSortOption.value = value!;
                                context
                                    .read<EmployeeListBloc>()
                                    .add(SearchEmployees(sortBy: value));
                              }));
                    })
              ],
            ),
            Expanded(
              child: SfDataGrid(
                  onCellTap: (details) {
                    context.read<EmployeeProfileBloc>().add(
                        FetchEmployeeDetails(
                            id: int.parse(source.effectiveRows[
                                    details.rowColumnIndex.rowIndex - 1]
                                .getCells()[details.rowColumnIndex.columnIndex]
                                .value)));
                    navigationBar.onTap!(1);
                  },
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: [
                    GridColumn(columnName: "ID", label: const Text("ID")),
                    GridColumn(columnName: "Name", label: const Text("Name")),
                  ],
                  loadMoreViewBuilder:
                      (BuildContext context, LoadMoreRows loadMoreRows) {
                    if (state.status == EmployeeListStatus.loading) {
                      return Container(
                          height: 60.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: BorderDirectional(
                                  top: BorderSide(
                                      width: 1.0,
                                      color: Color.fromRGBO(0, 0, 0, 0.26)))),
                          child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.deepPurple)));
                    }
                    return Container(
                        height: 60.0,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: BorderDirectional(
                                top: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(0, 0, 0, 0.26)))),
                        child: SizedBox(
                            height: 36.0,
                            width: 142.0,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.purple)),
                                child: const Text('LOAD MORE',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () async {
                                  context.read<EmployeeListBloc>().add(
                                      FetchEmployees(page: state.page + 1));
                                })));
                  },
                  source: source),
            ),
          ],
        );
      }),
    );
  }
}

class TableRow extends DataGridSource {
  final List<EmployeeList>? data;
  final BuildContext? context;
  TableRow({this.data, this.context});

  @override
  List<DataGridRow> get rows => data!.map<DataGridRow>((e) {
        return DataGridRow(cells: [
          DataGridCell(columnName: 'ID', value: e.id),
          DataGridCell(columnName: 'Name', value: e.name),
        ]);
      }).toList(growable: false);

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Text(row.getCells()[0].value),
      Text(row.getCells()[1].value),
    ]);
  }
}
