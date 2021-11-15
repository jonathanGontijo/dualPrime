import 'package:carousel_slider/carousel_slider.dart';
import 'package:dual/models/casualty.dart';
import 'package:dual/models/order_manager.dart';
import 'package:dual/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/size_widget.dart';

class CasualtyScreen extends StatelessWidget {

  const CasualtyScreen(this.casualty);

  final Casualty casualty;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: casualty,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            casualty.name
          ),
          centerTitle: true,
          actions: [
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if (userManager.adminEnable) {
                  return IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed(
                            '/edit_casualty',
                          arguments: casualty
                        );
                },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CarouselSlider(

                items: casualty.images.map((url) =>
                    Container(child: Center(child:  Image.network(url),),)).toList(),

                options: CarouselOptions(),
              ),

            ),
            Padding(
                padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    casualty.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Entre em contato',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13
                    ),
                   ),
                  ),
                  Text(
                    'Telefone: (31) 3318-8360 \n(31) 98470-3470',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Decrição',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    casualty.description,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Escolha o serviço que te atenda melhor!!!',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: casualty.sizes.map((s){
                      return SizeWidget(size: s);
                    }).toList(),
                  ),
                  SizedBox(height: 20,),
                  if (casualty.hasStock)
                  Consumer2<UserManager, Casualty>(
                      builder: (_, UserManager, casualty, __){
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: casualty.selectedSize != null ? (){
                              if (UserManager.isLoggedIn){
                                context.read<OrderManager>().addToOrder(casualty);
                                Navigator.of(context).pushNamed('/order');
                              }else {
                                Navigator.of(context).pushNamed('/login');
                              }
                            }:null,
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              UserManager.isLoggedIn
                                  ? 'Ir para página de confirmação'
                                  : 'Entre para solicitar o serviço',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
