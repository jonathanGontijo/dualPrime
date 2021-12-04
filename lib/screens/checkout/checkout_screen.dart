import 'package:dual/common/price_order.dart';
import 'package:dual/models/checkout_manager.dart';
import 'package:dual/models/order_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<OrderManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, orderManager, checkoutManager) =>
       checkoutManager!..updateOrder(orderManager),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Finalizar'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __){
            if(checkoutManager.loading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    SizedBox(height: 16,),
                    Text('Processando seu Chamado...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16
                    ),
                    )
                  ],
                ),
              );
            }
            return ListView(
              children: [
                PriceOrder(
                    buttonText: 'Finalizar Ordem',
                    onPressed: (){
                      checkoutManager.checkout(
                        onSucess: (){
                          Navigator.of(context).popUntil(
                                  (route) => route.settings.name == '/base');
                        }
                      );
                    }
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
