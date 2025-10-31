// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Charity App';

  @override
  String hello(Object userName) {
    return 'Hello, $userName';
  }

  @override
  String donated(Object amount) {
    return 'Donated $amount';
  }

  @override
  String get donationWallet => 'Donation wallet';

  @override
  String get topUp => 'Top up';

  @override
  String get transactions => 'Transactions';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get donateAsAnonymous => 'Donate as anonymous';

  @override
  String get inviteFriends => 'Invite friends';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get aboutApp => 'About app';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get preferences => 'Preferences';

  @override
  String get notifications => 'Notifications';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get language => 'Language';

  @override
  String get logOutDialogTitle => 'Log out';

  @override
  String get logOutDialogMessage => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get fullName => 'Full name';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get home => 'Home';

  @override
  String get favourite => 'Favourite';

  @override
  String get categories => 'Categories';

  @override
  String get account => 'Account';

  @override
  String get loggedOutSuccessfully => 'Logged out successfully';

  @override
  String get featureCampaign => 'Feature Campaign';

  @override
  String get latestCampaign => 'Latest Campaign';

  @override
  String get locations => 'Locations';

  @override
  String get seeAll => 'See all';

  @override
  String get allCategories => 'All Categories';

  @override
  String get allLocations => 'All Locations';

  @override
  String get helloNoName => 'Hello';

  @override
  String get dangerZone => 'Danger zone';

  @override
  String get about => 'About';

  @override
  String get enabled => 'enabled';

  @override
  String get disabled => 'disabled';

  @override
  String get openPrivacyPolicy => 'Open privacy policy';

  @override
  String get loggedOut => 'Logged out';

  @override
  String languageSetTo(Object language) {
    return 'Language set to $language';
  }
}
