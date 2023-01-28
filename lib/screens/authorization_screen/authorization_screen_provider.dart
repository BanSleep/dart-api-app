import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authorization_screen.dart';
import 'cubit/cb_authorization_screen.dart';
import 'cubit/st_authorization_screen.dart';

class AuthorizationScreenProvider extends StatelessWidget {
  const AuthorizationScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbAuthorizationScreen>(
      create: (context) => CbAuthorizationScreen(),
      child: const AuthorizationScreen(),
    );
  }
}    
    