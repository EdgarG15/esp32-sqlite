import 'package:esp32app/database/contacts.dart';
import 'package:esp32app/displays/sqlite.dart';
import 'package:esp32app/displays/webServices.dart';
import 'package:flutter/material.dart';

import 'displays/exampleBluetooth.dart';

class Run extends StatefulWidget {
  const Run({Key? key}) : super(key: key);

  @override
  State<Run> createState() => _RunState();
}

class _RunState extends State<Run> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text("Resultado de Aprendizaje"),
          SizedBox(
            width: 20,
          ),
        ]),
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: ElevatedButton(
              onPressed: () async {
                final dato = showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WebServices()));
                              },
                              child: const Text("Continuar"))
                        ],
                        title: const Text("Cuidado"),
                        content: const Text(
                            "Si no tienes el código cargado al esp32 y/o conectado, no funcionara"),
                      );
                    }));
              },
              child: const Text("WebServices", style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SqliteDart()));
              },
              child: const Text("Sqlite", style: TextStyle(fontSize: 23)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BluetoothApp()));
              },
              child: const Text(
                "Bluetooth",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    ));
  }
}
