import 'package:dart_api_app/models/user_model.dart';

abstract class StMainScreen{}

class StMainScreenInit extends StMainScreen{}

class StMainScreenLoaded extends StMainScreen{
  List<UsersModel> users;
  StMainScreenLoaded({required this.users});
}

class StMainScreenLoading extends StMainScreen{}

class StMainScreenNoAuthError extends StMainScreen{}

class StMainScreenNoInternetError extends StMainScreen {}

class StMainScreenError extends StMainScreen{
  final int? error;
  final String? message;
  StMainScreenError({this.error,this.message});
}
    