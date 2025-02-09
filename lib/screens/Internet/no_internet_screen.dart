import 'package:flutter/material.dart';
import 'package:stock_market_app/resources/functions.dart';

class NoConnectivityScreen extends StatelessWidget {
  const NoConnectivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'DMSans',
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_off_rounded,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: getWidgetHeight(height: 20)),
              Text(
                'Check your internet connection.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getTextSize(fontSize: 30),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
