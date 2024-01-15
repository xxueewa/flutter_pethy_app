import 'package:flutter/material.dart';
import 'package:flutter_myapp/routes/pages/medical_page.dart';
import 'package:flutter_myapp/routes/pages/pets_page.dart';
import 'package:flutter_myapp/routes/pages/wiki_page.dart';

import 'Authentication/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      // _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
            },
          ),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              Container(
                child: WikiPage(),
              ),
              Container(
                child: MedicalPage(),
              ),
              Container(
                child: PetsPage(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: 'Wiki',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information),
              label: 'Medical',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Pets',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}