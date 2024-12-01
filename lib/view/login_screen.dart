import 'package:flutter/material.dart';
import 'package:mvvm_app/res/widgets/round_button.dart';
import 'package:mvvm_app/utils/routes/routes_names.dart';
import 'package:mvvm_app/utils/utils.dart';
import 'package:mvvm_app/view/new_home_screen.dart';
import 'package:mvvm_app/viewModel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authviewmodel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login"),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: height * 0.30,
                width: height * 0.30,
                // color: AppColors.secondary3,
                decoration: BoxDecoration(
                  // color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 2,
                    ),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/logo.png',
                        ),
                        fit: BoxFit.contain)),

                //
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Sign in your Account', style: TextStyle(fontSize: 25,color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  Utils.changeNodeFocus(context,
                      current: _emailFocus, next: _passwordFocus);
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.email),
                  label: const Text("Email"),
                  hintText: "shahzaneer.dev@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                valueListenable: _obsecureNotifier,
                builder: ((context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: _obsecureNotifier.value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: _obsecureNotifier.value
                          ? InkWell(
                              onTap: () {
                                _obsecureNotifier.value =
                                    !_obsecureNotifier.value;
                              },
                              child: const Icon(Icons.visibility),
                            )
                          : InkWell(
                              onTap: () {
                                _obsecureNotifier.value =
                                    !_obsecureNotifier.value;
                              },
                              child: const Icon(Icons.visibility_off),
                            ),
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            RoundButton(
                title: "Login",
                loading: authviewmodel.loading,
                onPress: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                  );
                  // if (_emailController.text.isEmpty &&
                  //     _passwordController.text.isEmpty) {
                  //   Utils.flushBarErrorMessage(
                  //       "email aur password de bhai", context);
                  // } else if (_passwordController.text.isEmpty) {
                  //   Utils.flushBarErrorMessage("Password de bhai", context);
                  // } else if (_emailController.text.isEmpty) {
                  //   Utils.flushBarErrorMessage("email de bhai", context);
                  // } else {
                  //   Map data = {
                  //     "email": _emailController.text.toString(),
                  //     "password": _passwordController.text.toString()
                  //   };
                  //   authviewmodel.apilogin(data, context);
                  //   debugPrint("hit API");
                  // }
                }),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.signupScreen);
                },
                child: const Text("Don't have an account yet? Sign Up!"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
  }
}



//! Recalling Providers
// used for state Management (efficicent)
// valueNotifier (for single value)
//  valueListenerBuilder (which listens to this value)