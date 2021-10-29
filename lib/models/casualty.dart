import 'package:cloud_firestore/cloud_firestore.dart';

class Casualty {

  Casualty.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()!['name'] as String;
    description = document.data()!['description'] as String;
    images = List<String>.from(document.data()!['images'] as List<dynamic>);
  }

  late String id;
  late String name;
  late String description;
  late List<String> images;
}