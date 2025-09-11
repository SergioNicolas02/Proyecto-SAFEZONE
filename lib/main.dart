
import 'package:flutter/material.dart';

void main() {
  runApp(const NovaNightApp());
}

class NovaNightApp extends StatelessWidget {
  const NovaNightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaNight Store',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurpleAccent,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _cart = [];

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      _cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product["name"]} agregado al carrito")),
    );
  }

  void _removeFromCart(int index) {
    setState(() {
      _cart.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(onAddToCart: _addToCart),
      CartScreen(cart: _cart, onRemove: _removeFromCart),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("NovaNight"),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Productos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Carrito",
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  const HomeScreen({super.key, required this.onAddToCart});

  final List<Map<String, dynamic>> products = const [
    {"name": "Auriculares Gamer", "price": 150000, "image": "🎧"},
    {"name": "Teclado Mecánico", "price": 250000, "image": "⌨️"},
    {"name": "Mouse RGB", "price": 80000, "image": "🖱️"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.deepPurple.shade700,
          child: ListTile(
            leading: Text(product["image"], style: const TextStyle(fontSize: 32)),
            title: Text(product["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("\$${product["price"]}"),
            trailing: ElevatedButton(
              onPressed: () => onAddToCart(product),
              child: const Text("Agregar"),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                    product: product,
                    onAddToCart: onAddToCart,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAddToCart;

  const ProductDetailScreen({super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["name"])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(product["image"], style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 20),
            Text(product["name"], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("\$${product["price"]}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => onAddToCart(product),
              child: const Text("Agregar al Carrito"),
            )
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final Function(int) onRemove;

  const CartScreen({super.key, required this.cart, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return const Center(
        child: Text(
          "Tu carrito está vacío 🛒",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    final total = cart.fold(0, (sum, item) => sum + (item["price"] as int));

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final item = cart[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.deepPurple.shade600,
                child: ListTile(
                  leading: Text(item["image"], style: const TextStyle(fontSize: 28)),
                  title: Text(item["name"]),
                  subtitle: Text("\$${item["price"]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => onRemove(index),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.deepPurple.shade800),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total: \$${total}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Compra realizada con éxito ✅")),
                  );
                },
                child: const Text("Comprar"),
              )
            ],
          ),
        )
      ],
    );
  }
}
