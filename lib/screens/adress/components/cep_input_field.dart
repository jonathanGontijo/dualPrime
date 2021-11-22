import 'package:brasil_fields/brasil_fields.dart';
import 'package:dual/common/custom_icon_button.dart';
import 'package:dual/models/address.dart';
import 'package:dual/models/order_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {

  CepInputField(this.address);

  final Address address;

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    if(address.street == null)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: cepController,
          decoration: InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '32.345-678'
          ),
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          keyboardType: TextInputType.number,
          validator: (cep){
            if(cep!.isEmpty)
              return 'Campo obrigatório';
            else if(cep.length != 10)
              return 'CEP Inválido';
            return null;
          },
        ),
        RaisedButton(
            onPressed: (){
              if(Form.of(context)!.validate()){
                context.read<OrderManager>().getAddress(cepController.text);
              }
            },
          textColor: Colors.yellowAccent,
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          child: Text('Buscar CEP'),
         ),
      ],
    );
    else
      return Row(
        children: [
          Expanded(
            child: Text(
                'CEP:  ${address.zipCode}',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          CustomIconButton(
              iconData: Icons.edit,
              color: primaryColor,
              size: 20,
              onTap: (){
                context.read<OrderManager>().removedAddress();
              }
          )
        ],
      );
  }
}
