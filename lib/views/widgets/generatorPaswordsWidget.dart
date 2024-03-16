import 'dart:async';

import 'package:actividad_2/controllers/generatorPasswordController.dart';
import 'package:flutter/material.dart';

class GeneratorPasswords extends StatefulWidget {
  // cuando uso el stateful widget debo tener  dos clases
  GeneratorPasswords({super.key});

  @override
  State<GeneratorPasswords> createState() => _GeneratorPasswordsState();
}

class _GeneratorPasswordsState extends State<GeneratorPasswords> {
  GeneratorPasswordController? _con;

  Map<String?, dynamic> values = {};
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    setState(() {
      _con = GeneratorPasswordController(values, _textFieldController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                  suffixIcon: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            _con!.generarContrasena(_con!.values);
                          },
                          icon: Icon(
                            Icons.autorenew_outlined,
                            color: Color.fromARGB(255, 165, 163, 163),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _con!.copiarContrasena(context);
                            });
                          },
                          icon: Icon(
                            Icons.content_copy_rounded,
                            color: Color.fromARGB(255, 165, 163, 163),
                          ),
                        ),
                      ],
                    ),
                  ),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)))),
            ),
          ),
          Card(child: _column1()),
          ElevatedButton(
            onPressed: () {
              _con!.copiarContrasena(context);
            },
            child: Text('Copiar contraseña'),
          )
        ],
      ),
    );
  }

  Widget _column1() {
    return Column(children: [
      Text('Personalice su contraseña'),
      Divider(
        indent: 40,
        endIndent: 40,
      ),
      SizedBox(
        height: 20,
      ),
      Text('Longitud de la contraseña: '),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Row(
          children: [
            SizedBox(
              width: 50,
            ),
            Text('${_con!.values["slider"].toInt()}'),
            Slider(
                value: _con!.values["slider"],
                min: 0,
                max: 50,
                onChanged: (newValue) {
                  setState(() {
                    _con!.values["slider"] = newValue;
                    _con!.generarContrasena(_con!.values);
                  });
                })
          ],
        ),
      ),
      RadioListTile(
        // cuando value coincide con group value se muestra como seleccionado
        ///Switchs o CheckBox deben ser booleanos
        toggleable: true,
        title: const Text("Fácil de decir"),
        value: true, // le asignamos al valor del mapa
        groupValue: _con!.values["easyToSay"],
        onChanged: (newValue) {
          // Va recibir el nuevo valor
          setState(() {
            _con!.values["easyToSay"] = newValue ?? false;
            // si facil de decir se selecciona numbers y symbols se deseleccionan
            // para inhabilitaros esta el enable
            if (_con!.values["easyToSay"]) {}
            _con!.values["numbers"] = false;
            _con!.values["symbols"] = false;
            _con!.values["allCharacters"] = false;
            _con!.values["easyToRead"] = false;
            _con!.generarContrasena(_con!.values);
          });
        },
      ),
      RadioListTile(
        toggleable: true,
        title: const Text("Fácil de leer"),
        value: true,
        groupValue: _con!.values["easyToRead"],
        onChanged: (newValue) {
          _con!.values["easyToRead"] = newValue ?? false;
          setState(() {
            _con!.generarContrasena(_con!.values);
          });
          if (_con!.values["easyToRead"]) {
            _con!.values["allCharacters"] = false;
            _con!.values["easyToSay"] = false;
          }
        },
      ),
      RadioListTile(
        toggleable: true,
        title: const Text("Todos los caracteres"),
        value:
            true, // el valor que se le va a mapear al radio button internamente
        groupValue: _con!.values[
            "allCharacters"], // Los radioListTile deben pertenecer a un grupo de valores
        onChanged: (newValue) {
          _con!.values["allCharacters"] =
              newValue ?? false; // cuando no esta seleccionado newValue es null
          if (_con!.values["allCharacters"]) {
            _con!.values["upperCaseLetter"] = true;
            _con!.values["lowerCase"] = true;
            _con!.values["numbers"] = true;
            _con!.values["symbols"] = true;
            _con!.values["easyToRead"] = false;
            _con!.values["easyToSay"] = false;
          }

          setState(() {
            _con!.generarContrasena(_con!.values);
          });
        },
      ),
      CheckboxListTile(
        title: const Text("Mayúsculas"),
        value: _con!.values["upperCaseLetter"],
        onChanged: (newValue) {
          _con!.generarContrasena(_con!.values);
          _con!.values["upperCaseLetter"] = newValue;
          setState(() {
            _con!.generarContrasena(_con!.values);
          });
        },
      ),
      CheckboxListTile(
        title: const Text("Minúsculas"),
        value: _con!.values["lowerCase"],
        onChanged: (newValue) {
          _con!.generarContrasena(_con!.values);
          _con!.values["lowerCase"] = newValue;
          setState(() {
            _con!.generarContrasena(_con!.values);
          });
        },
      ),
      CheckboxListTile(
        title: const Text("Números"),
        value: _con!.values["numbers"],
        enabled: _con!.values["easyToSay"] ? false : true,
        onChanged: (newValue) {
          _con!.values["numbers"] = newValue;
          setState(() {
            _con!.generarContrasena(_con!.values);
            _con!.values["numbers"] = newValue;
          });
        },
      ),
      CheckboxListTile(
        title: const Text("Símbolos"),
        value: _con!.values["symbols"],
        enabled: _con!.values["easyToSay"] ? false : true,
        onChanged: (newValue) {
          _con!.values["symbols"] = newValue;

          setState(() {
            _con!.generarContrasena(_con!.values);
          });
        },
      ), // imprimir el mapa en la llave
    ]);
  }
}
