import 'package:flutter/material.dart';
// import 'package:dashboard_app/views/login.dart';
import 'package:dashboard_app/views/dashboard.dart';
import 'package:dashboard_app/views/client_reg.dart';
import 'package:dashboard_app/views/add_inventory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/Dashboard': (context) => const DashboardPage(),
        '/addClient': (context) => const Client(),
        '/addInventory': (context) => const Inventory(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Simple Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const DashboardPage(),
    );
  }
}
