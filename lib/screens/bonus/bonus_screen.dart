import 'package:dual/common/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class BonusScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Benefícios',
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
              'Renovação de Seguros',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
              '*Recebe 5% de desconta da Franquia em eventuais serviços realizados futuramente, na oficina Franqueada!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
              '*Recebe 5% de desconto na renovação junto à seguradora!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
             '*Recebe inspeção Gratuita do veiculo em 15 itens de segurança!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
              '*Recebe status de Fidelização, com atendimento personalizado e priorização do serviços!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16)
            ),
            Text(
              'Serviços Realizados',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
                '*Recebe 5% de desconta da Franquia em eventuais serviços realizados futuramente, na oficina FranqueadaRecebe 3% de desconto na renovação junto à seguradora!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
              '*Recebe inspeção Gratuita do veiculo em 15 itens de segurança!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
              '*Recebe status de Fidelização, com atendimento personalizado e priorização dos serviços!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8)
            ),
            Text(
              '*Recebe anualmente um polimento da pintura!',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
