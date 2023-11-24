
import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class AuthViewViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _logInLoading = false;
  bool get logInLoading => _logInLoading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _logInLoading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }


  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString(),
        )
      );

      print(value);

      Utils.flushBarErrorMessage('Login Successful', context);
      Navigator.pushNamed(context, RoutesName.home);

    }).onError((error, stackTrace) {
      setLoading(false);

      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);

      print(value);

      Utils.flushBarErrorMessage('Sign Up Successful', context);
      Navigator.pushNamed(context, RoutesName.home);

    }).onError((error, stackTrace) {
      setSignUpLoading(false);

      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}