import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/address.dart';
import 'package:dual/models/order_casualty.dart';
import 'package:dual/models/order_manager.dart';

class Order {

  Order.fromOrderManager(OrderManager orderManager){
    items = List.from(orderManager.items);
    price = orderManager.orderPrice;
    userId = orderManager.usuario!.id;
    address = orderManager.address!;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> save() async {
    firestore.collection('orders').doc(orderid).set(
      {
        'items': items.map((e) => e.toOrderItemMap()).toList(),
        'price': price,
        'usuario': userId,
        'address' : address.toMap(),
      }
    );
  }

  late String orderid;

  late List<OrderCasualty> items;
  late num price;

  late String userId;

  late Address address;

  late Timestamp date;

}