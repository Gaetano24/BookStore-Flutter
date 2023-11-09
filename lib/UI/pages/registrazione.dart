import 'package:flutter/material.dart';

import '../../model/supports/constants.dart';

class Registrazione extends StatelessWidget {
  Registrazione({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 450,
              height: 650,
              decoration: ShapeDecoration(
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    Constants.appName,
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const Text(
                    "Developed by: Gaetano Marchianò",
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 25)),
                  SizedBox(
                    width: 325,
                    child: TextField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                        hintText: 'Nome',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  SizedBox(
                    width: 325,
                    child: TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cognome',
                        hintText: 'Cognome',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  SizedBox(
                    width: 325,
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Indirizzo',
                        hintText: 'Indirizzo',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  SizedBox(
                    width: 325,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefono',
                        hintText: 'Telefono',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  SizedBox(
                    width: 325,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  SizedBox(
                    width: 325,
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    onPressed: () {
                      // Implementare la logica di registrazione
                    },
                    child: const Text(
                      "Registrati",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
