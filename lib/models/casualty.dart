import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/car_size.dart';
import 'package:flutter/cupertino.dart';

class Casualty extends ChangeNotifier{

  Casualty(){
    images = [];
    sizes = [];
  }

  List<CarSize> carSize = [];
  CarSize _selectedSize = CarSize(/*'','',''*/) ;

  Casualty.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()!['name'] as String;
    description = document.data()!['description'] as String;
    images = List<String>.from(document.data()!['images'] as List<dynamic>);

    sizes = (document.data()!['sizes'] as List<dynamic> ?? [] ).map((
       s) => CarSize.fromMap(s as Map<String , dynamic>)).toList();

  }

  late String id;
  late String name;
  late String description;
  late List<String> images;
  late List<CarSize> sizes;

  //late CarSize _selectedSize;

  CarSize get selectedSize => _selectedSize;


  set selectedSize(CarSize value){
    _selectedSize = value;

    notifyListeners();
  }

  int get totalStock{
    int stock = 0;
    for(final size in sizes){
      stock += size.stock!;
    }
    return stock;
  }

  bool get hasStock{
    return totalStock > 0;
  }
  
  CarSize? findSize(String name) {
    try{
      return sizes.firstWhere((s) => s.name == name);
    } catch (e){
    return null;
    }
  }

}