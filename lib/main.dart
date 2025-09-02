
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertsApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Alertas Sonoras'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> emergencySounds = [
    {'label': 'Alerta General', 'file': 'nothing beats a jet2 holiday song mamazota.mp3', 'icon': Icons.warning},
    {'label': 'Emergencia Médica', 'file': 'emergencia_medica.mp3', 'icon': Icons.medical_services},
    {'label': 'Incendio', 'file': 'incendio.mp3', 'icon': Icons.local_fire_department},
    {'label': 'Caída', 'file': 'El Negro Cirilo - Canti Rondas  Canciones Infantiles.mp3', 'icon': Icons.personal_injury},
  ];

  void _playSound(String fileName) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/$fileName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: const Text(
          'Alertas Sonoras',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Presiona un botón de emergencia:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), // espacio entre título y botones
            ...emergencySounds.map((sound) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(280, 70), // tamaño más grande
                      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // esquinas redondeadas
                      ),
                      shadowColor: Colors.black54,
                      elevation: 6,
                    ),
                    icon: Icon(sound['icon'], size: 34),
                    label: Text(sound['label']!),
                    onPressed: () => _playSound(sound['file']!),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
