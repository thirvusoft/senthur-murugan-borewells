import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:senthur_murugan/page/customer_list.dart';
import 'package:senthur_murugan/page/employee_list.dart';
import 'package:senthur_murugan/page/home_page.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  var _selectedTab = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Homepage(),
    const Employee(),
    const Cusomerlist(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: const Color(0xFFF6F6F6),
        currentIndex: _selectedTab,
        onTap: (position) {
          setState(() {
            _selectedTab = position;
          });
        },
        items: [
          SalomonBottomBarItem(
              selectedColor: const Color(0xFF752FFF),
              title: const Text('Home'),
              icon: const HeroIcon(HeroIcons.home)),
          SalomonBottomBarItem(
              selectedColor: const Color(0xFF752FFF),
              title: const Text('Attendance '),
              icon: const HeroIcon(HeroIcons.calendarDays)),
          SalomonBottomBarItem(
              selectedColor: const Color(0xFF752FFF),
              title: const Text('Customer'),
              icon: const HeroIcon(HeroIcons.userPlus)),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedTab),
    );
  }
}
