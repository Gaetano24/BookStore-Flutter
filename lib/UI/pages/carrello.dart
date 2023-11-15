import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../model/objects/cart_detail.dart';
import '../../model/objects/user.dart';
import '../widgets/error_dialog.dart';

class Carrello extends StatefulWidget {
  const Carrello({super.key});

  @override
  _CarrelloState createState() => _CarrelloState();
}

class _CarrelloState extends State<Carrello> {
  bool isLogged = true;
  User? user;
  List<CartDetail> cartDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    if (isLogged) {
      fetchUser();
      fetchCartDetails();
    }
  }

  Future<void> checkLoginStatus() async {
    try {
      bool loggedIn = Model.sharedInstance.isLogged();
      setState(() {
        isLogged = loggedIn;
      });
    } catch (e) {
      throw ('Error checking login status: $e');
    }
  }

  Future<void> fetchUser() async {
    try {
      final retrievedUser = await Model.sharedInstance.fetchUserProfile();
      setState(() {
        user = retrievedUser;
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> fetchCartDetails() async {
    try {
      final retrievedCartDetails = await Model.sharedInstance.getCartDetails();
      setState(() {
        cartDetails = retrievedCartDetails;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var item in cartDetails) {
      total += item.subTotal;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nome: ${user?.firstName} ${user?.lastName}",
                  style: const TextStyle(fontSize: 14)),
              Text("Indirizzo di spedizione: ${user?.address}",
                  style: const TextStyle(fontSize: 14)),
              Text("Telefono: ${user?.phone}",
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
          leading: const Icon(
            Icons.shopping_cart,
            size: 40,
          ),
          backgroundColor: Colors.orangeAccent,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : cartDetails.isEmpty
            ? const Center(child: Text('Nessun articolo nel carrello'))
            : ListView.builder(
          itemCount: cartDetails.length,
          itemBuilder: (context, index) {
            final item = cartDetails[index];
            return Card(
              color: Colors.white,
              borderOnForeground: true,
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: IconButton(
                  tooltip: "Rimuovi",
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    try {
                      await Model.sharedInstance.removeItem(item.id);
                      setState(() {
                        cartDetails.remove(item);
                      });
                    } catch (e) {
                      showErrorDialog(context, e.toString());
                    }
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.book.title),
                        Text("Prezzo: ${item.price}€",
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () async {
                                if (item.quantity == 1) {
                                  try {
                                    await Model.sharedInstance
                                        .removeItem(item.id);
                                    setState(() {
                                      cartDetails.remove(item);
                                    });
                                  } catch (e) {
                                    showErrorDialog(context, e.toString());
                                  }
                                } else {
                                  int quantity = item.quantity - 1;
                                  try {
                                    await Model.sharedInstance
                                        .updateItemQuantity(
                                        item.id, quantity);
                                    setState(() {
                                      item.quantity -= 1;
                                      item.subTotal =
                                          item.quantity * item.book.price;
                                    });
                                  } catch (e) {
                                    showErrorDialog(context, e.toString());
                                  }
                                }
                              },
                            ),
                            Container(
                                color: Colors.white,
                                child: Text("${item.quantity}")),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () async {
                                int quantity = item.quantity + 1;
                                try {
                                  await Model.sharedInstance
                                      .updateItemQuantity(
                                      item.id, quantity);
                                  setState(() {
                                    item.quantity += 1;
                                    item.subTotal =
                                        item.quantity * item.book.price;
                                  });
                                } catch (e) {
                                  showErrorDialog(
                                      context, e.toString());
                                }
                              },
                            ),
                          ],
                        ),
                        Text("Totale articolo: ${item.subTotal.toStringAsFixed(2)}€")
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: () async {
                  if (cartDetails.isNotEmpty) {
                    try {
                      await Model.sharedInstance.clearCart();
                      setState(() {
                        cartDetails = [];
                      });
                    } catch (e) {
                      showErrorDialog(context, e.toString());
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nessun articolo nel carrello.'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Svuota Carrello',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Text(
                'Importo totale: ${calculateTotalPrice().toStringAsFixed(2)}€',
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: () async {
                  if (cartDetails.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nessun articolo nel carrello.'),
                      ),
                    );
                  } else {
                    try {
                      await Model.sharedInstance.checkout();
                      setState(() {
                        cartDetails = [];
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Il tuo ordine è stato accettato'),
                        ),
                      );
                    } catch (e) {
                      showErrorDialog(context, e.toString());
                    }
                  }
                },
                child: const Text(
                  'Completa Acquisto',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
            child: Text("Effettua il login per accedere al carrello",
              style: TextStyle(
                fontSize: 20
              )
            )),
      );
    }
  }
}
