import 'package:dual/models/casualty.dart';
import 'package:flutter/material.dart';

class CasualtyListTile extends StatelessWidget {

  const CasualtyListTile(this.casualty);

  final Casualty casualty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/casualty', arguments: casualty);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(casualty.images.first),
              ),
              SizedBox(width: 16,),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        casualty.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                        child: Text(
                            'Entrar em contato',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        'Telefone : (31) 3318-8360',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
