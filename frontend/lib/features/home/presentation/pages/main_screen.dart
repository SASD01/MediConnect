import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import 'home_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const Center(child: Text('Calendar Tab (Coming Soon)')),
    const Center(child: Text('Profile Tab (Coming Soon)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: const Color(0xFF9CA3AF),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Symbols.home, fill: 0.0),
              activeIcon: Icon(Symbols.home, fill: 1.0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Symbols.calendar_add_on, fill: 0.0),
              activeIcon: Icon(Symbols.calendar_add_on, fill: 1.0),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Symbols.account_circle, fill: 0.0),
              activeIcon: Icon(Symbols.account_circle, fill: 1.0),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
