import 'package:flutter/material.dart';
import '../../model/model.dart';
import '../../model/objects/order.dart';

class OrdiniUtente extends StatefulWidget {
  const OrdiniUtente({super.key});

  @override
  _OrdiniUtenteState createState() => _OrdiniUtenteState();
}

class _OrdiniUtenteState extends State<OrdiniUtente> {
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    try {
      final retrievedOrders = await Model.sharedInstance.getUserOrders();
      setState(() {
        orders = retrievedOrders;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'I miei ordini',
          style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(child: Text('Nessun ordine trovato'))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(4.0),
            child: ListTile(
              title: Text('ID Ordine: ${order.id}'),
              subtitle: Text(
                  'Creato il: ${order.createTime.day}/${order.createTime.month}/${order.createTime.year}'),
              trailing: Text('Totale: ${order.total.toStringAsFixed(2)}€',
                style: const TextStyle(
                    fontSize: 14
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}