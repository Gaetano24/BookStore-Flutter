import 'package:bookstore/UI/pages/ordini_utente.dart';
import 'package:flutter/material.dart';
import '../../model/model.dart';
import '../../model/objects/user.dart';
import '../../model/supports/constants.dart';
import '../../model/supports/login_result.dart';
import '../widgets/error_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLogged = false;
  User? user;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    if(isLogged) {
      fetchUser();
    }
  }

  Future<void> checkLoginStatus() async {
    try {
      bool loggedIn =  Model.sharedInstance.isLogged();
      setState(() {
        isLogged = loggedIn;
      });
    } catch (e) {
      throw('Error checking login status: $e');
    }
  }

  Future<void> handleLogin(void Function(LoginResult) resultCallback) async {
    try {
      final result = await Model.sharedInstance.login(
          emailController.text, passwordController.text);
      resultCallback(result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Si è verificato un errore. Riprova più tardi.'),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    if (!isLogged) {
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
              padding: const EdgeInsets.all(50.0),
              child: Container(
                width: 400,
                decoration: ShapeDecoration(
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    const Text(
                      Constants.appName,
                      style: TextStyle(
                        fontSize: 54.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const Text(
                      "Developed by: Gaetano Marchianò",
                      style: TextStyle(color: Colors.orange),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 45)),
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
                    const Padding(padding: EdgeInsets.only(top: 25)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      ),
                      onPressed: () {
                        handleLogin((LoginResult result) {
                          switch (result) {
                            case LoginResult.logged:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Login effettuato con successo'),
                                ),
                              );
                              fetchUser();
                              setState(() {
                                isLogged = true;
                              });
                              break;
                            case LoginResult.wrongCredentials:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Credenziali errate. Riprova.'),
                                ),
                              );
                              break;
                            case LoginResult.unknownError:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Si è verificato un errore. Riprova più tardi.'),
                                ),
                              );
                              break;
                          }
                        });
                      },
                      child: const Text(
                        "Accedi",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${user?.firstName} ${user?.lastName}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange
                  )
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_pin, size: 40, color: Colors.orange),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text('Email: ${user?.email}'),
                      Text('Indirizzo: ${user?.address}'),
                      Text('Telefono: ${user?.phone}'),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrdiniUtente(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Text('I miei ordini',
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              ElevatedButton(
                onPressed: () async {
                  bool loggedOut = await Model.sharedInstance.logOut();
                  if (loggedOut) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout effettuato con successo'),
                      ),
                    );
                    setState(() {
                      isLogged=false;
                    });
                  } else {
                    showErrorDialog(context, "Impossibile effettuare il logout. Riprova.");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Text(
                  'Esci',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
