import 'package:flutter/material.dart';
import 'package:grap_boba/Model/databaseHelper.dart';
import 'package:grap_boba/ScreenPages/download.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:grap_boba/ScreenPages/kulinerPages.dart';
import 'package:grap_boba/Component/navigatorBottom.dart';

class checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LayoutBuilder(builder: ((context, constraints) {
          if (constraints.maxWidth <= 600) {
            return _checkout();
          } else {
            return downloadPages();
          }
        })),
      ),
    );
  }
}

class _checkout extends StatefulWidget {
  State<_checkout> createState() => _checkoutcontent();
}

class _checkoutcontent extends State<_checkout> {
  TextEditingController _nameuser = TextEditingController();
  TextEditingController _alamatuser = TextEditingController();
  String alamatPembeli = "";

  static Future<int> totalBelanja() async {
    List<Map<String, dynamic>> getData = await databaseHelper.getData();

    return getData.length;
  }

  static Future<String> totalBayar() async {
    NumberFormat rupiahFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    List<Map<String, dynamic>> getData = await databaseHelper.getData();

    int totalbayar = 0;

    for (var data in getData) {
      int price = int.parse(data["price"]);
      totalbayar += price;
    }

    return rupiahFormat.format(totalbayar);
  }

  void _openWhatsAppWithMessage(String phoneNumber, String message) async {
    String url =
        "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext Context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Checkout Pesanan Anda",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _nameuser,
                decoration: InputDecoration(
                  hintText: 'Nama Anda',
                  border: OutlineInputBorder(), // Membuat garis tepi pada input
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16), // Jarak antara teks dan tepi input
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _alamatuser,
                decoration: InputDecoration(
                  hintText: 'Alamat Anda',
                  border: OutlineInputBorder(), // Membuat garis tepi pada input
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16), // Jarak antara teks dan tepi input
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "Total Belanja: ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  FutureBuilder<int>(
                      future: totalBelanja(),
                      builder: (context, conn) {
                        if (conn.connectionState == ConnectionState.done) {
                          if (conn.hasData) {
                            return Container(
                              child: Text("${conn.data}",
                                  style: TextStyle(fontSize: 15)),
                            );
                          } else {
                            return Container(
                              child: Text(
                                "Perhitungan Gagal",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            );
                          }
                        } else {
                          return Container(
                            child: Text("Menghitung ..."),
                          );
                        }
                      }),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "Total Bayar: ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  FutureBuilder<String>(
                      future: totalBayar(),
                      builder: (context, conn) {
                        if (conn.connectionState == ConnectionState.done) {
                          if (conn.hasData) {
                            return Container(
                              child: Text("${conn.data}",
                                  style: TextStyle(fontSize: 15)),
                            );
                          } else {
                            return Container(
                              child: Text(
                                "Perhitungan Gagal",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            );
                          }
                        } else {
                          return Container(
                            child: Text("Menghitung ..."),
                          );
                        }
                      }),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "Ongkir: ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Rp. 10.000",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 200,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_alamatuser.text != "" && _nameuser.text != "") {
                      String intro = "Assalamu'Alaikum Kak\nPerkenalkan:\n";

                      String perkenalan =
                          "Nama Saya ${_nameuser.text}\nAlamat Saya: ${_alamatuser.text}\n\nBerikut Ini Pesanan Saya: \n";

                      List<Map<String, dynamic>> DataKeranjang =
                          await databaseHelper.getData();

                      NumberFormat rupiahFormat =
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

                      String pesanan = "";
                      int totalbayar = 0;

                      for (var data in DataKeranjang) {
                        String name_product = data["name_products"];
                        String harga = data["price"];
                        String jumlah_beli = data["count"];
                        String size = data["size"];

                        NumberFormat rupiahFormat = NumberFormat.currency(
                            locale: 'id_ID', symbol: 'Rp');

                        pesanan += "Nama Products: ${name_product}\n" +
                            "Jumlah Beli: ${jumlah_beli}\n" +
                            "harga: ${rupiahFormat.format(int.parse(harga))}\n" +
                            "ukuran cap: ${size}\n\n";

                        totalbayar += int.parse(harga);
                      }

                      var totalkeseluruhanbayar = totalbayar + 10000;

                      String penutup =
                          "Total Keseluruhan: Rp ${rupiahFormat.format(totalbayar)}\nOngkir: 10.000\nTotal Bayar: Rp ${rupiahFormat.format(totalkeseluruhanbayar)}";

                      _openWhatsAppWithMessage("6282268071774",
                          "${intro}\n${perkenalan}\n${pesanan}\n${penutup}");

                      bool resetKeranjang = await databaseHelper
                          .resetTableData("${databaseHelper.tableName}");

                      if (resetKeranjang) {
                        print("Berhasil Di Reset Keranjang");
                      }

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BottomNavBarDemo()), // Ganti dengan halaman home Anda
                        (route) => false, // Menghapus seluruh history navigasi
                      );
                    } else {
                      ScaffoldMessenger.of(context)
                          .hideCurrentSnackBar(); // Hapus SnackBar sebelumnya jika ada
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nama dan Alamat wajib diisi.'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  },
                  child: Text("Kirim")),
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    _nameuser.dispose();
    _alamatuser.dispose();
    super.dispose();
  }
}
