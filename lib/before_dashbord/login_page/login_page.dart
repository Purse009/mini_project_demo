import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samawat_health/before_dashbord/register_page/register_page.dart';
import 'package:samawat_health/dashbord/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: ScreenUtil().setHeight(150),
                      width: ScreenUtil().setWidth(150),
                      decoration: BoxDecoration(border: Border.all()),
                      child: const Center(child: Text('Logo')),
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
                  _loginButton(),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  _registerButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextFiled() {
    return TextFormField(
      controller: _emailController,
      validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
      decoration: const InputDecoration(labelText: 'E-mail'),
    );
  }

  Widget _passwordTextFiled() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _passwordVisible,
      validator: (value) => value!.isEmpty ? 'Password cannot be blank' : null,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon:
              Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 40)),
      onPressed: _checkValidate,
      child: const Text("Login"),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40)),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            ),
        child: const Text('Register'));
  }

  _checkValidate() {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }
}
