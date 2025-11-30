import 'package:flutter/material.dart';

class AppTranslations {
  final Locale locale;

  AppTranslations(this.locale);

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations)!;
  }

  static const LocalizationsDelegate<AppTranslations> delegate =
      _AppTranslationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Common
      'app_name': 'Charity App',
      
      // Navigation tabs
      'home': 'Home',
      'favourite': 'Favourite',
      'zakat': 'Zakat',
      'account': 'Account',
      
      // Profile Management
      'hello': 'Hello',
      'donated': 'Donated',
      'donation_wallet': 'Donation wallet',
      'top_up': 'Top up',
      'top_up_coming_soon': 'Top up coming soon',
      'transactions': 'Transactions',
      'zakat_calculator': 'Zakat calculator',
      'add_campaign': 'Add campaign',
      'edit_profile': 'Edit Profile',
      'donate_as_anonymous': 'Donate as anonymous',
      'invite_friends': 'Invite friends',
      'settings': 'Settings',
      'logout': 'Logout',
      'logged_out_successfully': 'Logged out successfully',
      'logout_failed': 'Logout failed',
      
      // Settings
      'preferences': 'Preferences',
      'notifications': 'Notifications',
      'notifications_enabled': 'Notifications enabled',
      'notifications_disabled': 'Notifications disabled',
      'dark_mode': 'Dark mode',
      'dark_mode_enabled': 'Dark mode enabled',
      'dark_mode_disabled': 'Dark mode disabled',
      'language': 'Language',
      'language_set_to': 'Language set to',
      'english': 'English',
      'arabic': 'Arabic',
      'about': 'About',
      'about_app': 'About app',
      'privacy_policy': 'Privacy policy',
      'open_privacy_policy': 'Open privacy policy',
      'danger_zone': 'Danger zone',
      'log_out': 'Log out',
      'are_you_sure_logout': 'Are you sure you want to log out?',
      'cancel': 'Cancel',
      'knowledge_hub': 'Knowledge Hub',
      'zakat_guidelines': 'Zakat Guidelines',
      'success_stories': 'Success Stories',
      'faq_title': 'Frequently Asked Questions',

      // Home Screen
      'feature_campaigns': 'Feature Campaigns',
      'foundations': 'Foundations',
      'latest_campaigns': 'Latest Campaigns',
      'see_all': 'See All',
      'show_less': 'Show Less',
      'error': 'Error',
      
      // Edit Profile
      'save': 'Save',
      'full_name': 'Full name',
      'email': 'Email',
      'phone_number': 'Phone number',
      'name_is_required': 'Name is required',
      'enter_at_least_3_characters': 'Enter at least 3 characters',
      'email_is_required': 'Email is required',
      'enter_a_valid_email': 'Enter a valid email',
      'phone_is_required': 'Phone is required',
      'enter_a_valid_phone_number': 'Enter a valid phone number',
      'save_changes': 'Save changes',
      'profile_updated_successfully': 'Profile updated successfully',
      'select_photo': 'Select Photo',
      'change_photo': 'Change Photo',
      
      // Transactions
      'total_donated': 'Total donated',
      
      // Invite Friends
      'invite_friends_title': 'Invite Friends',
      'share_your_referral_link': 'Share your referral link',
      'invite_friends_description': 'Invite friends and help more people. Share your unique link below.',
      'your_code': 'Your code',
      'referral_link': 'Referral link',
      'copy_link': 'Copy link',
      'copy_and_share_later': 'Copy and share later',
      'referral_link_copied': 'Referral link copied to clipboard',
      'share': 'Share',
      
      // Zakat Calculator
      'zakat_calculator_title': 'Zakat Calculator',
      'enter_your_assets': 'Enter your assets',
      'calculate': 'Calculate',
      'zakat_amount': 'Zakat Amount',
      
      // Payment & Donation
      'donate': 'Donate',
      'payment': 'Payment',
      'add_card': 'Add Card',
      'enter_pin': 'Enter PIN',
      'success': 'Success',
      'donation_amount': 'Donation Amount',
      'enter_amount': 'Enter amount',
      
      // Sign In/Up
      'sign_in': 'Sign In',
      'sign_up': 'Sign Up',
      'forgot_password': 'Forgot Password',
      'reset_password': 'Reset Password',
      'password_reset_sent': 'Password reset sent',
      'create_account': 'Create Account',
      'email_address': 'Email Address',
      'please_enter_email': 'Please enter your email',
      'dont_have_account': 'Dont have an Account ? ',
      'create_one': 'Create One',
      'continue_with_apple': 'Continue With Apple',
      'continue_with_google': 'Continue With Google',
      'continue_with_facebook': 'Continue With Facebook',
      'password': 'Password',
      
      // General
      'loading': 'Loading...',
      'error_occurred': 'An error occurred',
      'try_again': 'Try Again',
      'no_data': 'No data available',
      'no_favourites': 'No favorites yet',
      'by': 'By',
      'raised': 'Raised',
      '404_page_not_found': '404 - Page Not Found',
    },
    'ar': {
      // Common
      'app_name': 'تطبيق الخير',
      
      // Navigation tabs
      'home': 'الرئيسية',
      'favourite': 'المفضلة',
      'zakat': 'الزكاة',
      'account': 'الحساب',
      
      // Profile Management
      'hello': 'مرحبا',
      'donated': 'تبرعت بـ',
      'donation_wallet': 'محفظة التبرعات',
      'top_up': 'شحن',
      'top_up_coming_soon': 'الشحن قريباً',
      'transactions': 'المعاملات',
      'zakat_calculator': 'حاسبة الزكاة',
      'add_campaign': 'إضافة حملة',
      'edit_profile': 'تعديل الملف الشخصي',
      'donate_as_anonymous': 'تبرع كشخص مجهول',
      'invite_friends': 'دعوة الأصدقاء',
      'settings': 'الإعدادات',
      'logout': 'تسجيل الخروج',
      'logged_out_successfully': 'تم تسجيل الخروج بنجاح',
      'logout_failed': 'فشل تسجيل الخروج',
      
      // Settings
      'preferences': 'التفضيلات',
      'notifications': 'الإشعارات',
      'notifications_enabled': 'تم تفعيل الإشعارات',
      'notifications_disabled': 'تم إلغاء تفعيل الإشعارات',
      'dark_mode': 'الوضع الليلي',
      'dark_mode_enabled': 'تم تفعيل الوضع الليلي',
      'dark_mode_disabled': 'تم إلغاء تفعيل الوضع الليلي',
      'language': 'اللغة',
      'language_set_to': 'تم تعيين اللغة إلى',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'about': 'حول',
      'about_app': 'حول التطبيق',
      'privacy_policy': 'سياسة الخصوصية',
      'open_privacy_policy': 'فتح سياسة الخصوصية',
      'danger_zone': 'منطقة الخطر',
      'log_out': 'تسجيل الخروج',
      'are_you_sure_logout': 'هل أنت متأكد من تسجيل الخروج؟',
      'cancel': 'إلغاء',
      'knowledge_hub': 'مركز المعرفة الخيري',
      'zakat_guidelines': 'دليل الزكاة الشامل',
      'success_stories': 'قصص نجاح مُلهمة',
      'faq_title': 'الأسئلة الشائعة',
      
      // Home Screen
      'feature_campaigns': 'حملات مميزة',
      'foundations': 'الجمعيات',
      'latest_campaigns': 'أحدث الحملات',
      'see_all': 'عرض الكل',
      'show_less': 'عرض أقل',
      'error': 'خطأ',
      
      // Edit Profile
      'save': 'حفظ',
      'full_name': 'الاسم الكامل',
      'email': 'البريد الإلكتروني',
      'phone_number': 'رقم الهاتف',
      'name_is_required': 'الاسم مطلوب',
      'enter_at_least_3_characters': 'أدخل على الأقل 3 أحرف',
      'email_is_required': 'البريد الإلكتروني مطلوب',
      'enter_a_valid_email': 'أدخل بريد إلكتروني صحيح',
      'phone_is_required': 'رقم الهاتف مطلوب',
      'enter_a_valid_phone_number': 'أدخل رقم هاتف صحيح',
      'save_changes': 'حفظ التغييرات',
      'profile_updated_successfully': 'تم تحديث الملف الشخصي بنجاح',
      'select_photo': 'اختر صورة',
      'change_photo': 'تغيير الصورة',
      
      // Transactions
      'total_donated': 'إجمالي التبرعات',
      
      // Invite Friends
      'invite_friends_title': 'دعوة الأصدقاء',
      'share_your_referral_link': 'شارك رابط الإحالة الخاص بك',
      'invite_friends_description': 'ادعُ الأصدقاء وساعد المزيد من الناس. شارك رابطك الفريد أدناه.',
      'your_code': 'رمزك',
      'referral_link': 'رابط الإحالة',
      'copy_link': 'نسخ الرابط',
      'copy_and_share_later': 'نسخ ومشاركة لاحقاً',
      'referral_link_copied': 'تم نسخ رابط الإحالة إلى الحافظة',
      'share': 'مشاركة',
      
      // Zakat Calculator
      'zakat_calculator_title': 'حاسبة الزكاة',
      'enter_your_assets': 'أدخل أصولك',
      'calculate': 'احسب',
      'zakat_amount': 'مبلغ الزكاة',
      
      // Payment & Donation
      'donate': 'تبرع',
      'payment': 'الدفع',
      'add_card': 'إضافة بطاقة',
      'enter_pin': 'أدخل رمز PIN',
      'success': 'نجح',
      'donation_amount': 'مبلغ التبرع',
      'enter_amount': 'أدخل المبلغ',
      
      // Sign In/Up
      'sign_in': 'تسجيل الدخول',
      'sign_up': 'إنشاء حساب',
      'forgot_password': 'نسيت كلمة المرور',
      'reset_password': 'إعادة تعيين كلمة المرور',
      'password_reset_sent': 'تم إرسال إعادة تعيين كلمة المرور',
      'create_account': 'إنشاء حساب',
      
      // General
      'loading': 'جاري التحميل...',
      'error_occurred': 'حدث خطأ',
      'try_again': 'حاول مرة أخرى',
      'no_data': 'لا توجد بيانات متاحة',
      'no_favourites': 'لا توجد مفضلات بعد',
      'by': 'بواسطة',
      'raised': 'تم جمع',
      '404_page_not_found': '404 - الصفحة غير موجودة',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String get appName => translate('app_name');
  String get home => translate('home');
  String get favourite => translate('favourite');
  String get zakat => translate('zakat');
  String get account => translate('account');
  String get hello => translate('hello');
  String get donated => translate('donated');
  String get donationWallet => translate('donation_wallet');
  String get topUp => translate('top_up');
  String get topUpComingSoon => translate('top_up_coming_soon');
  String get transactions => translate('transactions');
  String get zakatCalculator => translate('zakat_calculator');
  String get addCampaign => translate('add_campaign');
  String get editProfile => translate('edit_profile');
  String get donateAsAnonymous => translate('donate_as_anonymous');
  String get inviteFriends => translate('invite_friends');
  String get settings => translate('settings');
  String get logout => translate('logout');
  String get loggedOutSuccessfully => translate('logged_out_successfully');
  String get logoutFailed => translate('logout_failed');
  String get preferences => translate('preferences');
  String get notifications => translate('notifications');
  String get darkMode => translate('dark_mode');
  String get language => translate('language');
  String get english => translate('english');
  String get arabic => translate('arabic');
  String get about => translate('about');
  String get aboutApp => translate('about_app');
  String get privacyPolicy => translate('privacy_policy');
  String get openPrivacyPolicy => translate('open_privacy_policy');
  String get dangerZone => translate('danger_zone');
  String get logOut => translate('log_out');
  String get areYouSureLogout => translate('are_you_sure_logout');
  String get cancel => translate('cancel');
  String get foundations => translate('foundations');
  String get featureCampaigns => translate('feature_campaigns');
  String get latestCampaigns => translate('latest_campaigns');
  String get seeAll => translate('see_all');
  String get showLess => translate('show_less');
  String get save => translate('save');
  String get fullName => translate('full_name');
  String get email => translate('email');
  String get phoneNumber => translate('phone_number');
  String get saveChanges => translate('save_changes');
  String get profileUpdatedSuccessfully => translate('profile_updated_successfully');
  String get totalDonated => translate('total_donated');
  String get loading => translate('loading');
}

class _AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  const _AppTranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppTranslations> load(Locale locale) async {
    return AppTranslations(locale);
  }

  @override
  bool shouldReload(_AppTranslationsDelegate old) => false;
}

