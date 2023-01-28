import 'package:dart_api_app/models/user_model.dart';

import 'st_main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbMainScreen extends Cubit<StMainScreen> {
  CbMainScreen() : super(StMainScreenLoading());

  List<UsersModel> users = [];
  
  Future<void> getData() async {
  try {
    Map<String, dynamic> response =
          await Api.get('test-get', testMode: true);
    for (Map<String, dynamic> elm in response['users']) {
      users.add(UsersModel.fromJson(elm));
    }
    print(users);
      emit(StMainScreenLoaded(users: users));
    } on APIException catch (e) {
    print(e.body);
    }
  }

  addUser(String name, String lastName) async {
    emit(StMainScreenLoading());
    try {
      Map<String, dynamic> responsePost = await Api.post('test-post', body: {
        'name': name,
        'last_name': lastName
      });
      users = [];
      for (Map<String, dynamic> elm in responsePost['users']) {
        users.add(UsersModel.fromJson(elm));
      }
      emit(StMainScreenLoaded(users: users));
    } on APIException catch(e) {
      emit(StMainScreenError());
    }
  }

  deleteUser() async {
    try {
      Map<String, dynamic> response = await Api.delete('delete-user');
      users = [];
      for (Map<String, dynamic> elm in response['users']) {
        users.add(UsersModel.fromJson(elm));
      }
      emit(StMainScreenLoaded(users: users));
    } on APIException catch(e) {

    }
  }
}
    