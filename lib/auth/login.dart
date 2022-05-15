import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/models/auth_model.dart';
import 'package:page_transition/page_transition.dart';

import '../bottomNav.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  bool _hideOrShowPassword = true;
  bool _isLoggedInClicked = false;

  void _toggleVisibility() {
    setState(() {
      _hideOrShowPassword = !_hideOrShowPassword;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String email = '';
  String password = '';

  Future<LoginResponseModel> _login(LoginRequestModel loginRequest) async {
    const url = 'https://reqres.in/api/login';

    try {
      final response = await Dio().post(url, data: loginRequest);
      if (kDebugMode) print(response.data);

      return LoginResponseModel.fromJson(response.data);
    } on DioError {
      throw Exception('Failed to login!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Colors.purple,
              Colors.white,
              Color(0xFFE2E5FF),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 50),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          _loginText(),
                          _emailField(),
                          _passwordField(),
                          _forgotPassword(),
                          const SizedBox(height: 20),
                          _loginButton(),
                          const SizedBox(height: 40),
                          _signUpButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginText() {
    return Container(
      // color: Colors.red,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 25),
      child: const Text(
        'Sign In',
        style: TextStyle(
            fontSize: 25,
            color: Colors.black87,
            letterSpacing: 2,
            fontFamily: "Lobster"),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.blue,
        //     blurRadius: 5,
        //     offset: Offset(1, 1),
        //   ),
        // ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Icon(Icons.verified_user),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {
                  email = value.trim();
                }),
                // validator: (value) => value!.length < 3 ? 'Empty fields...' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.blue,
        //     blurRadius: 10,
        //     offset: Offset(1, 1),
        //   ),
        // ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hideOrShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Colors.grey,
                    ),
                  ),
                  label: const Text('Password'),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {
                  password = value.trim();
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (!validateAndSave()) {
              return;
            }

            if (kDebugMode) {
              print(
                LoginRequestModel(email: email, password: password).toJson(),
              );
            }

            if (email.isEmpty || password.isEmpty) {
              _showToast('Empty fields detected..', ToastGravity.BOTTOM);
              return;
            }

            setState(() => _isLoggedInClicked = true);

            _login(LoginRequestModel(email: email, password: password))
                .then((value) => {
                      if (value.token.isNotEmpty)
                        {
                          _isLoggedInClicked = false,
                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              child: const BottomNav(),
                              type: PageTransitionType.fade,
                            ),
                          )
                        }
                    })
                .catchError((error) {
              _showDialog(context);
              setState(() => _isLoggedInClicked = false);
            });
          },
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.blue,
            shadowColor: Colors.blue,
            elevation: 3,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blue], // Set gradient colors here
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 200,
              height: 50,
              alignment: Alignment.center,
              child: _isLoggedInClicked
                  ? _spinnar()
                  : const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(width: 30.0),
        ElevatedButton(
          onPressed: () {},
          onLongPress: () =>
              _showToast('Not yet implemented!', ToastGravity.BOTTOM),
          style: ElevatedButton.styleFrom(
            elevation: 3,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blue], // Set gradient colors here
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: const Icon(Icons.fingerprint, size: 40),
            ),
          ),
        ),
      ],
    );
  }

  Widget _spinnar() {
    return const SpinKitSpinningLines(
      color: Colors.white,
      size: 40.0,
    );
  }

  void _showToast(String msg, ToastGravity toastGravity) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget _okay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE2E5FF),
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: const Color(0xFFE2E5FF),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Okay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ScaleAnimatedWidget.tween(
        enabled: true,
        duration: const Duration(milliseconds: 200),
        scaleDisabled: 0.5,
        scaleEnabled: 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Error',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'If you are trying to login with a real email and password, be aware that this is a dummy authentication... Therefore it will NOT work!\nPlease find the dedicated login credentials in the READ_ME file of the source code, OR directly in the email sent to you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 20),
                  _okay(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () =>
            _showToast('Not yet implemented!', ToastGravity.BOTTOM),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20.0),
          child: const Text(
            'Don\'t have an existing account?',
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: const Signup(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    );
  }
}
