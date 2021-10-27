import 'package:dual/helpers/validators.dart';
import 'package:dual/models/user.dart';
import 'package:dual/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey =GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed('/signup');
              },
            textColor: Colors.white,
              child: Text('Criar Conta',
                style: TextStyle(fontSize: 14),
              ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
                builder: (_, userManager, __){
                  return ListView(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email!))
                            return 'E-mail inválido';
                          return null;

                        },
                      ),
                      SizedBox(height: 16,),
                      TextFormField(
                        controller: passwordController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password!.isEmpty || password.length < 6)
                            return 'Senha Inválida';
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.loading ? null : () {
                            if(formKey.currentState!.validate()){
                              userManager.signIn(
                                  usuario:  Usuario(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      id: '',
                                      name: '',
                                  ),
                                  onFail: (e){
                                    scaffoldKey.currentState!.showSnackBar(
                                         SnackBar(
                                          content: Text('Falha ao entrar'),
                                          backgroundColor: Colors.red,
                                        )
                                    );
                                  },
                                  onSucess: (){
                                    Navigator.of(context).pop();
                                  }
                              );
                            }
                          },
                          child:  userManager.loading ?
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ) :
                          const Text(
                            'Entrar',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.amberAccent
                            ),

                          ),
                        ),
                      )
                    ],
                  );
                },
                ),
          ),
        ),
      ),
    );
  }
}
