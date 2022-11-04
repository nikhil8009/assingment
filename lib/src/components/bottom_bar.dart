import 'package:assignment/src/screens/employee_list_screen.dart';
import 'package:assignment/src/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');

class _BottomBarState extends State<BottomBar> {
  static final List<Widget> _screens = <Widget>[
    const EmployeeListScreen(),
    const ProfileScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          key: globalKey,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: "Employee List",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: (val) => setState(() {
                _currentIndex = val;
              }),
          elevation: 5),
    );
  }
}
