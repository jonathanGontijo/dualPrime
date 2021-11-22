import 'package:dual/models/order_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceOrder extends StatelessWidget {

  const PriceOrder({required this.buttonText, required this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final orderManager = context.watch<OrderManager>();
    final orderPrices = orderManager.orderPrice;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                'Resumo do Serviço',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal'),
                Text('R\$ ${orderPrices.toStringAsFixed(2)}'),
              ],
            ),
            Divider(),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text('R\$ ${orderPrices.toStringAsFixed(2)}'),
              ],
            ),
            SizedBox(height: 8,),
            RaisedButton(
              onPressed: onPressed,
              textColor: Colors.amberAccent,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              color: Theme.of(context).primaryColor,
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}
