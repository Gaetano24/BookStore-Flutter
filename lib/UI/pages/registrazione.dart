import 'package:bookstore/UI/widgets/error_dialog.dart';
import 'package:bookstore/model/objects/registration_request.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../model/supports/constants.dart';

class Registrazione extends StatelessWidget {
  Registrazione({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool checkTextFields() {
    return (firstNameController.text!="" && lastNameController.text!=""
        && emailController.text!="" && addressController.text!=""
        && phoneController.text!="" && passwordController.text!="");
  }

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
                    onPressed: () async {
                      if(checkTextFields()) {
                        RegistrationRequest r = RegistrationRequest(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            address: addressController.text,
                            phone: phoneController.text,
                            password: passwordController.text
                        );
                        try {
                          await Model.sharedInstance.register(r);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registrazione effettuata con successo. Effettua il login.'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      } else {
                        showErrorDialog(context, "Inserisci i dati mancanti");
                      }
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
