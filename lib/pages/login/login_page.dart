import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final Auth _auth = Auth();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/q.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 70.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'THE MOVIE ',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 211, 193, 193),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _signInWithGoogle(context);
                      },
                      icon: Image.asset(
                        'assets/images/google.png',
                        height: 22.0,
                      ),
                      label: Text(
                        'Iniciar Sesión con Google',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        side: BorderSide(
                          color: const Color.fromARGB(255, 10, 10, 10),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 70.0),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300.0,
                height: 300.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/55555.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signInWithGoogle(BuildContext context) async {
    setState(() {
      _animationController.forward().whenComplete(() {
        _animationController.reverse();
      });
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );

    final UserCredential? userCredential = await _auth.signInWithGoogle();

    Navigator.of(context).pop(); // Cerrar el diálogo de carga

    if (userCredential != null) {
      // Inicio de sesión con Google exitoso, redirigir a la página de acceso correcto
      Navigator.pushReplacementNamed(context, '/success');
    } else {
      // Manejar el error de inicio de sesión con Google
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo iniciar sesión con Google.'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
