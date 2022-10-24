import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samawat_health/before_dashbord/register_page/register_bloc.dart';
import 'package:samawat_health/dashbord/home/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerBloc = RegisterBloc();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = true;
  bool _confirmPasswordVidible = true;
  bool _isCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Center(
                  child: Text(
                    'Create User ID',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(100),
                ),
                _emailTextFiled(),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                _passwordTextFiled(),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                _confirmPasswordTextFiled(),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                _checkboxCondition(),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextFiled() {
    return StreamBuilder(
        stream: _registerBloc.checkEmailValidate.stream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          String? error;
          if (snapshot.data != null && !snapshot.data!) {
            error = 'Invalid email please check your e-mail';
          }
          return TextFormField(
            controller: _emailController,
            decoration: InputDecoration(errorText: error, labelText: 'E-mail'),
          );
        });
  }

  Widget _passwordTextFiled() {
    return StreamBuilder(
        stream: _registerBloc.checkPasswordValidate.stream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          String? error;
          if (snapshot.data != null && !snapshot.data!) {
            error = 'Password must have A a 1 ! and more than 8';
          }
          return TextFormField(
            controller: _passwordController,
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              errorText: error,
              labelText: 'Password',
              hintText: 'Enter your Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          );
        });
  }

  Widget _confirmPasswordTextFiled() {
    return StreamBuilder(
        stream: _registerBloc.checkConfirmPasswordValidate.stream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          String? error;
          if (snapshot.data != null && !snapshot.data!) {
            error = 'Password Not Match';
          }
          return TextFormField(
            controller: _confirmPasswordController,
            obscureText: _confirmPasswordVidible,
            decoration: InputDecoration(
              errorText: error,
              labelText: 'Confirm Password',
              hintText: 'Confirm your Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _confirmPasswordVidible = !_confirmPasswordVidible;
                  });
                },
                icon: Icon(_confirmPasswordVidible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
          );
        });
  }

  Widget _checkboxCondition() {
    return Row(
      children: [
        Checkbox(
            value: _isCheckbox,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _isCheckbox = value;
                });
              }
            }),
        SizedBox(
          width: ScreenUtil().setWidth(20),
        ),
        const Expanded(child: Text('I accept the terms and conditions of use.'))
      ],
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: () {
        if (_emailController.text.isNotEmpty &&
            (_registerBloc.checkEmailValidater(email: _emailController.text)) &&
            (_registerBloc.checkPasswordValidater(
                password: _confirmPasswordController.text)) &&
            (_registerBloc.checkConfirmPassword(
                password: _confirmPasswordController.text,
                confirmPassword: _confirmPasswordController.text))) {
          if (!_isCheckbox) {
            Fluttertoast.showToast(
              msg: 'Please accept the terms and conditions of use.',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 5,
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        } else {
          _registerBloc.checkEmailValidate.sink.add(
              _registerBloc.checkEmailValidater(email: _emailController.text));
          _registerBloc.checkPasswordValidate.sink.add(_registerBloc
              .checkPasswordValidater(password: _passwordController.text));
          _registerBloc.checkConfirmPasswordValidate.sink.add(
              _registerBloc.checkConfirmPassword(
                  password: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text));
        }
      },
      child: const Text("Register"),
    );
  }
}
