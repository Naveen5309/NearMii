import 'package:NearMii/feature/auth/presentation/views/auth_view.dart';
import 'package:NearMii/feature/auth/presentation/views/complete_profile_view.dart';
import 'package:NearMii/feature/auth/presentation/views/forgot_password_view.dart';
import 'package:NearMii/feature/auth/presentation/views/login_view.dart';
import 'package:NearMii/feature/auth/presentation/views/onboard_view.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/change_password_view.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/complete_edit_profile.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/contact_us_view.dart';
import 'package:NearMii/feature/setting/presentation/view/deleted_detail_view.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/profile_screen.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/radius_view.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/terms_condition_view.dart';
import 'package:NearMii/feature/home/presentation/views/bottom_navigation_view.dart';
import 'package:NearMii/feature/auth/presentation/views/reset_password_view.dart';
import 'package:NearMii/feature/auth/presentation/views/select_social_media_view.dart';
import 'package:NearMii/feature/auth/presentation/views/signup_view.dart';
import 'package:NearMii/feature/auth/presentation/views/verity_otp_view.dart';
import 'package:NearMii/feature/other_user_profile/presentation/view/other_user_profile_view.dart';
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

      case Routes.onboard:
        final args = settings.arguments as bool;

        return MaterialPageRoute(
            builder: (_) => OnboardingView(
                  isFromSetting: args,
                ));

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
        final args = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) => SelectSocialMediaView(
            isFromProfile: args,
          ),
        );
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const MyProfileView());

      case Routes.otherUserProfile:
        final args = settings.arguments as dynamic;

        return MaterialPageRoute(
            builder: (_) => OtherUserProfileView(
                  id: args,
                  somethingElse: args,
                  reportedUserId: '',
                ));
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => const CompleteEditProfile());
      case Routes.setRadius:
        return MaterialPageRoute(builder: (_) => const RadiusScreen());
      case Routes.termsAndConditions:
        return MaterialPageRoute(builder: (_) => const TermsConditionView());
      case Routes.contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsView());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordView());
      case Routes.deleteAccount:
        return MaterialPageRoute(builder: (_) => const DeletedDetailView());
      // case Routes.share:
      //   return MaterialPageRoute(builder: (_) => ShareViewScreen());

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
