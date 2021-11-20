import 'package:dual/models/casualty.dart';
import 'package:flutter/material.dart';
import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditCasualtyScreen extends StatelessWidget {

  EditCasualtyScreen(Casualty c) :
        casualty = c != null ? c : Casualty();

  final Casualty casualty;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Sinistro'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(casualty),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: casualty.name,
                    decoration: InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (name){
                      if (name!.length < 3 )
                        return 'Título muito curto';
                      return null;
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8),
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
                        color: Colors.grey[600]
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
                  TextFormField(
                    initialValue: casualty.description,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 13
                    ),
                    decoration: InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none
                    ),
                    maxLines: null,
                    validator: (desc){
                      if (desc!.length < 10)
                        return 'Descrição muito curta';
                      return null;
                    },
                  ),
                  SizesForm(casualty),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                          print('valido');
                        }
                      },
                      color: primaryColor,
                      disabledColor: primaryColor.withAlpha(100),
                      child: const Text(
                          'Salvar',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
