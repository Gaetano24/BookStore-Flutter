import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../model/objects/book.dart';
import '../widgets/book_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> books = [];
  int currentPage = 0;
  int itemsPerPage = 10;
  TextEditingController titleController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final retrievedBooks = await Model.sharedInstance.getBooks();
      setState(() {
        books = retrievedBooks;
        isLoading = false;
      });
    } catch(e) {
      isLoading = false;
    }
  }

  void previousPage() async {
    if (currentPage > 0) {
      final List<Book> retrievedBooks;
      if(titleController.text == '') {
        retrievedBooks = await Model.sharedInstance.getBooks(pageNumber: currentPage-1);
      } else {
        retrievedBooks = await Model.sharedInstance.getBooksByTitle(titleController.text, pageNumber: currentPage-1);
      }
      setState(() {
        currentPage-=1;
        books = retrievedBooks;
      });
    }
  }

  void nextPage() async {
    final List<Book> retrievedBooks;
    if(titleController.text == '') {
      retrievedBooks = await Model.sharedInstance.getBooks(pageNumber: currentPage+1);
    } else {
      retrievedBooks = await Model.sharedInstance.getBooksByTitle(titleController.text, pageNumber: currentPage+1);
    }
    if (retrievedBooks.isNotEmpty) {
      setState(() {
        currentPage+=1;
        books = retrievedBooks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: <Widget>[
          SizedBox(
            width: 500,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: titleController,
                  onSubmitted: (String searchTitle) async {
                    List<Book> searchResults = await Model.sharedInstance.getBooksByTitle(searchTitle);
                    setState(() {
                      books = searchResults;
                      currentPage = 0;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Titolo',
                    border: const OutlineInputBorder(),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        titleController.clear();
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search_rounded),
                      onPressed: () async {
                        String searchTitle = titleController.text;
                        List<Book> searchResults = await Model.sharedInstance.getBooksByTitle(searchTitle);
                        setState(() {
                          books = searchResults;
                          currentPage = 0;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
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
              Text('Pagina: ${currentPage+1}'),
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
