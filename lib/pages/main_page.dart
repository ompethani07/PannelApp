import 'package:flutter/material.dart';
import 'package:panelsapp/pages/accounts_page.dart';
import 'package:panelsapp/pages/explore_page.dart';
import 'package:panelsapp/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isVisible = true;
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(afterScrollResult: afterScrollResult),
      const ExplorePage(),
      const AccountsPage(),
    ];
  }

  // Function to toggle the visibility of the BottomNavigationBar
  afterScrollResult(bool visibility) {
    setState(() {
      _isVisible = visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // Animation duration
        transitionBuilder: (child, animation) {
          return SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1.0,
            child: child,
          );
        },
        child: _isVisible
            ? BottomNavigationBar(
          key: const ValueKey('BottomNavBar'), // Key to help AnimatedSwitcher
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          iconSize: 32,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined),
              label: "Account",
            ),
          ],
        )
            : const SizedBox.shrink(), // Placeholder widget when BottomNavigationBar is hidden
      ),
    );
  }
}
