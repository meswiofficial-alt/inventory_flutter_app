import 'package:flutter/material.dart';
import 'package:dashboard_app/views/add_inventory.dart';
import 'package:dashboard_app/views/login.dart';
import 'package:dashboard_app/views/client_reg.dart';

var screens = [DashboardPage(), Inventory(), Client()];
int position = 0;

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('inventoryManagement'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            const Text(
              'welcome to your inventory manager',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Here is a quick overview of your stats.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Responsive grid: 2 columns on wide, 1 on narrow
            LayoutBuilder(
              builder: (context, constraints) {
                // If width > 600, use 2 columns, else 1
                final isWide = constraints.maxWidth > 600;
                return GridView.count(
                  crossAxisCount: isWide ? 2 : 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  children: const [
                    _DashboardCard(
                      icon: Icons.people,
                      title: 'Users',
                      value: '0',
                      color: Colors.blue,
                    ),
                    _DashboardCard(
                      icon: Icons.inventory_2_rounded,
                      title: 'total inventory',
                      value: '40',
                      color: Colors.green,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Recent activity (dummy)
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                leading: Icon(Icons.notifications_active, color: Colors.blue),
                title: Text('New user registered'),
                subtitle: Text('2 minutes ago'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.green),
                title: Text('Order #1234 shipped'),
                subtitle: Text('15 minutes ago'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: position,
        onTap: (index) {
          // Navigate to the selected screen
          position = index;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => screens[index]),
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1),
            label: 'Add customer',
          ),
        ],
      ),
    );
  }
}

// ---------- REUSABLE DASHBOARD CARD ----------
class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 20),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
