import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/resources/app_colors.dart';
import 'package:stock_market_app/resources/functions.dart';

class Widgets {
  loginEmailTextField({required TextEditingController emailController}) {
    return Padding(
      padding: EdgeInsets.only(
        top: getWidgetHeight(height: 30),
      ),
      child: TextFormField(
        controller: emailController,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: getTextSize(fontSize: 20),
          color: appColors.fontColor,
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'Email',
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: getTextSize(fontSize: 20),
            color: appColors.darkGrey,
          ),
          counterText: '',
          prefixIconConstraints: BoxConstraints(
            maxHeight: getWidgetHeight(height: 50),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: getWidgetWidth(width: 15)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget loginPassWordTextField({required TextEditingController passwordController}) {
    ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);

    return Padding(
      padding: EdgeInsets.only(
        top: getWidgetHeight(height: 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: isObscure,
            builder: (context, obscure, child) {
              return TextFormField(
                controller: passwordController,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: getTextSize(fontSize: 20),
                  color: appColors.fontColor,
                ),
                keyboardType: TextInputType.text,
                obscureText: obscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: getTextSize(fontSize: 20),
                    color: appColors.darkGrey,
                  ),
                  counterText: '',
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: getWidgetHeight(height: 50),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: getWidgetWidth(width: 15)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: appColors.darkGrey,
                      size: 22,
                    ),
                    onPressed: () {
                      isObscure.value = !isObscure.value;
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget commonBtn({
    required String name,
    required double height,
    required double width,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return Container(
      height: getWidgetHeight(height: height),
      width: getWidgetWidth(width: width),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(62)),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: getTextSize(fontSize: fontSize),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget showLoader({required Color? color}) {
    if (Platform.isIOS) {
      return Center(
        child: CupertinoActivityIndicator(
          color: color,
        ),
      );
    } else {
      return Center(
        child: SizedBox(
          height: getWidgetHeight(height: 25),
          width: getWidgetWidth(width: 25),
          child: CircularProgressIndicator(
            color: color,
            strokeCap: StrokeCap.round,
            strokeWidth: 2,
          ),
        ),
      );
    }
  }

  static void showFlushBar({required String message, required BuildContext context, Color? color}) async {
    Flushbar(
      message: message,
      backgroundGradient: LinearGradient(
        colors: [
          (color ?? appColors.primaryFlushBar).withOpacity(0.9),
          (color ?? appColors.primaryFlushBar).withOpacity(0.9),
          (color ?? appColors.primaryFlushBar).withOpacity(0.4),
        ],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ),
      messageColor: Colors.white,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  Widget assetImage({
    required String asset,
    required double height,
    required double width,
    BoxFit? boxFit,
    Color? color,
  }) {
    return Image.asset(
      asset,
      height: getWidgetHeight(height: height),
      width: getWidgetWidth(width: width),
      fit: boxFit,
      color: color,
    );
  }

  Widget networkImage({
    required String url,
    required double height,
    required double width,
    BoxFit? boxFit,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      height: getWidgetHeight(height: height),
      width: getWidgetWidth(width: width),
      fit: boxFit,
      placeholder: (context, url) => Center(
        child: showLoader(color: Colors.black),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Widgets().assetImage(
            asset: 'assets/images/app-icon.png',
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}
