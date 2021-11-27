import 'package:dual/common/price_order.dart';
import 'package:dual/models/order_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          AdressCard(),
          Consumer<OrderManager>(
              builder: (_,orderManager, __){
                return PriceOrder(
                  buttonText: 'Continuar para finalizar',
                  onPressed: /* orderManager.isAddressValid ? */ (){
                    Navigator.of(context).pushNamed('/checkout');                  }, /*: null,*/
                );
              },
          ),
        ],
      ),
    );
  }
}
