import 'package:dart_api_app/pj_utils/pj_colors.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cubit/cb_authorization_screen.dart';
import 'cubit/st_authorization_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  bool obscure = false;
  bool isAuthorization = true;
  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String err = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<CbAuthorizationScreen, StAuthorizationScreen>(
        listener: (context, state) {
          if (state is StAuthorizationScreenError) {
            print(Api.token);
            setState(() {
              err = state.message!;
            });
          }
        },
        buildWhen: (oldState, newState) =>
            newState is StAuthorizationScreenLoaded,
        builder: (context, state) {
          if (state is StAuthorizationScreenLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is StAuthorizationScreenLoaded) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height / 6,
                    ),
                    Center(
                      child: Text(
                        isAuthorization ? 'Авторизация' : "Регистрация",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: PjColors.green),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: loginController,
                      style: TextStyle(color: PjColors.green),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.redAccent),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PjColors.green),
                            borderRadius: BorderRadius.circular(20)),
                        errorText: err.isNotEmpty ? err : null,
                        hintStyle: TextStyle(color: PjColors.green),
                        hintText: 'Логин',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PjColors.green),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PjColors.green),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      cursorColor: PjColors.green,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passController,
                      style: TextStyle(color: PjColors.green),
                      obscureText: !obscure,
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        hintStyle: TextStyle(color: PjColors.green),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PjColors.green),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PjColors.green),
                            borderRadius: BorderRadius.circular(20)),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye_outlined,
                              color: PjColors.green,
                            )),
                      ),
                      cursorColor: PjColors.green,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: isAuthorization
                                  ? 'Нет аккаунта? '
                                  : "Уже есть аккаунт? ",
                              style: TextStyle(
                                  fontSize: 15, color: PjColors.green)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isAuthorization = !isAuthorization;
                                  });
                                },
                              text: isAuthorization
                                  ? 'Зарегистрироваться'
                                  : 'Войти',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: PjColors.green,
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        isAuthorization
                            ? context.read<CbAuthorizationScreen>().login(
                                loginController.text, passController.text)
                            : context.read<CbAuthorizationScreen>().register(
                                loginController.text, passController.text);
                      },
                      child: Container(
                        width: Get.width - 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: PjColors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            isAuthorization ? 'Войти' : 'Зарегистрироваться',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(color: Colors.grey);
        },
      ),
    );
  }
}
