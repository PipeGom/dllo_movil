import 'package:flutter/material.dart';
import 'package:actividad_2/views/widgets/generatorPaswordsWidget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Generador de Contraseñas"),
        ),
        drawer: const Drawer(
          child: Icon(Icons.menu),
        ),
        body: GeneratorPasswords(),
      ),
    );
  }
}
