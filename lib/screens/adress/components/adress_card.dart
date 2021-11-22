import 'package:dual/models/address.dart';
import 'package:dual/models/order_manager.dart';
import 'package:dual/screens/adress/components/address_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cep_input_field.dart';

class AdressCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Consumer<OrderManager>(
          builder: (_, orderManager, __){
            final address = orderManager.address ?? Address();

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Local do Sinistro',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  CepInputField(address),
                  AddressInputField(address),
                 // if(address.zipCode != null && orderManager.distancyP != null)
                   /* Padding(
                        padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        '${address.street}, ${address.number}\n${address.district}\n${address.city} - ${address.state}'
                      ),
                    )*/
                ],
              ),
            );
          }
        ) ,
      ),
    );
  }
}
