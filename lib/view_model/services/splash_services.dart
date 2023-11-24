

import 'package:flutter/material.dart';

import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';

import '../../model/user_model.dart';

class SplashServices {

  Future<UserModel> getUserData() => UserViewViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {

      if(value.token == 'null' || value.token == '') {
        await Future.delayed(Duration(seconds: 5));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(Duration(seconds: 5));
        Navigator.pushNamed(context, RoutesName.home);
      }

    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}