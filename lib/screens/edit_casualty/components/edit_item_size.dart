import 'package:dual/common/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:dual/models/car_size.dart';

class EditItemSize extends StatelessWidget {

  EditItemSize({required this.size, required this.onRemove,});

  final CarSize size;
  final VoidCallback onRemove;
  //final VoidCallback onMoveUp;
 // final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 50,
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: 'Título',
              isDense: true
            ),
            validator: (name){
              if(name!.isEmpty)
                return 'Inválido';
              return null;
            },
            onChanged: (name) => size.name = name ,

          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 20,
          child:TextFormField(
            initialValue: size.stock?.toString(),
            decoration: InputDecoration(
                labelText: 'Estoque',
                isDense: true
            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if(int.tryParse(stock!)== null)
                return 'Inválido';
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child:TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: InputDecoration(
                labelText: 'Preço',
                isDense: true,
              prefix: Text('R\$'),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (price){
              if (num.tryParse(price!) == null)
                return 'Inválido';
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
            iconData: Icons.remove,
            color: Colors.red,
            onTap: onRemove,
        ),
        /*CustomIconButton(
            iconData: Icons.arrow_drop_up,
            color: Colors.black,
            onTap: onMoveUp,
        ),
        CustomIconButton(
            iconData: Icons.arrow_drop_down,
            color: Colors.black,
            onTap: onMoveDown,
        ),*/
      ],
    );
  }
}
