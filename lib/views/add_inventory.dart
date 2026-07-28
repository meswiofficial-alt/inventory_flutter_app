import 'package:flutter/material.dart';
import 'package:dashboard_app/views/login.dart';
import 'package:dashboard_app/views/dashboard.dart';
import 'package:http/http.dart' as http;

class Inventory extends StatefulWidget {
  final Function(Map<String, dynamic> newItem)? onItemAdded;
  const Inventory({super.key, this.onItemAdded});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  String _msg = "message from api";

  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Dropdown options
  final List<String> _categories = [
    'Electronics',
    'Office Supplies',
    'Hardware',
    'Apparel',
  ];
  String? _selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create the item data map
      final newItem = {
        'name': _nameController.text.trim(),
        'sku': _skuController.text.trim(),
        'category': _selectedCategory ?? 'Uncategorized',
        'quantity': int.parse(_quantityController.text.trim()),
        'price': double.parse(_priceController.text.trim()),
      };

      // Pass the item to callback if provided
      if (widget.onItemAdded != null) {
        widget.onItemAdded!(newItem);
      }

      // Pop the screen back to previous list with the item data
      Navigator.of(context).pop(newItem);
    }
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Item Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. SKU / Barcode Field
              TextFormField(
                controller: _skuController,
                decoration: const InputDecoration(
                  labelText: 'SKU / Barcode',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.qr_code),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter SKU or barcode';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 3. Category Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                hint: const Text('Select Category'),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 16),

              // 4. Quantity & Price Side-by-Side
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      validator: (value) {
                        if (value == null ||
                            int.tryParse(value.trim()) == null) {
                          return 'Enter valid quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Unit Price',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.money),
                      ),
                      validator: (value) {
                        if (value == null ||
                            double.tryParse(value.trim()) == null) {
                          return 'Enter valid price';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 5. Submit Button
              ElevatedButton.icon(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.check),
                label: const Text(
                  'Save to Inventory',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () {
                  getMsgAPI();
                },
                icon: const Icon(Icons.check),
                label: const Text(
                  'check api connection',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                _msg,
                style: TextStyle(fontSize: 50, color: Colors.greenAccent),
              ),

              // Recent activity  with  mock data
              const Text(
                'recent added',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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

  void getMsgAPI() async {
    String url = "http://localhost/app1/test.php";
    final Map<String, dynamic> queryParams = {
      "name": "melodious",
      "address": "kenya",
    };
    try {
      http.Response response = await http
          .get(Uri.parse(url).replace(queryParameters: queryParams))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        setState(() {
          _msg = response.body;
        });
      } else {
        setState(() {
          _msg = "Error ${response.statusCode}: ${response.reasonPhrase}";
        });
      }
    } on http.ClientException catch (e) {
      setState(() {
        _msg = "Connection failed: ${e.message}\n";
      });
    } on FormatException catch (e) {
      setState(() {
        _msg = "Invalid URL format: ${e.message}";
      });
    } catch (e) {
      setState(() {
        _msg = "Unexpected error: $e";
      });
    }
  }
}
