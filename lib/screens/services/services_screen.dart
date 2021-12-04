import 'package:dual/models/orders_adm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/services_tile.dart';

class ServicesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Chamados'),
        centerTitle: true,
      ),
      body: Consumer<OrdersAdm>(
        builder: (_, ordersAdm, __){
          if (ordersAdm.usuario == null) {
            return Text(
                "Por gentileza, Logar para Verificar seu Chamados!!!",
              style: TextStyle(
                color: Colors.black,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: ordersAdm.orders.length ,
                itemBuilder: (_, index){
                  return ServicesTile(
                    ordersAdm.orders.reversed.toList()[index]
                  );
                }
            );
          }
        },
      ),
    );
  }
}
