import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/order.dart';
import 'package:dual/models/user.dart';
import 'package:flutter/cupertino.dart';


class OrdersAdm extends ChangeNotifier{

  late Usuario usuario;

  List<Order> orders = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  void updateUser(Usuario usuario){
    this.usuario = usuario;
    orders.clear();

    _subscription?.cancel();
    if (usuario != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders(){
    _subscription = firestore.collection('orders').where('usuario', isEqualTo: usuario.id)
    .snapshots().listen((event) {
      orders.clear();
      for(final doc in event.docs){
        orders.add(Order.fromDocument(doc));
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription?.cancel();
  }

}