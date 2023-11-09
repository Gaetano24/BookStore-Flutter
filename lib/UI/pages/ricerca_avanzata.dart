import 'package:bookstore/UI/pages/risultati_ricerca.dart';
import 'package:flutter/material.dart';

class RicercaAvanzata extends StatefulWidget {
  const RicercaAvanzata({super.key});

  @override
  State<RicercaAvanzata> createState() => _RicercaAvanzataState();
}

class _RicercaAvanzataState extends State<RicercaAvanzata> {
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  String orderBy = 'Titolo A-Z';
  bool search = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 35),
              child: Text(
                "Inserisci uno o più filtri di ricerca!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Titolo',
                    hintText: 'Titolo',
                    border: const OutlineInputBorder(),
                    prefix: IconButton(
                      onPressed: () {
                        titleController.clear();
                      },
                      icon: const Icon(Icons.clear),
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: authorController,
                  decoration: InputDecoration(
                    labelText: 'Autore',
                    hintText: 'Autore',
                    border: const OutlineInputBorder(),
                    prefix: IconButton(
                      onPressed: () {
                        authorController.clear();
                      },
                      icon: const Icon(Icons.clear),
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: publisherController,
                  decoration: InputDecoration(
                    labelText: 'Editore',
                    hintText: 'Editore',
                    border: const OutlineInputBorder(),
                    prefix: IconButton(
                      onPressed: () {
                        publisherController.clear();
                      },
                      icon: const Icon(Icons.clear),
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: 'Categoria',
                    hintText: "Categoria",
                    border: const OutlineInputBorder(),
                    prefix: IconButton(
                      onPressed: () {
                        categoryController.clear();
                      },
                      icon: const Icon(Icons.clear),
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Ordina per:"),
            ),
            DropdownButton<String>(
              focusColor: Colors.white,
              value: orderBy,
              onChanged: (String? newValue) {
                setState(() {
                  orderBy = newValue!;
                });
              },
              items: <String>[
                'Titolo A-Z',
                'Titolo Z-A',
                'Prezzo crescente',
                'Prezzo decrescente',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RisultatiRicerca(
                      titleController.text,
                      authorController.text,
                      publisherController.text,
                      categoryController.text,
                      orderBy
                    )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Text(
                  "Cerca",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
