import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projek/project/halaman/halaman_utama.dart';
import 'package:projek/project/model/hive_model.dart';
import 'package:hive/hive.dart';

void main() {
  initiateLocalDB();
  runApp(const MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MyFavoriteAdapter());
  Hive.registerAdapter(UserAccountModelAdapter());
  Hive.registerAdapter(MyRecipeModelAdapter());
  await Hive.openBox("favorit");
  await Hive.openBox("akun");
  await Hive.openBox("resep");
}

class MyApp extends StatelessWidget {
  final String username;
  const MyApp({Key? key, this.username="Tamu"}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RESEP MAKANAN',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HalamanUtama(username: username, index: 0),
    );
  }
}



