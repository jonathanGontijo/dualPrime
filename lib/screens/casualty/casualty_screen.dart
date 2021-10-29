import 'package:carousel_slider/carousel_slider.dart';
import 'package:dual/models/casualty.dart';
import 'package:flutter/material.dart';

class CasualtyScreen extends StatelessWidget {

  const CasualtyScreen(this.casualty);

  final Casualty casualty;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          casualty.name
        ),
        centerTitle: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Telefone: 0000000',
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
