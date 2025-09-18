import 'package:flutter/material.dart';

void main() {
  runApp(const SafeZoneApp());
}

class SafeZoneApp extends StatelessWidget {
  const SafeZoneApp({super.key});

  static const Color primaryColor = Color(0xFF109DFA); // Azul principal

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeZone',
      theme: ThemeData.light().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// 🏠 Pantalla principal
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SafeZone')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/imagenes/safezone_logo.jfif', height: 100),
            const SizedBox(height: 20),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                '🗺️ Muy pronto: aquí irá el mapa',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const StepByStepGuide()));
              },
              icon: const Icon(Icons.info_outline),
              label: const Text('Guía: ¿Qué hacer si me roban?'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              icon: const Icon(Icons.login),
              label: const Text('Iniciar sesión / Registrarme'),
            ),
          ],
        ),
      ),
    );
  }
}

// 📘 Guía paso a paso
class StepByStepGuide extends StatelessWidget {
  const StepByStepGuide({super.key});

  final List<String> steps = const [
    "1️⃣ Mantén la calma y aléjate del lugar si es peligroso.",
    "2️⃣ Llama al 123 (línea de emergencias).",
    "3️⃣ Anota detalles del hecho: lugar, hora, descripción del ladrón.",
    "4️⃣ Bloquea tu celular o tarjetas si fueron robadas.",
    "5️⃣ Dirígete a la estación de policía más cercana.",
    "6️⃣ Si es posible, reporta el robo en la web de la policía.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('¿Qué hacer si te roban?')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/imagenes/safezone_logo.jfif', height: 100),
            const SizedBox(height: 20),
            const Text(
              'Sigue estos pasos con calma:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: SafeZoneApp.primaryColor.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(steps[index], style: const TextStyle(fontSize: 18)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔐 Pantalla de login/registro simulada
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acceder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/imagenes/safezone_logo.jfif', height: 100),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoggedInScreen()));
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}

// 👤 Pantalla con sesión iniciada
class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/imagenes/safezone_logo.jfif', height: 100),
            const SizedBox(height: 20),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                '🗺️ Muy pronto: aquí irá el mapa',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.grey.shade100,
                    title: const Text('Reportar Robo'),
                    content: const Text('Muy pronto podrás reportar desde aquí.'),
                    actions: [
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.report),
              label: const Text("Reportar Robo"),
            ),
          ],
        ),
      ),
    );
  }
}
