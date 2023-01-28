import 'package:dart_api_app/screens/authorization_screen/authorization_screen_provider.dart';
import 'package:dart_api_app/screens/main_screen/main_screen_provider.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await Api.init(urls: ['http://localhost:8080/api'], usePrintInLogs: true, globalTestMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(child: Api.tokenIsNotEmpty ? const MainScreenProvider() : const AuthorizationScreenProvider(),) ,
    );
  }
}