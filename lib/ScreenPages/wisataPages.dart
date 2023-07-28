import 'package:flutter/material.dart';
import 'package:grap_boba/ScreenPages/download.dart';

class WisataPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return Center(
            child: Text("Wisata Pages"),
          );
        } else {
          return downloadPages();
        }
      }),
    );
  }
}
