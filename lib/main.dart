import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_app/resources/functions.dart';
import 'package:stock_market_app/riverpod/network_check_notifier.dart';
import 'package:stock_market_app/screens/Internet/no_internet_screen.dart';
import 'package:stock_market_app/screens/auth/login_screen.dart';
import 'package:stock_market_app/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  HttpOverrides.global = MyHttpOverrides();

  runApp(ProviderScope(
    child: MyApp(
      sharedPreferences: prefs,
    ),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool isMediaQueryInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isMediaQueryInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final mediaQuery = MediaQuery.of(context);
        if (mediaQuery.size.height > 0) {
          setState(() {
            kHeight = mediaQuery.size.height;
            kWidth = mediaQuery.size.width;
            kTextScale = mediaQuery.textScaler;
            isMediaQueryInitialized = true;
          });
          print("Updated kHeight: $kHeight, kWidth: $kWidth");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final networkCheckState = ref.watch(networkCheckProvider);

    print("networkCheckState: $networkCheckState");

    if (networkCheckState == NetworkStatus.disconnected) {
      return const NoConnectivityScreen();
    }

    bool isLoggedIn = widget.sharedPreferences.getBool('isLoggedIn') ?? false;
    print("isLoggedIn : $isLoggedIn");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'DMSans',
      ),
      builder: (context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        double scale = (data.devicePixelRatio < 3.0) ? 0.93 : 0.95;

        print("data.size.height (builder): ${data.size.height}");

        if (data.size.height <= 568.0) {
          scale = 0.75;
        } else if (data.size.height <= 667.0) {
          scale = 0.78;
        }

        return MediaQuery(
          data: data.copyWith(
            textScaler: TextScaler.linear(scale),
          ),
          child: child!,
        );
      },
      home: isMediaQueryInitialized
          ? (isLoggedIn ? const HomeScreen() : const LoginScreen())
          : const Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator()),
            ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
