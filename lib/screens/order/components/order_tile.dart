import 'package:dual/common/custom_icon_button.dart';
import 'package:dual/models/order_casualty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTile extends StatelessWidget {

  const OrderTile(this.orderCasualty);

  final OrderCasualty orderCasualty;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: orderCasualty,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(orderCasualty.casualty!.images.first),
              ),
              Expanded(child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    Text(
                      orderCasualty.casualty!.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Opção: ${orderCasualty.size}',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ) ,
                    ),
                    Consumer<OrderCasualty>(
                        builder: (_, orderCasualty, __){
                          if(orderCasualty.hasStock)
                            return Text(
                              'R\$ ${orderCasualty.unitPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            );
                          else
                            return Text(''
                                'Modelo de carro indisponivel',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            );
                        }
                    )
                  ],
                ),
              ),
              ),
              Consumer<OrderCasualty>(
                  builder: (_, orderCasualty, __){
                    return Column(
                      children: [
                        CustomIconButton(
                          iconData: Icons.add,
                          color: Theme.of(context).primaryColor,
                          onTap: orderCasualty.increment,
                        ),
                        Text(
                            '${orderCasualty.quantity}'
                        ),
                        CustomIconButton(
                          iconData: Icons.remove,
                          color: orderCasualty.quantity > 1 ?
                          Theme.of(context).primaryColor : Colors.red,
                          onTap: orderCasualty.decrement,
                        ),
                      ],
                    );
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
