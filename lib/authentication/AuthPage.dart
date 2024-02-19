import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/authentication/signup.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) => isLogin
      ? signup(onClickedSignIn: toggle)
      : login(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
