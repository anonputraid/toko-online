import 'package:flutter/material.dart';

class downloadPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return mainPagesDownload();
        } else {
          return mainPagesDownload();
        }
      }),
    );
  }
}

class mainPagesDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blue[100],
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    child: ClipOval(
                      child: Image.asset("assets/toko/bitlab/bitlab.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Download Sekarang Aplikasi Boba!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hapus SnackBar sebelumnya jika ada
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Silmulasi Download Aplikasi Android Toko Boba Demo'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            },
                            child: Text(
                              "Download Android",
                            )),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hapus SnackBar sebelumnya jika ada
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Silmulasi Download Aplikasi IOS Toko Boba Demo'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            },
                            child: Text(
                              "Download IOS",
                            ),),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
