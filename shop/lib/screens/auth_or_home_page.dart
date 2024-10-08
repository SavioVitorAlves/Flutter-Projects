import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/screens/auth_page.dart';
import 'package:shop/screens/product_overivew_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    //return auth.isAuth ? ProductOverivewPage() : AuthPage();
    return FutureBuilder(
      future: auth.tryAutoLogin(), 
      builder: (ctx, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        } else if(snapshot.error != null){
          return Center(child: Text('Ocorreu um error!'));
        }else{
          return auth.isAuth ? ProductOverivewPage() : AuthPage();
        }
      }
    );
  }
}