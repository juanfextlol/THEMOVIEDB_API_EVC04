import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gercetur07/config/theme/app_theme.dart';
import 'package:gercetur07/pages/login/login_page.dart';
import 'package:gercetur07/pages/register/register_page.dart';
import 'package:gercetur07/pages/success/success_page.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await dotenv.load(fileName: ".env");

  runApp(
    ProviderScope(child:  MyApp())
  

    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Registro y Acceso',
      theme: AppTheme().getTheme(),


      home: LoginPage(), // Cambia el enrutamiento inicial a la página de inicio de sesión
      routes: {
        '/register': (context) => RegisterPage(),
        '/success': (context) => SuccessPage(),
      },
    );
  }
}
