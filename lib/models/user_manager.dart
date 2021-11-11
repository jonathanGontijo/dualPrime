import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/helpers/firebase_errors.dart';
import 'package:dual/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {

  UserManager(){
    _loaCurrrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Usuario? usuario;


  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => usuario != null;

  Future<void> signIn({required Usuario usuario, required Function onFail, required Function onSucess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.password);

      await _loaCurrrentUser(user: result.user );
      //this.usuario = result.user! as Usuario?;

      onSucess();

    } on PlatformException  catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  Future<void> signUp({required Usuario usuario, required Function onFail, required Function onSucess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: usuario.email, password: usuario.password);


      usuario.id = result.user!.uid;
      this.usuario = usuario;

      await usuario.saveData();

      onSucess();

    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut(){
    auth.signOut();
    usuario = null;
    notifyListeners();
  }


  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loaCurrrentUser({User? user}) async {
    User? currentUser = user ?? await auth.currentUser;
    if (currentUser != null) {
       final DocumentSnapshot docUser = await firestore.collection('users')
           .doc(currentUser.uid).get();
       usuario = Usuario.fromDocument(docUser) as Usuario?;


       final docAdmin = await firestore.collection('admins').doc(usuario!.id).get();
       if(docAdmin.exists){
         usuario!.admin = true;
       }


       notifyListeners();
    }
  }

  bool get adminEnable => usuario != null && usuario!.admin;
}


