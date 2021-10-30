import 'package:dual/models/car_size.dart';
import 'package:dual/models/casualty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {

  SizeWidget({required this.size});

  final CarSize size;

  @override
  Widget build(BuildContext context) {

    final casualty = context.watch<Casualty>();
    final selected = size == casualty.selectedSize;



    Color color;
    if (!size.hasStock)
      color = Colors.red.withAlpha(50);
     else if(selected)
        color = Colors.green;
     else
       color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          casualty.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
               color: color,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name!,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
               'R\$ ${size.price!.toStringAsFixed(2)}',
                style: TextStyle(
                    color: color
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
