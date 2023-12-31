import 'package:flutter/material.dart';
import 'package:grap_boba/Model/dbrupat.dart';
import 'package:grap_boba/Model/databaseHelper.dart';
import 'package:grap_boba/Component/navigatorBottom.dart';
import 'package:grap_boba/ScreenPages/download.dart';
import 'package:grap_boba/Unit Test/database.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

void main() {
  runApp(const Setup());
}

class Setup extends StatelessWidget {
  const Setup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Membuat Aplikasi Flutter Untuk Pemula',
      theme: ThemeData(
        fontFamily: "Boogaloo",
      ),
      home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(kIsWeb){
              // Code Dibawah Ini Hanya Dieksekusi Ketika diperangkat Windows
              return downloadPages();
            } else {
              if (Platform.isAndroid || Platform.isIOS) {
                // Kode di bawah ini hanya akan dieksekusi di perangkat Android (bukan di web atau platform lainnya)
                if (constraints.maxWidth <= 600) {
                  return BottomNavBarDemo();
                } else {
                  return downloadPages();
                }
              } else {
                // Kode di bawah ini akan dieksekusi jika aplikasi berjalan di web atau platform Windows atau platform lainnya
                return downloadPages();
              }
            }
      }),
    );
  }
}
