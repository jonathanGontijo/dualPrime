import 'package:dual/models/address.dart';
import 'package:dual/models/order_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {

  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    //final orderManager = context.watch<OrderManager>();

    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : '';

    if(address.street != null)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          initialValue: address.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Av. Barão Homem de Melo',
          ),
         // validator: emptyValidator,
          onSaved: (t) => address.street = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                initialValue: address.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Número',
                  hintText: '123',
                ),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
               // validator: emptyValidator,
                onSaved: (t) => address.number = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: 'Opcional',
                ),
                onSaved: (t) => address.complement = t,
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: address.district,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Bairro',
            hintText: 'Estoril',
          ),
         // validator: emptyValidator,
          onSaved: (t) => address.district = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextFormField(
                //enabled: false,
                initialValue: address.city,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Cidade',
                  hintText: 'Belo Horizonte',
                ),
               // validator: emptyValidator,
                onSaved: (t) => address.city = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: address.state,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'UF',
                  hintText: 'MG',
                  counterText: '',
                ),
                maxLength: 2,
                validator: (e) {
                  if (e!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (e.length != 2) {
                    return 'Inválido';
                  }
                  return null;
                },
                onSaved: (t) => address.state = t,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8,),
        RaisedButton(
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          textColor: Colors.yellowAccent,
          onPressed: ()async {
            if(Form.of(context)!.validate()){
              Form.of(context)!.save();
              try{
                await context.read<OrderManager>().setAddress(address);
              } catch (e){
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                      backgroundColor: Colors.red,
                    )
                );
              }
            }
          },
          child: const Text('Calcular Distancia'),
        ),
      ],
    );
    else return Container();
    /*else if(address.zipCode != null)
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
            '${address.street}, ${address.number}\n${address.district}\n${address.city} - ${address.state}'
        ),
      );*/
  }
}
