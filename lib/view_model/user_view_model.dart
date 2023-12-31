
//class made to apply shared preferences(using model of user). we will save here using our model.
import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewViewModel with ChangeNotifier {

  //user saved and the token too
  Future<bool> saveUser(UserModel user) async {

    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  //token received
  Future<UserModel> getUser() async {

    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return UserModel(
      token: token.toString()
    );
  }

  //logout user
  Future<bool> removeUser() async {

    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}