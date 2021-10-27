import 'package:cloud_firestore/cloud_firestore.dart';


class Usuario {

  Usuario({required this.email, required this.password, required this.id, required this.name});

  Usuario.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()!['name'] as String;
    email = document.data()!['email'] as String;

  }

   late String id;
   late String name;
   late String email;
   late String password;

   late String confirmPassword;

   DocumentReference get firestoreRef =>
       FirebaseFirestore.instance.doc('users/$id');

   Future<void> saveData() async{
   await firestoreRef.set(toMap());
   }

    Map<String, dynamic> toMap(){
     return {
       'name' : name,
       'email' : email,
      };
    }
}