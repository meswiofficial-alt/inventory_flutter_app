import 'package:flutter/material.dart';
import 'package:dashboard_app/views/login.dart';
import 'package:dashboard_app/views/dashboard.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text('Add Inventory'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navigate back to the dashboard
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            },
            child: const Text('Back to Dashboard'),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate back to login and clear stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Recently Added Inventory',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Text(
                'Inventory Management Content Goes Here',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Text(
                'Inventory Management Content Goes Here',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print('Add Inventory button pressed');
            },
          ),
        ],
      ),
    );
  }
}
