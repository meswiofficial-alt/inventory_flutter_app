import 'package:flutter/material.dart';
import 'package:dashboard_app/views/add_inventory.dart';
import 'package:dashboard_app/views/login.dart';

var screens = [DashboardPage(), Inventory()];

int position = 0;

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(237, 3, 12, 28),
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
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Responsive grid: 2 columns on wide, 1 on narrow
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      _DashboardCard(
                        icon: Icons.home_filled,
                        title: 'warehouse',
                        value: '2',
                        color: Colors.green,
                      ),

                      SizedBox(height: 50),

                      _DashboardCard(
                        icon: Icons.inventory_2_rounded,
                        title: 'total inventory',
                        value: '400',
                        color: Colors.green,
                      ),
                      SizedBox(height: 20),

                      _DashboardCard(
                        icon: Icons.people,
                        title: 'clients',
                        value: '15',
                        color: Colors.blue,
                      ),
                      _DashboardCard(
                        icon: Icons.money_rounded,
                        title: 'total cash',
                        value: '400,000',
                        color: Colors.orange,
                      ),
                      // ElevatedButton.icon(
                      //   onPressed: () => Icons.add_ic_call,
                      //   style: ElevatedButton.styleFrom(
                      //     padding: const EdgeInsets.symmetric(vertical: 16),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //   ),
                      //   icon: const Icon(Icons.check),
                      //   label: const Text(
                      //     'api connection confirmation',
                      //     style: TextStyle(fontSize: 16),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent activity  with  mock data
            const Text(
              'recent activities',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                leading: Icon(Icons.notifications_active, color: Colors.blue),
                title: Text('needles added'),
                subtitle: Text('2 minutes ago'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.green),
                title: Text('guns added'),
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
        padding: const EdgeInsets.all(40.0),
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
