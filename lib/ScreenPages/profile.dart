import 'package:flutter/material.dart';
import 'package:grap_boba/ScreenPages/download.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return Center(
            child: Text("Profile"),
          );
        } else {
          return downloadPages();
        }
      }),
    );
  }
}
