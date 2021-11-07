import 'package:dual/common/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Informações',
          style: TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
                'Necessitou? Prá quem ligar?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
             Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('(31) 3318-8360 \n(31) 98470-3470'),
            Padding(
               padding: EdgeInsets.all(16)
           ),
            Text(
              'Quais ações devo fazer?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('Em caso de algum problema com seu veiculo, você deve ir diretamente para a pagina de Sinistros e escolher a opção mais adequada!'),
            Padding(
                padding: EdgeInsets.all(16)
            ),
            Text(
                'Qual oficina devo encaminhar?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('Você podera escolher alguma oficina franquiada'),
            Padding(
                padding: EdgeInsets.all(16)
            ),
            Text('Como Solicitar Transporte extra? Como solicitar Guincho?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('Dentro da pagina de Sinistros, vai ter as opções que melhor te atende!'),
            Padding(
                padding: EdgeInsets.all(16)
            ),
            Text('Como fazer um Boletim de Ocorrência?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('Você devera fazer um boletim de ocorrencia com alguma autoridade'),
            Padding(
                padding: EdgeInsets.all(16)
            ),
            Text('O que fazer com Terceiros?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('Devera ser enviado uma foto do documento do outro condutor e informaçoes como: placa do veiculo'),
            Padding(
                padding: EdgeInsets.all(16)
            ),
            Text('Como acompanhar os serviços a serem feito no carro?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('Você tera uma barra de progresso te informando o progresso'),
            Padding(
                padding: EdgeInsets.all(16)
            ),
            Text('Qual é minha Franquia?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text('(31) 3318-8360 \n(31) 98470-3470'),
          ],
        ),
      ),
    );
  }
}
