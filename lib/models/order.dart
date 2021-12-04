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

  Order.fromDocument(DocumentSnapshot doc){
    orderid = doc.id;

    items = (doc.data()!['items'] as List<dynamic>).map((e) {
      return OrderCasualty.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.data()!['price'] as num;
    userId = doc.data()!['usuario'] as String;
    address = Address.fromMap(doc.data()!['address'] as Map<String, dynamic>);
    date = doc.data()!['date'] as Timestamp;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> save() async {
    firestore.collection('orders').doc(orderid).set(
      {
        'items': items.map((e) => e.toOrdersItemMap()).toList(),
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

  String get formattedId => '#${orderid.padLeft(6, '0')}';

  @override
  String toString() {
    return 'Order{firestore: $firestore, orderid: $orderid, items: $items, price: $price, userId: $userId, address: $address, date: $date}';
  }
}