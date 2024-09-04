import 'package:To3maa/zakat/presentation/router/arguments.dart';
import 'package:To3maa/zakat/presentation/ui/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/home_page_view.dart';

import '../ui/auth/email_check.dart';
import '../ui/auth/sign_in.dart';
import '../ui/auth/sign_up.dart';
import '../ui/auth/verification_code.dart';

class Routes {
  static const String homeRoute = "/home";
  static const String signInRoute = "/signIn";
  static const String signUpRoute = "/signUp";
  static const String emailCheckRoute = "/emailCheck";
  static const String verificationCodeRoute = "/verificationCode";
  static const String resetPasswordRoute = "/resetPassword";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePageView());
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.emailCheckRoute:
        return MaterialPageRoute(builder: (_) => const EmailCheck());
      case Routes.verificationCodeRoute:
        return MaterialPageRoute(
            builder: (_) => VerificationCode(
                arguments: settings.arguments as VerificationCodeArguments));
      case Routes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Container()),
    );
  }
}
