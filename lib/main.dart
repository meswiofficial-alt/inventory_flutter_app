import 'package:flutter/material.dart';
import 'package:dashboard_app/views/login.dart';
import 'package:dashboard_app/views/dashboard.dart';

import 'package:dashboard_app/views/add_inventory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 208, 21, 21),
      initialRoute: '/',
      routes: {
        '/Dashboard': (context) => const DashboardPage(),

        '/addInventory': (context) => const Inventory(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Simple Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}
