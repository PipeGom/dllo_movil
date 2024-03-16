import 'dart:math';

import 'package:flutter/material.dart';

class GeneratorPasswordController {
  // Mapa para guardar los valores
  Map<String?, dynamic> values = {};

  TextEditingController? textFieldController;

  String caracteresMayusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String caracteresMinusculas = 'abcdefghijklmnopqrstuvwxyz';
  String caracteresNumeros = '0123456789';
  String caracteresSimbolos = '!@#\$%^&*()_+-=[]{}|;:,.<>?';
  String contrasena = "";

  GeneratorPasswordController(this.values, this.textFieldController) {
    values = {
      'easyToSay': false,
      'easyToRead': false,
      'allCharacters': false,
      'upperCaseLetter': false,
      'lowerCase': false,
      'numbers': false,
      'symbols': false,
      'slider': 0.0
    };
  }

  void generarContrasena(values) {
    textFieldController!.text =
        ''; // limpiar el campo de texto cada vez que se cambia una condicon
    contrasena = ''; // limpiar la contrasena cada vez que se cambia algo

    String caracteresDisponibles = '';
    print(values);

    if (values["upperCaseLetter"]) {
      caracteresDisponibles += caracteresMayusculas;
    }

    if (values["lowerCase"]) {
      caracteresDisponibles += caracteresMinusculas;
    }
    if (values["numbers"]) {
      caracteresDisponibles += caracteresNumeros;
    }
    if (values["symbols"]) {
      caracteresDisponibles += caracteresSimbolos;
    }

    Random random = Random();
    if (values["upperCaseLetter"] ||
        values["lowerCase"] ||
        values["numbers"] ||
        values["symbols"] ||
        values["easyToSay"] ||
        values["easyToRead"] ||
        values["allCharacters"]) {
      for (int i = 0; i < values['slider'].toInt(); i++) {
        if (caracteresDisponibles.length > 0) {
          int indexRandom = random.nextInt(caracteresDisponibles.length);
          contrasena = contrasena + caracteresDisponibles[indexRandom];
        }
      }
    }

    textFieldController!.text = contrasena;
  }

  void copiarContrasena(context) {
    // ignore: unused_local_variable
    final snackBar = SnackBar(
      content: const Text('Copiado en portapapeles!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void snackbar_camposvacios(context) {
    // ignore: unused_local_variable
    final snackBar = SnackBar(
      content: const Text('Debes seleccionar al menos un caracter'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
