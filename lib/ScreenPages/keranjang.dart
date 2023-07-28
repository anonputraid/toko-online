import 'package:flutter/material.dart';
import 'package:grap_boba/Model/databaseHelper.dart';
import 'package:grap_boba/ScreenPages/download.dart';
import 'package:intl/intl.dart';
import 'package:grap_boba/ScreenPages/checkout.dart';

class Keranjang extends StatelessWidget {
  @override
  NumberFormat rupiahFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang"),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return FutureBuilder(
              future: databaseHelper.getData(),
              builder: (context, conn) {
                if (conn.connectionState == ConnectionState.done) {
                  if (conn.hasData) {
                    List<Map<String, dynamic>> getData =
                        conn.data as List<Map<String, dynamic>>;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Berikut Ini Pesanan Anda",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black.withOpacity(0.2)),
                            ),
                            height: 400,
                            padding: EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: getData.length, // Batas Looping
                                itemBuilder: (BuildContext context, int index) {
                                  Map<String, dynamic> item = getData[index];
                                  int harga = int.parse(item['price']);
                                  return Card(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child:
                                                Image.asset(item["imgAssets"])),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3),
                                              child: Text(
                                                "${item['name_products']}",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3),
                                              child: Text(
                                                  "Jumlah Beli: ${item['count']}"),
                                            ),
                                            Container(
                                              child: Text(
                                                  "Ukuran Cap: ${item['size']}"),
                                            ),
                                            Container(
                                              child: Text(
                                                  "${rupiahFormat.format(harga)}"),
                                            ),
                                          ],
                                        )),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              int batalBeli =
                                                  await databaseHelper
                                                      .deleteData(item["id"]);
                                              
                                              if(batalBeli != -1){
                                                 ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hapus SnackBar sebelumnya jika ada
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Products Dengan nama ${item['name_products']} Berhasil Dibatalkan'),
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text("Batal Beli"),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: () async {
                                List<Map<String, dynamic>> DataKeranjang =
                                    await databaseHelper.getData();
                                if (DataKeranjang.length != 0) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return checkout();
                                  }));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar(); // Hapus SnackBar sebelumnya jika ada
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Pesan Dulu BosQ'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "CheckOut",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text("Table Tidak Berhasil Direset!"));
                  }
                } else {
                  return Center(
                    child: Text("Loading..."),
                  );
                }
              });
        } else {
          return downloadPages();
        }
      }),
    );
  }
}
