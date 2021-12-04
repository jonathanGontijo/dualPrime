import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/car_size.dart';
import 'package:dual/models/casualty.dart';
import 'package:flutter/cupertino.dart';
import 'car_size.dart';

class OrderCasualty extends ChangeNotifier {



  OrderCasualty.fromCasualty(this.casualty){
    orderId = casualty!.id;
    quantity = 1;
    size = casualty!.selectedSize.name!;
  }

  OrderCasualty.fromDocument(DocumentSnapshot document){
    id = document.id;
    orderId = document.data()!['oid'] as String;
    quantity = document.data()!['quantity'] as int;
    size = document.data()!['size'] as String;
    
    firestore.doc('casualty/$orderId').get()
        .then((doc) {
        casualty = Casualty.fromDocument(doc);
        notifyListeners();
    }
    );
  }

  OrderCasualty.fromMap(Map<String, dynamic> map){
    orderId = map['oid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String id;

  late String orderId;
  late int quantity;
  late String size;


  Casualty? casualty;

  CarSize? get carSize {
    if (casualty == null) return null;
    return casualty!.findSize(size);
  }

  num? get unitPrice{
    if (casualty == null) return 0;
    return carSize!.price ?? 0;

  }

  num get totalPrice => unitPrice! * quantity;

  Map<String, dynamic> toOrderItemMap(){
    return{
      'oid': orderId,
      'quantity': quantity,
      'size': size,
    };
  }

  Map<String, dynamic> toOrdersItemMap(){
    return{
      'oid': orderId,
      'quantity': quantity,
      'size': size,

    };
  }

  bool stackable(Casualty casualty){
      return casualty.id == orderId && casualty.selectedSize.name == size;
  }

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final size = carSize;
    if (size == null) return false;
    return size.stock! >= quantity;

  }


}