import 'book.dart';

class CartDetail {
  final int id;
  final Book book;
  final double price;
  int quantity;
  double subTotal;

  CartDetail({
    required this.id,
    required this.book,
    required this.price,
    required this.quantity,
    required this.subTotal,
  });

  factory CartDetail.fromJson(Map<String, dynamic> json) {
    return CartDetail(
      id: json['id'],
      book: Book.fromJson(json['book']),
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      subTotal: json['subTotal'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book': book.toJson(),
      'price': price,
      'quantity': quantity,
      'subTotal': subTotal,
    };
  }

  @override
  String toString() {
    return 'CartDetail{id: $id, book: $book, price: $price, quantity: $quantity, subTotal: $subTotal}';
  }

}
