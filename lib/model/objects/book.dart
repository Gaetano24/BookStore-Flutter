class Book {
  final int id;
  final String title;
  final String author;
  final String publisher;
  final String category;
  final String isbn;
  final double price;
  final int quantity;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.category,
    required this.isbn,
    required this.price,
    required this.quantity,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      publisher: json['publisher'],
      category: json['category'],
      isbn: json['isbn'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publisher': publisher,
      'category': category,
      'isbn': isbn,
      'price': price,
      'quantity': quantity,
    };
  }
}

