import 'package:NearMii/feature/auth/presentation/views/auth_view.dart';
import 'package:NearMii/feature/auth/presentation/views/complete_profile_view.dart';
import 'package:NearMii/feature/auth/presentation/views/forgot_password_view.dart';
import 'package:NearMii/feature/auth/presentation/views/login_view.dart';
import 'package:NearMii/feature/home/presentation/views/onboard_view.dart';
import 'package:NearMii/feature/auth/presentation/views/reset_password_view.dart';
import 'package:NearMii/feature/auth/presentation/views/select_social_media_view.dart';
import 'package:NearMii/feature/auth/presentation/views/signup_view.dart';
import 'package:NearMii/feature/auth/presentation/views/verity_otp_view.dart';
import 'package:NearMii/feature/splash/presentation/splash_view.dart';
import 'package:flutter/material.dart';
import '../../../feature/home/presentation/views/home_page_view.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print('Current Screen: ${settings.name}');
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePageView());
      case Routes.bottomNavBar:
        return MaterialPageRoute(builder: (_) => BottomNavigationView());

      case Routes.auth:
        return MaterialPageRoute(builder: (_) => const AuthView());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.otpVerify:
        return MaterialPageRoute(builder: (_) => const VerityOtpView());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case Routes.completeProfile:
        return MaterialPageRoute(builder: (_) => const CompleteProfileView());
      case Routes.selectSocialMedia:
        return MaterialPageRoute(builder: (_) => const SelectSocialMediaView());

//SIGN UP
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
