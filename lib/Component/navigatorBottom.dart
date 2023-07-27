import 'package:flutter/material.dart';
import 'package:grap_boba/ScreenPages/keranjang.dart';
import 'package:grap_boba/ScreenPages/kulinerPages.dart';
import 'package:grap_boba/ScreenPages/profile.dart';
import 'package:grap_boba/ScreenPages/wisataPages.dart';
import 'package:badges/badges.dart' as badges;
import 'package:grap_boba/Model/databaseHelper.dart';

class BottomNavBarDemo extends StatefulWidget {
  @override
  _BottomNavBarDemoState createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBarDemo> {
  int _currentIndex = 0;
  int _keranjangNotifikasi = 0; // Jumlah notifikasi, sesuaikan dengan data aktual Anda

  void initState() {
    super.initState();
    updateKeranjangNotifikasi();
  }

  Future<void> updateKeranjangNotifikasi() async {
    List<Map<String, dynamic>> data = await databaseHelper.getData();
    setState(() {
      _keranjangNotifikasi = data.length;
    });
  }


  final List<Widget> _pages = [KulinerPages(), Keranjang()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Kuliner',
          ),
      
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(Icons.shopping_bag_outlined),
                if (_keranjangNotifikasi > 0)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        _keranjangNotifikasi.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Keranjang',
          )
        ],
      ),
    );
  }
}