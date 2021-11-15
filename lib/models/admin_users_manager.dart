import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/user.dart';
import 'package:dual/models/user_manager.dart';
import 'package:flutter/cupertino.dart';

import 'user.dart';

class AdminUsersManager extends ChangeNotifier{

  List<Usuario> usuarios = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  void updateUser(UserManager userManager){
    _subscription?.cancel();
    if (userManager.adminEnable) {
      _listenToUsers();
    } else {
      usuarios.clear();
      notifyListeners();
    }
  }

  void _listenToUsers(){
    
    _subscription = firestore.collection('users').snapshots()
        .listen((snapshot){
      usuarios = snapshot.docs.map((d) => Usuario.fromDocument(d)).toList();
      usuarios.sort((a,b) =>
          a.name.toLowerCase().compareTo(b.name.toLowerCase()));


      notifyListeners();
    });
  }

  List<String> get names => usuarios.map((e) => e.name).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}