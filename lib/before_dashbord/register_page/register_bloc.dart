import 'dart:async';

class RegisterBloc {
  final StreamController<bool> _checkEmailValidate = StreamController<bool>();
  StreamController<bool> get checkEmailValidate => _checkEmailValidate;

  final StreamController<bool> _checkPasswordValidate =
      StreamController<bool>();
  StreamController<bool> get checkPasswordValidate => _checkPasswordValidate;

  final StreamController<bool> _checkConfirmPasswordValidate =
      StreamController<bool>();
  StreamController<bool> get checkConfirmPasswordValidate =>
      _checkConfirmPasswordValidate;

  dispose() {
    _checkEmailValidate.close();
  }

  bool checkEmailValidater({String? email}) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email ?? '');
  }

  bool checkPasswordValidater({String? password}) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password ?? '');
  }

  bool checkConfirmPassword({String? password, String? confirmPassword}) {
    if ((password!.isNotEmpty && confirmPassword!.isNotEmpty) &&
        (password == confirmPassword)) {
      return true;
    } else {
    return false;
    }
  }
}
