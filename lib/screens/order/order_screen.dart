import 'package:dual/common/price_order.dart';
import 'package:dual/models/order_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/order_tile.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordem'),
        centerTitle: true,
      ),
      body: Consumer<OrderManager>(
        builder: (_, orderManager, __){
          return ListView(
            children: [
              Column(
                children: orderManager.items.map(
                  (orderCasualty)=> OrderTile(orderCasualty)
                ).toList(),
              ),
              PriceOrder(
                buttonText: 'Continuar para local da prestação do serviço',
                onPressed: //orderManager.isOrderValid?
                    (){

                } //: null,
              ),
            ],
          );
        },
      ),
    );
  }
}
