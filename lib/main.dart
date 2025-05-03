
import 'package:tugas_kelompok2_mobile/pages/pages.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        //primaryColor: primaryColor,
        canvasColor: Colors.transparent,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => WellcomePage(),
        '/home': (context) => HomePage(),
        '/ganjil_genap': (context) => PenentuanBilangan(),
      },
    );
  }
}
