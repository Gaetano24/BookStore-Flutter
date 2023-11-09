import 'package:bookstore/UI/pages/registrazione.dart';
import 'package:bookstore/UI/pages/ricerca_avanzata.dart';
import 'package:flutter/material.dart';
import '../../model/supports/constants.dart';
import 'home.dart';
import 'login.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold (
            appBar: AppBar(
              backgroundColor: Colors.grey.shade200,
              title: const Text(
                Constants.appName,
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
              centerTitle: true,
              bottom: const TabBar(
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                tabs: [
                  Tab(text: 'Home', icon: Icon(Icons.menu_book_outlined)),
                  Tab(text: 'Ricerca avanzata', icon: Icon(Icons.manage_search_outlined)),
                  Tab(text: 'Login', icon: Icon(Icons.person_rounded)),
                  Tab(text: "Registrati", icon: Icon(Icons.login_outlined)),
                  Tab(text: 'Carrello', icon: Icon(Icons.shopping_cart)),
                ],
              ),
            ),
            body: TabBarView(
                children: [
                  const Home(),
                  const RicercaAvanzata(),
                  const Login(),
                  Registrazione(),
                  //Carrello()
                ]
            )
        )
    );
  }
}