import 'package:charity/src/features/favourite/favourite.dart';
import 'package:charity/src/features/home/screen/home_screen.dart';
import 'package:charity/src/features/profile_management/profile_management_screen.dart';
import 'package:charity/src/features/zakat_calculator/screens/zakat_calculator_page.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  List<Widget> tabs = [
    HomeScreen(),
    FavouriteScreen(),
    ZakatCalculatorPage(),
    const ProfileManagementScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: AppColors.primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: t.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: t.favourite,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: t.zakat,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: t.account,
          ),
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
