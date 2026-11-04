import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/verification_hp_page.dart';
import 'pages/verification_email_page.dart';
import 'pages/forgot_password_email_page.dart';
import 'pages/forgot_password_hp_page.dart';
import 'pages/reset_password_page.dart';
import 'pages/profile_page.dart';
import 'pages/edit_profile_page.dart';
import 'pages/cameraProfile_page.dart';
import 'pages/settings_page.dart';
import 'pages/change_phone_page.dart';
import 'pages/change_email_page.dart';
import 'pages/change_password_page.dart';
import 'pages/terms_service_page.dart';
import 'pages/privacy_policy_page.dart';
import 'pages/about_us_page.dart';
import 'pages/home.dart';
import 'pages/dufan_detail_page.dart';
import 'pages/write_review_page.dart';
import 'pages/reviews_page.dart';
import 'pages/category_page.dart';
import 'pages/weather_page.dart';
import 'pages/notification_page.dart';
import 'pages/trip_summary_page.dart';
import 'pages/recently_viewed_page.dart';
import 'pages/viewed_detail_page.dart';
import 'pages/recommendation_page.dart';
import 'pages/route_recommendation_page.dart';
import 'pages/ojek_online_page.dart';
import 'pages/train_page.dart';
import 'pages/transjakarta_page.dart';
import 'pages/departure_page.dart';
import 'pages/taksi_page.dart';
import 'pages/lrt_page.dart';
import 'pages/mobil_page.dart';
import 'pages/mrt_page.dart';
import 'pages/detail_train_page.dart';
import 'pages/jaklingko_page.dart';
import 'pages/detail_ojol_page.dart';
import 'pages/motor_pribadi_page.dart';
import 'pages/departure_mikrotrans_page.dart';
import 'pages/departure_lrt_page.dart';
import 'pages/departure_krl_page.dart';
import 'pages/departure_mrt_page.dart';
import 'pages/departure_ojol_page.dart';
import 'pages/departure_taksi_page.dart';

void main() {
  runApp(const EcoWalkApp());
}

class EcoWalkApp extends StatelessWidget {
  const EcoWalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoWalk',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: ecoGreen),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/verification-hp': (context) => const VerificationHpPage(),
        '/verification-email': (context) => const VerificationEmailPage(),
        '/forgot-password-email': (context) => const ForgotPasswordEmailPage(),
        '/forgot-password-hp': (context) => const ForgotPasswordHpPage(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/profile': (context) => const ProfilePage(),
        '/edit_profile': (context) => const EditProfilePage(),
        '/camera-profile': (context) => const CameraProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/change-phone': (context) => const ChangePhonePage(),
        '/change-email': (context) => const ChangeEmailPage(),
        '/change-password': (context) => const ChangePasswordPage(),
        '/terms-service': (context) => const TermsServicePage(),
        '/privacy-policy': (context) => const PrivacyPolicyPage(),
        '/about-us': (context) => const AboutUsPage(),
        '/home': (context) => const HomeScreen(),
        '/dufan-detail': (context) => const DufanDetailPage(),
        '/write-review': (context) => const WriteReviewPage(),
        '/reviews': (context) => const ReviewsPage(),
        '/category': (context) => const CategoryPage(),
        '/weather': (context) => const WeatherPage(),
        '/notifications': (context) => const NotificationPage(),
        '/trip-summary': (context) => const TripSummaryPage(),
        '/recently-viewed': (context) => const RecentlyViewedPage(),
        '/viewed-detail': (context) => const ViewedDetailPage(),
        '/recommendation': (context) => const RecommendationPage(),
        '/route-recommendation': (context) => const RouteRecommendationPage(),
        '/ojek-online': (context) => const OjekOnlinePage(),
        '/departure-ojol': (context) => const DepartureOjolPage(),
        '/train': (context) => const TrainPage(),
        '/departure-krl': (context) => const DepartureKrlPage(),
        '/transjakarta': (context) => const TransjakartaPage(),
        '/departure': (context) => const DeparturePage(),
        '/taksi': (context) => const TaksiPage(),
        '/departure-taksi': (context) => const DepartureTaksiPage(),
        '/lrt': (context) => const LrtPage(),
        '/departure-lrt': (context) => const DepartureLrtPage(),
        '/mrt': (context) => const MrtPage(),
        '/detail-train': (context) => const DetailTrainPage(),
        '/jaklingko': (context) => const JaklingkoPage(),
        '/departure-mikrotrans': (context) => const DepartureMikrotransPage(),
        '/detail-ojol': (context) => const DetailOjolPage(),
        '/motor-pribadi': (context) => const MotorPribadiPage(),
        '/departure-mrt': (context) => const DepartureMrtPage(),
        '/mobil-pribadi': (context) => const MobilPage(),
      },
    );
  }
}
