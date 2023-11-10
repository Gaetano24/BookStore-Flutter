import 'package:bookstore/model/model.dart';
import 'package:flutter/material.dart';
import '../../model/objects/book.dart';
import 'error_dialog.dart';


class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(book.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            Text('Autore: ${book.author}'),
            Text('Editore: ${book.publisher}'),
            Text('Categoria: ${book.category}'),
            Text('Isbn: ${book.isbn}'),
            const Spacer(),
            Text(
              "Prezzo: ${book.price}€",
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 8),
              child: ElevatedButton(
                onPressed: () async {
                  if(Model.sharedInstance.isLogged()) {
                    try {
                      await Model.sharedInstance.addToCart(book.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Articolo aggiunto al carrello"),
                        ),
                      );
                    } catch (e) {
                      showErrorDialog(context, e.toString());
                    }
                  } else {
                    showErrorDialog(context,
                        "Accedi o registrati per acquistare"
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Text('Aggiungi al carrello',
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