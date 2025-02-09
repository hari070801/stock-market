import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/resources/app_colors.dart';
import 'package:stock_market_app/resources/functions.dart';
import 'package:stock_market_app/resources/shared_prefs.dart';
import 'package:stock_market_app/resources/widgets.dart';
import 'package:stock_market_app/riverpod/login_notifier.dart';
import 'package:stock_market_app/screens/home/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    loginNotifier.login(email: emailController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginNotifierProvider, (previous, next) {
      print("next : $next");

      if (next is LoginSuccess) {
        saveLoginToken(loginToken: next.token);
        saveLoginState();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else if (next is LoginFailure) {
        Widgets.showFlushBar(
          message: next.message,
          context: context,
          color: appColors.errorFlushBar,
        );
      }
    });

    final loginState = ref.watch(loginNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getWidgetHeight(height: 100)),
            Text(
              'Stock Market App',
              style: TextStyle(
                fontSize: getTextSize(fontSize: 50),
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            SizedBox(height: getWidgetHeight(height: 50)),
            Text(
              'Login',
              style: TextStyle(
                fontSize: getTextSize(fontSize: 40),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Widgets().loginEmailTextField(emailController: emailController),
            Widgets().loginPassWordTextField(emailController: passwordController),
            SizedBox(height: getWidgetHeight(height: 20)),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () async {
                final email = emailController.text.trim();
                final pwd = passwordController.text.trim();

                if (email.isEmpty) {
                  Widgets.showFlushBar(
                    message: 'Please enter email',
                    context: context,
                    color: appColors.errorFlushBar,
                  );
                } else if (pwd.isEmpty) {
                  Widgets.showFlushBar(
                    message: 'Please enter password',
                    context: context,
                    color: appColors.errorFlushBar,
                  );
                } else {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _login();
                }
              },
              child: loginState is LoginLoading
                  ? Container(
                      height: getWidgetHeight(height: getWidgetHeight(height: 44)),
                      width: getWidgetWidth(width: getWidgetWidth(width: 330)),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Widgets().showLoader(color: Colors.white),
                    )
                  : Widgets().commonBtn(
                      name: 'Login',
                      height: 50,
                      width: 357,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
