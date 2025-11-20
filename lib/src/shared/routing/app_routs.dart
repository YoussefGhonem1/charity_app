import 'package:charity/src/features/add_donate/add_donate.dart';
import 'package:charity/src/features/create_account/screens/create_account.dart';
import 'package:charity/src/features/donation_page/screen/foundation_page.dart';
import 'package:charity/src/features/favourite/favourite.dart';
import 'package:charity/src/features/favourite/cubits/favourite_cubit.dart';
import 'package:charity/src/features/donation_page/screen/donation_page.dart';
import 'package:charity/src/features/forget_password/screens/forget_password_page.dart';
import 'package:charity/src/features/home/models/campaign_model.dart';
import 'package:charity/src/features/home/models/foundation_model.dart';
import 'package:charity/src/features/home/screen/home_screen.dart';
import 'package:charity/src/features/layout/screens/layout_screen.dart';
import 'package:charity/src/features/on_boarding/screens/on_boarding_page.dart';
import 'package:charity/src/features/payment/screens/add_card_page.dart';
import 'package:charity/src/features/payment/screens/donate_page.dart';
import 'package:charity/src/features/payment/screens/enter_pin_page.dart';
import 'package:charity/src/features/payment/screens/payment_page.dart';
import 'package:charity/src/features/payment/screens/success_page.dart';
import 'package:charity/src/features/profile_management/profile_management_screen.dart';
import 'package:charity/src/features/splash/screens/splash_page.dart';
import 'package:charity/src/features/zakat_calculator/screens/zakat_calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/features/forget_password/screens/reset_password_sent_page.dart';
import '../../features/category_details/category_details.dart';
import '../../features/sigin_in_email/screens/signin_email.dart';
import '../../features/sign_in_password/screens/sign_in_password_screen.dart';
import 'package:charity/src/features/profile_management/transactions_screen.dart';
import 'package:charity/src/features/profile_management/edit_profile_screen.dart';
import 'package:charity/src/features/profile_management/invite_friends_screen.dart';
import 'package:charity/src/features/profile_management/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/src/features/profile_management/cubits/settings_cubit.dart';
import 'package:charity/src/features/profile_management/cubits/transactions_cubit.dart';


class Routes {
  static const String initial = '/';
  static const String onBoarding = '/on_boarding';
  static const String signInPassword = '/sign_in_password';
  static const String createAcount = '/create_account';
  static const String forgetPassword = '/forget_password';
  static const String forgetConfirmation = '/forget_confirmation';
  static const String signInEmail = '/sign_in_email';
  static const String donate = '/donate';
  static const String payment = '/payment';
  static const String addCard = '/add_card';
  static const String enterPin = '/enter_pin';
  static const String success = '/success';
  static const String favourite = '/favourite';
  static const String donationPage = '/donation_page';
  static const String homePage = '/home_page';
  static const String layout = '/layout';
  static const String transactions = '/transactions';
  static const String editProfile = '/edit-profile';
  static const String inviteFriends = '/invite';
  static const String settings = '/settings';
  static const String zakatCalculator = '/zakat_calculator';
  static const String add_donate = '/add_donate';
  static const String prof_manage = '/prof_manage';
  static const String foundationPage = "/foundation_page";
  static const String categoryDetails = '/category_details';
}

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());

      case Routes.signInPassword:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => SignInPasswordScreen(email: email),
        );
      case Routes.createAcount:
        return MaterialPageRoute(builder: (_) => CreateAccountPage());

      case Routes.donationPage:
        final campaign = settings.arguments as CampaignModel;
        return MaterialPageRoute(
          builder: (_) => DonationPage(campaign: campaign),
        );

      case Routes.layout:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());

      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());

      case Routes.forgetConfirmation:
        return MaterialPageRoute(builder: (_) => ResetPasswordSentScreen());

      case Routes.donate:
        final campaign = settings.arguments as CampaignModel;
        return MaterialPageRoute(builder: (_) => DonatePage(campaign: campaign));

      case Routes.payment:
        final args = settings.arguments as Map<String, dynamic>;
        final campaign = args['campaign'] as CampaignModel;
        final amount = args['amount'] as double;
        return MaterialPageRoute(builder: (_) => PaymentPage(campaign: campaign, amount: amount));

      case Routes.enterPin:
        final args = settings.arguments as Map<String, dynamic>;
        final campaign = args['campaign'] as CampaignModel;
        final amount = args['amount'] as double;
        return MaterialPageRoute(builder: (_) => EnterPinPage(campaign: campaign, amount: amount));

      case Routes.success:
        final args = settings.arguments as Map<String, dynamic>;
        final campaign = args['campaign'] as CampaignModel;
        final amount = args['amount'] as double;
        return MaterialPageRoute(builder: (_) => SuccessPage(campaign: campaign, amount: amount));

      case Routes.addCard:
        return MaterialPageRoute(builder: (_) => AddNewCardPage());

      case Routes.signInEmail:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case Routes.favourite:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => FavouriteCubit()..loadFavourites(),
            child: const FavouriteScreen(),
          ),
        );

      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case Routes.transactions:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => TransactionsCubit()..fetch(),
            child: const TransactionsScreen(),
          ),
        );

      case Routes.prof_manage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SettingsCubit()..load(),
            child: const ProfileManagementScreen(),
          ),
        );

      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      case Routes.inviteFriends:
        return MaterialPageRoute(builder: (_) => const InviteFriendsScreen());

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SettingsCubit()..load(),
            child: const SettingsScreen(),
          ),
        );

      case Routes.zakatCalculator:
        return MaterialPageRoute(builder: (_) => const ZakatCalculatorPage());

      case Routes.add_donate:
        return MaterialPageRoute(builder: (_) => DonationScreen());

      case Routes.foundationPage:
        final foundation = settings.arguments as FoundationModel;
        return MaterialPageRoute(
          builder: (_) => FoundationPage(foundation: foundation),
        );


      case Routes.categoryDetails:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CategoryDetailsScreen(categoryName: categoryName),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
        );
    }
  }
}