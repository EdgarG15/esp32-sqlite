// ignore: file_names

import 'package:esp32app/database/addContact.dart';
import 'package:flutter/material.dart';

import '../database/contacts.dart';
import '../database/database.dart';

List<Contact> contacts = [];

class SqliteDart extends StatefulWidget {
  const SqliteDart({Key? key}) : super(key: key);

  @override
  State<SqliteDart> createState() => _SqliteDartState();
}

class _SqliteDartState extends State<SqliteDart> {
  @override
  void initState() {
    super.initState();
    _readContacts();
  }

  void _readContacts() async {
    List<Contact> temp = await SqliteDB.contacts();

    setState(() {
      contacts = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.person_add),
        //   onPressed: () async {
        //     await showModalBottomSheet(
        //         context: context, builder: (context) => AddContact());
        //   },
        // ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context, builder: (context) => AddContact());
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Center(
          child: contacts.isEmpty
              ? Column(children: [Image.asset("assets/images/listEmpty.png")])
              : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) => ListTile(
                    onLongPress: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (context) => Material(
                                  child: ListView(
                                padding: const EdgeInsets.all(50),
                                children: [
                                  const Text(
                                      "Funciona pero necesita salir y entrar de nuevo para ver los cambios"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        labelText: "Nuevo nombre",
                                        hintText: contacts[index].name),
                                  ),
                                  TextField(
                                    controller: lastnameController,
                                    decoration: InputDecoration(
                                        labelText: "Nuevo apellido",
                                        hintText: contacts[index].lastname),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                        labelText: "Nuevo teléfono",
                                        hintText: contacts[index].phoneNumber),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        nameText = nameController.text;
                                        lastnameText = lastnameController.text;
                                        phoneNumberText =
                                            phoneNumberController.text;
                                        if (nameText != "" &&
                                            lastnameText != "" &&
                                            phoneNumberText != "") {
                                          Contact temp = Contact(
                                              id: contacts[index].id,
                                              name: nameText,
                                              lastname: lastnameText,
                                              phoneNumber: phoneNumberText);
                                          SqliteDB.update(temp);
                                        }

                                        Navigator.pop(context);
                                        nameController.clear();
                                        lastnameController.clear();
                                        phoneNumberController.clear();
                                      },
                                      child: const Text("GUARDAR CAMBIOS"))
                                ],
                              )));
                    },
                    trailing: IconButton(
                        onPressed: () {
                          Contact temp = Contact(
                              id: contacts[index].id,
                              name: nameText,
                              lastname: lastnameText,
                              phoneNumber: phoneNumberText);
                          SqliteDB.delete(temp);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    leading:
                        const Icon(Icons.account_circle_outlined, size: 30),
                    title: Text(
                      '${contacts[index].name} ${contacts[index].lastname}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      contacts[index].phoneNumber!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    //subtitle: Text('+52 ${contacts[3]}'),
                  ),
                ),
        ),
      ),
    );
  }
}
