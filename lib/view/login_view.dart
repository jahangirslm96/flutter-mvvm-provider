
import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login',style: TextStyle(color: AppColors.whiteColor),),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
                labelText: "Email",
                prefixIcon: Icon(Icons.alternate_email),
              ),
              onFieldSubmitted: (value){
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child){
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: passwordFocusNode,
                    obscureText: _obscurePassword.value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: InkWell(
                        onTap: (){
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                          child: Icon(
                              _obscurePassword.value ? Icons.visibility_off_outlined : Icons.visibility,
                          ),
                      ),
                    ),
                  );
                },
            ),
            SizedBox(
              height: height * 0.085,
            ),
            RoundButton(
              title: 'Login',
              loading: authViewModel.logInLoading,
              onPress: () {
                if(_emailController.text.isEmpty && _passwordController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please enter email and password', context);
                }else if(_passwordController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please enter Password', context);
                }else if(_emailController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please enter email', context);
                }else if(_passwordController.text.length < 6){
                  Utils.flushBarErrorMessage('Password should be atleast 6 digits', context);
                }
                else{
                  Map data = {
                    "email": _emailController.text.toString(),
                    "password": _passwordController.text.toString(),
                  };

                  authViewModel.loginApi(data, context);
                  print('api hit');
                }
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ? "),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.signUp);
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
