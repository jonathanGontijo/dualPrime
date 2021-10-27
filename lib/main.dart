import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/screens/base/base_screen.dart';
import 'package:dual/screens/login/login_screen.dart';
import 'package:dual/screens/signup/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user_manager.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());

 /* FirebaseFirestore db = FirebaseFirestore.instance;

  db.collection("usuarios").doc("003").set({"nome": "Jamilton", "idade": "30"});*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      lazy: false,
      child: MaterialApp(
        title: 'Prime Automotive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.grey,
          appBarTheme: AppBarTheme(
            elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            /*case '/base':
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
          );*/
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );
              default:
                return MaterialPageRoute(
                    builder: (_) => BaseScreen()
                );
          }
        },
      ),
    );
  }
}

