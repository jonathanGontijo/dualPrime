import 'package:flutter/material.dart';

import 'components/adress_card.dart';

class AdressScreen extends StatelessWidget {
  const AdressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destino'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AdressCard()
        ],
      ),
    );
  }
}
