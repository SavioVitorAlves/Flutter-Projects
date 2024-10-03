import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exceptions.dart';
import 'package:shop/models/auth.dart';

enum AuthMode {Signup, Login}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;

  final _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  void _switchAuthMode(){
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      }
      else{
        _authMode = AuthMode.Login;
      }
    });
  }
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;
  bool _isLoading = false;
  
  void _showErrorModal(String msg){
    showDialog(
      context: context, 
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um error!'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Fechar')
          )
        ],
      )
    );
  }
  
  Future<void> _submit() async{
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);
    try {
      if (_isLogin()) {
        await auth.login(_authData['email']!, _authData['password']!,);
      }else{
        await auth.signup(_authData['email']!, _authData['password']!,);
      }
    } on AuthExceptions catch (e) {
      _showErrorModal(e.toString());
    }catch(e){
      _showErrorModal('Ocorreu um error inesperado!');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final diviceSize =  MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        height: _isLogin() ? 310 : 400,
        width: diviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration( labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _authData['email'] = email ?? '',
              validator: (_email){
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'informe uma e-mail valido!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration( labelText: 'Senha'),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              controller: _passwordControler,
              onSaved: (password) => _authData['password'] = password ?? '',
              validator: (_password){
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Informe uma Senha valida!';
                }
                return null;
              },  
            ),
            if(_isSignup())
            TextFormField(
              decoration: const  InputDecoration( labelText: 'Confirmar Senha'),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              validator: _isLogin() 
              ? null 
              : (_password){
                final password = _password ?? '';
                if (password != _passwordControler.text) {
                  return 'Senhas Informadas não Confeerem.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            if(_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _submit, 
                child: Text(
                  _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISRAR'
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8
                  )
                ),

              ),
            const Spacer(),
            TextButton(
              onPressed: _switchAuthMode, 
              child: Text(
                _isLogin() ? 'DESEJA REGISTRAR?' : 'JA POSSUI CONTA?'
              )
              )
          ],
        )),
      ),
    );
  }
}