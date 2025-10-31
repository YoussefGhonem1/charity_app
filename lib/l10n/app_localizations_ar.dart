// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق الخير';

  @override
  String hello(Object userName) {
    return 'مرحبًا، $userName';
  }

  @override
  String donated(Object amount) {
    return 'تم التبرع بـ $amount';
  }

  @override
  String get donationWallet => 'محفظة التبرعات';

  @override
  String get topUp => 'شحن';

  @override
  String get transactions => 'المعاملات';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get donateAsAnonymous => 'التبرع كمجهول';

  @override
  String get inviteFriends => 'دعوة الأصدقاء';

  @override
  String get settings => 'الإعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get aboutApp => 'عن التطبيق';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get language => 'اللغة';

  @override
  String get logOutDialogTitle => 'تسجيل الخروج';

  @override
  String get logOutDialogMessage => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get home => 'الرئيسية';

  @override
  String get favourite => 'المفضلة';

  @override
  String get categories => 'التصنيفات';

  @override
  String get account => 'الحساب';

  @override
  String get loggedOutSuccessfully => 'تم تسجيل الخروج بنجاح';

  @override
  String get featureCampaign => 'حملة مميزة';

  @override
  String get latestCampaign => 'أحدث الحملات';

  @override
  String get locations => 'المواقع';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get allCategories => 'جميع التصنيفات';

  @override
  String get allLocations => 'جميع المواقع';

  @override
  String get helloNoName => 'مرحبًا';

  @override
  String get dangerZone => 'منطقة الخطر';

  @override
  String get about => 'حول';

  @override
  String get enabled => 'مفعّل';

  @override
  String get disabled => 'معطّل';

  @override
  String get openPrivacyPolicy => 'فتح سياسة الخصوصية';

  @override
  String get loggedOut => 'تم تسجيل الخروج';

  @override
  String languageSetTo(Object language) {
    return 'تم تعيين اللغة إلى $language';
  }
}
