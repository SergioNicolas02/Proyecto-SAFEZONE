import 'package:flutter/material.dart';

void main() {
  runApp(const SafeZoneApp());
}

class SafeZoneApp extends StatelessWidget {
  const SafeZoneApp({super.key});

  // 🎨 Cambia este color por el color principal del logo si quieres
  static const Color primaryColor = Color(0xFF9C27B0); // Violeta como ejemplo

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeZone',
      theme: ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      home: const StepByStepGuide(),
    );
  }
}

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
            // 👇 Imagen del logo SafeZone
            Image.asset(
              'assets/imagenes/sadezone_logo.jfif',
              height: 120,
            ),
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
                    color: SafeZoneApp.primaryColor.withOpacity(0.3),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        steps[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.grey.shade900,
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
              style: ElevatedButton.styleFrom(
                backgroundColor: SafeZoneApp.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
