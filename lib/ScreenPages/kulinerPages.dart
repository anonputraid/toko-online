import 'package:flutter/material.dart';
import 'package:grap_boba/Model/dbrupat.dart';
import 'package:grap_boba/ScreenPages/download.dart';
import 'package:intl/intl.dart';
import 'package:grap_boba/Model/databaseHelper.dart';

class KulinerPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return mainKulinerPages();
        } else {
          return downloadPages();
        }
      }),
    );
  }
}

class mainKulinerPages extends StatelessWidget {
  rupatMarketPlaces products = rupatMarketPlacesList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minuman Boba"),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            child: ClipOval(
                child: Image.asset(
              "assets/toko/bitlab/bitlab.png",
              width: 100,
              height: 100,
            )),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Menu Minuman Boba",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah Row
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.products.length, // Batas Looping
                itemBuilder: (BuildContext context, int index) {
                  Set<String> menuBoba = products.products[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return countProducts(menuBoba.toList());
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 5),
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 10,
                            )
                          ]),
                      child: Column(children: [
                        Expanded(
                            child: Image.asset("${menuBoba.elementAt(1)}",
                                fit: BoxFit.cover))
                      ]),
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}

class countProducts extends StatefulWidget {
  final List<String> menuBoba;

  countProducts(this.menuBoba);

  State<countProducts> createState() => _countProducts();
}

class _countProducts extends State<countProducts> {
  String? ukuran_cap;
  int jumlah_beli = 0;
  int math = 0;

  void tambahJumlah() {
    setState(() {
      jumlah_beli++;
    });
  }

  void kurangJumlah() {
    setState(() {
      if (jumlah_beli > 0) {
        jumlah_beli--;
      }
    });
  }

  String HitungHarga() {
    if (ukuran_cap == null) {
      ukuran_cap = "Normal";
    }

    if (ukuran_cap == "Normal") {
      math = 10000 * jumlah_beli;
    } else {
      math = 20000 * jumlah_beli;
    }

    setState(() {
      math = math;
    });

    NumberFormat rupiahFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return rupiahFormat.format(math);
  }

  @override
  Widget build(BuildContext Context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pembelian"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // Banner
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.8),
                    )
                  ]),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Image.asset("${widget.menuBoba[2]}"),
                ),
                // Name
                Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text(
                    "${widget.menuBoba[0]} Nya Beli Berapa ?",
                    style: TextStyle(fontSize: 20),
                  )),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Total: ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Rp. ${HitungHarga()}",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ]),
                ),

                // Pilih Paket
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: DropdownButton(
                    items: [
                      DropdownMenuItem(
                        value: 'Besar',
                        child: Text('Cap Ukuran Besar'),
                      ),
                      DropdownMenuItem(
                        value: 'Normal',
                        child: Text('Cap Ukuran Sedang'),
                      ),
                    ],
                    value: ukuran_cap ?? "Normal",
                    hint: const Text('Pilih Ukuran Cap'),
                    onChanged: (String? value) {
                      setState(() {
                        ukuran_cap = value;
                      });
                    },
                  ),
                ),
                // Jumlah Beli
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  padding: EdgeInsets.only(left: 80, right: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: kurangJumlah,
                        icon: Icon(Icons.remove),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black)),
                        child: Center(child: Text("${jumlah_beli}")),
                      )),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: tambahJumlah,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      String imgAssets = widget.menuBoba[1];
                      String name_products = widget.menuBoba[0];
                      String price = math.toString();
                      String size = ukuran_cap ?? "Normal";
                      String count = jumlah_beli.toString();

                      int priceAsInt = int.parse(price);

                      if (priceAsInt != 0) {
                        int result = await databaseHelper.insertData(
                          imgAssets,
                          name_products,
                          price,
                          size,
                          count,
                        );

                        if (result != -1) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ditambahkan Ke Keranjang'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Pesanan Gagal Ada Kendala!'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tidak Bisa Dimasukan Kekeranjang!'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }

                    },
                    child: Text(
                      "Masukan Kekeranjang",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Batal Pesanan",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
