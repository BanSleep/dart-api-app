import 'dart:convert';

import 'package:dart_api_app/screens/main_screen/main_screen_provider.dart';
import 'package:get/get.dart';

import 'st_authorization_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbAuthorizationScreen extends Cubit<StAuthorizationScreen> {
  CbAuthorizationScreen() : super(StAuthorizationScreenLoaded());
  
  register(String login, String password) async {
    try {
      emit(StAuthorizationScreenLoading());
      Map<String, dynamic> response = await Api.post('register', body: {
        'login': login,
        "password": password,
      });
      print('${response['token']}');
      Api.setToken(response['token']);
      Get.offAll(() => const MainScreenProvider());
    } on APIException catch (e) {
      var err = jsonDecode(e.body);
      emit(StAuthorizationScreenError(message: err['message']));
    }
  }

  login(String login, String pass) async {
    try {
      Map<String, dynamic> response = await Api.post('login', body: {
        'login': login,
        'password': pass,
      });
      Api.setToken(response['token']);
      Get.offAll(() => const MainScreenProvider());
    } on APIException catch (e) {

    }
  }
}
    