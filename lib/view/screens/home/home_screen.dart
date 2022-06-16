import 'package:flutter/material.dart';
import 'package:wallpaper/constants/colors.dart';

import '../favorites/favorites_screen.dart';
import '../photos/photos_screen.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  const HomeScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> screens = [
    PhotosScreen(),
    FavoritesScreen(),
  ];

  @override
  void initState() {
    _currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
