import 'package:dual/common/custom_icon_button.dart';
import 'package:dual/models/car_size.dart';
import 'package:dual/models/casualty.dart';
import 'package:flutter/material.dart';

import 'edit_item_size.dart';

class SizesForm extends StatelessWidget {

  SizesForm(this.casualty);

  final Casualty casualty;

  @override
  Widget build(BuildContext context) {
    return FormField<List<CarSize>>(
      initialValue: List.from(casualty.sizes),
        validator: (sizes){
         if(sizes!.isEmpty)
           return 'Insira ao menos uma opção';
         return null;
        },
        builder: (state){
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Opções',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: (){
                    state.value!.add(CarSize());
                    state.didChange(state.value);
                    },
                ),
              ],
            ),
            Column(
              children: state.value!.map((size) {
                return EditItemSize(
                 // key: ObjectKey(size),
                  size: size,
                  onRemove: (){
                    state.value!.remove(size);
                    state.didChange(state.value);
                  },
                 /* onMoveUp: (){
                    final index = state.value!.indexOf(size);
                    state.value!.remove(size);
                    state.value!.insert(index-1, size);
                    state.didChange(state.value);
                  },
                  onMoveDown: (){
                    final index = state.value!.indexOf(size);
                    state.value!.remove(size);
                    state.value!.insert(index+1, size);
                    state.didChange(state.value);
                  },*/
                );
            }).toList(),
            ),
            if(state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
        },
    );
  }
}
