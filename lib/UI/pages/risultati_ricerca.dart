import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../model/objects/book.dart';
import '../widgets/book_card.dart';

class RisultatiRicerca extends StatefulWidget {
  final String title;
  final String author;
  final String publisher;
  final String category;
  final String orderBy;

  const RisultatiRicerca(
      this.title,
      this.author,
      this.publisher,
      this.category,
      this.orderBy, {
        Key? key,
      }) : super(key: key);

  @override
  _RisultatiRicercaState createState() => _RisultatiRicercaState();
}

class _RisultatiRicercaState extends State<RisultatiRicerca> {
  List<Book> books = [];
  int currentPage = 0;
  int itemsPerPage = 10;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final retrievedBooks = await Model.sharedInstance.advancedSearch(
        title: widget.title,
        author: widget.author,
        publisher: widget.publisher,
        category: widget.category,
        sortBy: widget.orderBy,
        pageNumber: currentPage,
      );
      setState(() {
        books = retrievedBooks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void previousPage() async {
    if (currentPage > 0) {
      final List<Book> retrievedBooks = await Model.sharedInstance.advancedSearch(
        title: widget.title,
        author: widget.author,
        publisher: widget.publisher,
        category: widget.category,
        sortBy: widget.orderBy,
        pageNumber: currentPage - 1,
      );
      setState(() {
        currentPage -= 1;
        books = retrievedBooks;
      });
    }
  }

  void nextPage() async {
    final List<Book> retrievedBooks = await Model.sharedInstance.advancedSearch(
      title: widget.title,
      author: widget.author,
      publisher: widget.publisher,
      category: widget.category,
      sortBy: widget.orderBy,
      pageNumber: currentPage + 1,
    );
    if (retrievedBooks.isNotEmpty) {
      setState(() {
        currentPage += 1;
        books = retrievedBooks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          'Risultati Ricerca',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final item = books[index];
                  return BookCard(book: item);
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
              Text('Pagina: ${currentPage + 1}'),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: nextPage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

