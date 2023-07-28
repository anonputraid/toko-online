import 'package:flutter/material.dart';
import 'package:grap_boba/Model/databaseHelper.dart';

class checkConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: databaseHelper.checkDatabase(),
          builder: (context, conn) {
            if (conn.connectionState == ConnectionState.done) {
              if (conn.data == true) {
                return Center(child: Text("Database Berhasil Dibuat!!"));
              } else {
                return Center(child: Text("Database Tidak Berhasil Dibuat!"));
              }
            } else {
              return Text("...");
            }
          }),
    );
  }
}

class checkSchemaTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table ${databaseHelper.tableName} Schema"),
      ),
      body: FutureBuilder(
          future: databaseHelper.getTableSchema(),
          builder: (context, conn) {
            if (conn.connectionState == ConnectionState.done) {
             if(conn.hasData){
              List<Map<String, dynamic>> columns = conn.data as List<Map<String, dynamic>>;
               List<Widget> columnWidgets = [];

              for (var column in columns) {
                // Ambil informasi kolom yang diperlukan
                String columnName = column['name'] ?? '';
                String columnType = column['type'] ?? '';

                // Buat widget untuk menampilkan informasi kolom
                Widget columnWidget = ListTile(
                  title: Text('Nama Kolom: $columnName'),
                  subtitle: Text('Tipe Kolom: $columnType'),
                );

                columnWidgets.add(columnWidget);
              }

              // Tampilkan hasil perulangan
              return ListView(
                    children: columnWidgets,
                );
             } else {
               return Center(
                child: CircularProgressIndicator(),
               );
             }
            } else {
              return Text("...");
            }
          }),
    );
  }
}

class checkDataTables extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Data Table"),
      ),
      body: FutureBuilder(
        future: databaseHelper.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> getData = snapshot.data as List<Map<String, dynamic>>;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('id')),
                    DataColumn(label: Text('imgAssets')),
                    DataColumn(label: Text('Nama Produk')),
                    DataColumn(label: Text('Harga')),
                    DataColumn(label: Text('size')),
                    DataColumn(label: Text('count')),
                  ],
                  rows: getData.map((data) {
                    return DataRow(cells: [
                      DataCell(Text(data['id'].toString())),
                      DataCell(Text(data['imgAssets'])),
                      DataCell(Text(data['name_products'])),
                      DataCell(Text(data['price'])),
                      DataCell(Text(data['size'])),
                      DataCell(Text(data['count'])),
                    ]);
                  }).toList(),
                ),
              );
            } else {
              return Center(
                child: Text("Data tidak ditemukan."),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


class deleteData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: databaseHelper.resetTableData("${databaseHelper.tableName}"),
          builder: (context, conn) {
            if (conn.connectionState == ConnectionState.done) {
              if (conn.data == true) {
                return Center(child: Text("Table Berhasil Direset!!"));
              } else {
                return Center(child: Text("Table Tidak Berhasil Direset!"));
              }
            } else {
              return Text("...");
            }
          }),
    );
  }
}