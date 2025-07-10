import 'package:flutter/material.dart';
import 'package:ekart/features/cart/presentation/page/cart_page.dart';
import 'package:ekart/features/home/presentation/pages/home_page.dart';
import 'package:ekart/features/order/presentation/pages/order_page.dart';
import 'package:ekart/features/profile/presentation/page/profile_page.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, required this.initialIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    HomePage(),
    CartPage(),
    OrderPage(),
    ProfilePage()
  ];
  int _selectedIndex = 0;
  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFb0e0e6),
              Color(0xFF4682b4),
            ])),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          onTap: onItemTapped,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade400,

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Order'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ]),
      ),
    );
  }
}
