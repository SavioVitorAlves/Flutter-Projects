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

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin{
  AuthMode _authMode = AuthMode.Login;

  final _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  AnimationController?  _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(microseconds: 300));
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0)
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));


    //_heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }

  void _switchAuthMode(){
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
        _controller?.forward();
      }
      else{
        _authMode = AuthMode.Login;
        _controller?.reverse();
      }
    });
  }
  bool _isLogin() => _authMode == AuthMode.Login;
  //bool _isSignup() => _authMode == AuthMode.Signup;
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
      child:  AnimatedContainer(
        duration: Duration(microseconds: 300),
        curve: Curves.easeIn,
        padding: EdgeInsets.all(16),
        height: _isLogin() ? 310 : 400,
        //height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
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
            
            AnimatedContainer(
              constraints: BoxConstraints(
                minHeight: _isLogin() ? 0 : 60,
                maxHeight: _isLogin() ? 0 : 120,
              ),
              duration: Duration(microseconds: 300),
              curve: Curves.linear,
              child: FadeTransition(
                opacity: _opacityAnimation!,
                child: SlideTransition(
                  position: _slideAnimation!,
                  child: TextFormField(
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
                ),
              ),
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