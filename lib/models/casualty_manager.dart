import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual/models/casualty.dart';
import 'package:flutter/cupertino.dart';


class CasualtyManager extends ChangeNotifier{

  CasualtyManager(){
    _loadAllCasualty();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Casualty> allCasualty = [];

  String _search = '';

  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Casualty> get filteredCasualty {
    final List<Casualty> filteredCasualty = [];

    if (search.isEmpty) {
      filteredCasualty.addAll(allCasualty);
    } else {
      filteredCasualty.addAll(
      allCasualty.where(
              (p) => p.name.toLowerCase().contains(search.toLowerCase())
      )
    );
    }
    return filteredCasualty;
  }

  Future<void> _loadAllCasualty()async{
    final QuerySnapshot snapCasualty =
    await firestore.collection('casualty').get();

    allCasualty = snapCasualty.docs.map((d) =>
        Casualty.fromDocument(d)).toList();

    notifyListeners();
  }
  
  Casualty? findCasualtyById(String id) {
    try {
      return allCasualty.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

}