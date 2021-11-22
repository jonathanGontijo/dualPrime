import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/admin_users_manager.dart';
import 'package:dual/models/casualty.dart';
import 'package:dual/models/casualty_manager.dart';
import 'package:dual/models/order_manager.dart';
import 'package:dual/screens/adress/adress_screen.dart';
import 'package:dual/screens/base/base_screen.dart';
import 'package:dual/screens/bonus/bonus_screen.dart';
import 'package:dual/screens/casualty/casualty_screen.dart';
import 'package:dual/screens/edit_casualty/edit_casualty_screen.dart';
import 'package:dual/screens/information/information_screen.dart';
import 'package:dual/screens/login/login_screen.dart';
import 'package:dual/screens/order/order_screen.dart';
import 'package:dual/screens/signup/signup_screen.dart';
import 'package:dual/services/cepaberto_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/home_manager.dart';
import 'models/user_manager.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());

  //CepAbertoService().getAddressFromCep('32.185-020').then((address) => print(address));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CasualtyManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, OrderManager>(
          create: (_) => OrderManager(),
          lazy: false,
          update: (_, UserManager, OrderManager)=>
              OrderManager!..updateUser(UserManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
            create: (_) => AdminUsersManager(),
            lazy: false,
          update: (_, UserManager, AdminUserManager) =>
              AdminUserManager!..updateUser(UserManager),
        )
      ],
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
            case '/casualty':
              return MaterialPageRoute(
                  builder: (_) => CasualtyScreen(
                    settings.arguments as Casualty
                  )
              );
            case '/order':
              return MaterialPageRoute(
                  builder: (_) => OrderScreen()
              );
            case '/adress':
              return MaterialPageRoute(
                  builder: (_) => AdressScreen()
              );
            case '/information':
              return MaterialPageRoute(
                  builder: (_) => InformationScreen()
              );
            case '/bonus':
              return MaterialPageRoute(
                  builder: (_) => BonusScreen()
              );
            case '/edit_casualty':
              return MaterialPageRoute(
                  builder: (_) => EditCasualtyScreen(
                    settings.arguments as Casualty
                  )
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

