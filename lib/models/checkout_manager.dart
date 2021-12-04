import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/casualty.dart';
import 'package:dual/models/order.dart';
import 'package:dual/models/order_casualty.dart';
import 'package:dual/models/order_manager.dart';
import 'package:flutter/cupertino.dart';

class CheckoutManager extends ChangeNotifier{

  OrderManager? orderManager;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateOrder(OrderManager orderManager){
    this.orderManager = orderManager;
  }

  Future< void> checkout({Function? onSucess}) async {
    loading = true;

   // _decrementStock();

    _getOrderId().then((value) => print(value));

    final orderId = await _getOrderId();

    final order = Order.fromOrderManager(orderManager!);
    order.orderid = orderId.toString();

    await order.save();

    orderManager!.clear();
    onSucess!();

    loading = false;
  }


  Future<int> _getOrderId() async {
    final ref = firestore.doc('aux/ordercounter');

    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.data()!['current'] as int;
        await tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  /*void _decrementStock(){
    final List<Casualty> casualtyToUpdate = [];

    firestore.runTransaction((tx) async {
      for(final orderCasualty in orderManager!.items){
        final doc = await tx.get(
            firestore.doc('casualty/${orderCasualty.orderId}')
        );
        final casualty = OrderCasualty.fromDocument(doc);

        final size = casualty.carSize!(orderCasualty.size);
        if(size.stock - orderCasualty.quantity < 0){

        } else {
          size.stock -= orderCasualty.quantity;
          casualtyToUpdate.add(casualty);
        }
      }
    });
  }*/
}