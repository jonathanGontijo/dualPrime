import 'package:dual/helpers/validators.dart';
import 'package:dual/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:dual/models/user.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey =GlobalKey<ScaffoldState>();

  final Usuario usuario = Usuario(email: '',password: '',id: '', name: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                return ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Nome Completo' ),
                      //enabled: !userManager.loading,
                      validator: (name){
                        if (name!.isEmpty)
                          return 'Campo Obrigatório';
                        else if (name.trim().split(' ').length <=1)
                          return 'Preencha seu nome completo';
                        return null;
                      },
                      onSaved: (name) => usuario.name = name!,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'E-mail' ),
                      keyboardType: TextInputType.emailAddress,
                      //enabled: !userManager.loading,
                      validator: (email){
                        if (email!.isEmpty)
                          return 'Campo Obrigatório';
                        else if (!emailValid(email))
                          return 'E-mail inválido';
                        return null;
                      },
                      onSaved: (email) => usuario.email = email!,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Senha' ),
                      obscureText: true,
                     // enabled: !userManager.loading,
                      validator: (pass){
                        if(pass!.isEmpty)
                          return 'Campo Obrigatório';
                        else if(pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => usuario.password = pass!,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Repita a Senha' ),
                      obscureText: true,
                      //enabled: !userManager.loading,
                      validator: (pass){
                        if(pass!.isEmpty)
                          return 'Campo Obrigatório';
                        else if(pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => usuario.confirmPassword = pass!,
                    ),
                    SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor,
                        textColor: Colors.amberAccent,
                        onPressed: userManager.loading ? null : (){
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          if (usuario.password != usuario.confirmPassword) {
                            scaffoldKey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text('Senhas não coincidem!'),
                                backgroundColor: Colors.red,
                              )
                            );
                            return;
                          }
                          userManager.signUp(
                            usuario: usuario,
                            onSucess: (){
                               Navigator.of(context).pop();
                            },
                          onFail: (e){
                            scaffoldKey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text('Falha ao cadastrar: $e'),
                                backgroundColor: Colors.red,
                              )
                            );
                           },
                         );
                        }
                       },
                        child: userManager.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ) :
                        Text(
                          'Criar Conta',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          )
        ),
      ),
    );
  }
}
