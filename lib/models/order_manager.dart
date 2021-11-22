import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/casualty.dart';
import 'package:dual/models/order_casualty.dart';
import 'package:dual/models/user.dart';
import 'package:dual/models/user_manager.dart';
import 'package:dual/services/cepaberto_service.dart';
import 'package:flutter/material.dart';
import 'address.dart';

class OrderManager extends ChangeNotifier{

  List<OrderCasualty> items = [];

  Usuario? usuario;
  Address? address;

  num orderPrice = 0.0;
  num distancyP = 0.0;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserManager userManager){
    usuario = userManager.usuario;
    items.clear();

    if (usuario != null) {
      _loadOrderItems();
    }
  }

  Future<void> _loadOrderItems() async {
    final QuerySnapshot orderSnap = await usuario!.orderReference.get();
    
    items = orderSnap.docs.map(
            (d) => OrderCasualty.fromDocument(d)..addListener(_onItemUpdated)
    ).toList();
  }

  void addToOrder(Casualty casualty){
    try {
      final e = items.firstWhere((p) => p.stackable(casualty));
      e.increment();
    } catch(e){
      final orderCasualty = OrderCasualty.fromCasualty(casualty);
      orderCasualty.addListener(_onItemUpdated);
      items.add(orderCasualty);
      usuario!.orderReference.add(orderCasualty.toOrderItemMap())
          .then((doc) => orderCasualty.id = doc.id );
      _onItemUpdated();
    }
  }

  void removeOfOrder(OrderCasualty orderCasualty){
    items.removeWhere((p) => p.id == orderCasualty.id);
    usuario!.orderReference.doc(orderCasualty.id).delete();
    orderCasualty.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated(){
    orderPrice = 0.0;

    for(int i = 0; i < items.length; i++){
      final orderCasualty = items[i];

      if (orderCasualty.quantity == 0) {
        removeOfOrder(orderCasualty);
        i--;
        continue;
      }

      orderPrice += orderCasualty.totalPrice;

      _updateOrderCasualty(orderCasualty);
    }
    notifyListeners();
  }

  void _updateOrderCasualty(OrderCasualty orderCasualty){
    if(orderCasualty.id != null)
    usuario!.orderReference.doc(orderCasualty.id)
        .update(orderCasualty.toOrderItemMap());
  }

  bool get isOrderValid {
    for(final orderCasualty in items){
      if(!orderCasualty.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && distancyP != null;

  Future<void> getAddress(String cep) async {
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if(cepAbertoAddress != null){
        address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude
        );
        notifyListeners();
      }
    } catch (e){
      debugPrint(e.toString());
    }
  }

  Future<void> setAddress(Address address)async{
    this.address = address;

    if(await calculate(address.lat, address.long)){
      print('price $distancyP');
      notifyListeners();
    } else {
      return Future.error('Endereço acima da distancia limite. ');
    }
  }

  void removedAddress(){
    address = null;
    notifyListeners();
  }

  Future<bool> calculate(double? lat, double? long) async {
    final DocumentSnapshot doc = await firestore.doc('aux/distancy').get();

    final latStore = doc.data()!['lat'] as double;
    final longStore = doc.data()!['long'] as double;

    final maxkm = doc.data()!['maxkm'] as num;

    double dis =
    await Geolocator.distanceBetween(latStore, longStore, lat!, long!);

    dis /= 1000.0;

    print('Distance $dis');

    if(dis > maxkm){
      return false ;
    }

    distancyP = dis;
    return true;


  }


}