import 'package:charity/src/features/home/screen/home_screen.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  List<Widget> tabs = [HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: AppColors.primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "favourite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
      body: tabs[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
